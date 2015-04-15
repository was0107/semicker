//
//  MainTableView.m
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "MainTableView.h"
#import "LayoutTableViewCellBase.h"
#import "LayoutExplorerCell.h"
#import "SejieUpdateControl.h"
#import "ListSeiJieResponseBase.h"
#import "SejieUpdateRequest.h"
#import "SejieUpdateResponse.h"
#import "SheJieAdapterOtherAccount.h"
#import "UserDefaultsManager.h"
#import "UIButton+extend.h"
#import "LabelsManager.h"

@implementation MainTableView
@synthesize request     = _request;
@synthesize response    = _response;
@synthesize cellModel   = _cellModel;
@synthesize adapterBase = _adapterBase;
@synthesize isUpdate    = _isUpdate;
@synthesize toTopButton = _toTopButton;
@synthesize allowTopButton= _allowTopButton;

- (void) setupContentView
{
    _updateTimes = [UserDefaultsManager updateTimes];
    __block MainTableView  *blockSelf = self;
    self.refreshBlock = ^(id content) {
        
        // Refresh PV
        [[DataTracker sharedInstance] trackEvent:_adapterBase.refreshPV
                                       withLabel:@""
                                        category:TD_EVENT_Category];
        
        if ([_adapterBase.method isEqualToString:[URLMethod normal]])
        {
            [blockSelf doNormalUpdateRequest];
            return;
        }
        
        [blockSelf hideEmtpyView];
        [(ListPaggingRequestBase *)_adapterBase.request firstPage] ;
        [blockSelf sendRequestToServer];
    };
    self.loadMoreBlock = ^(id content) {
        if(blockSelf.response) {
            [(ListPaggingRequestBase *)_adapterBase.request nextPage] ;
            [blockSelf sendRequestToServer];
        }
    };
    
    self.allowTopButton = YES;
    
}

- (void) didMoveToSuperview
{
    if (self.allowTopButton) {
        if (self.superview) {
            [self.superview addSubview:[self toTopButton]];
        } else {
            [[self toTopButton] removeFromSuperview];
        }
    }
}

- (void) doNormalUpdateRequest
{
    NSInteger count = [[SejieUpdateControl sharedInstance] updateCount];
    if (count == 0) {
        [self tableViewDidFinishedLoading];
        [[NSNotificationCenter defaultCenter] postNotificationName:kSejieUpdateSuccessNotification object:nil];
    }
    else {
        NSInteger updates = (count > 50) ? 50 : count; //(int)((count + 9) / 10 ) * 10;
        [self sendUpdateRequest:updates];
    }
    
    
    /*
    else if (count > 10 && count < 50) {
        NSInteger updates = (count%10 > 0) ? ((int)(count/10+1) *10) : count;
        [self sendUpdateRequest:updates];
    }
    else {
        [self hideEmtpyView];
        [(ListPaggingRequestBase *)_adapterBase.request firstPage] ;
        [self sendRequestToServer];
        self.isUpdate = YES;
    }
     */
}

- (void) doFirstRequest
{
    [self hideEmtpyView];
    self.totalCount = 0;
    __block MainTableView *blockSelf = self;
    [self prepareToRefresh:^{
        [blockSelf sendRequestToServer];
    }];
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_request);
    TT_RELEASE_SAFELY(_response);
    TT_RELEASE_SAFELY(_cellModel);
    TT_RELEASE_SAFELY(_toTopButton);
    TT_RELEASE_SAFELY(_adapterBase);
    [super dealloc];
}

- (void) sendUpdateRequest:(NSInteger)size
{
    __block MainTableView *blockSelf = self;
    idBlock successedBlock = ^(id content)
    {
        //DEBUGLOG(@"content = %@", content);
        [blockSelf tableViewDidFinishedLoading];
        
        SejieUpdateResponse *updateResponse = [[[SejieUpdateResponse alloc] initWithJsonString:content] autorelease];
        
        DEBUGLOG(@">>>>>>>>>> update Sejie success !!\n >>>>>>>>>>  update = %d", updateResponse.result.count);
        for (int i=0; i<updateResponse.result.count; i++) {
            [blockSelf.cellModel.contentArray insertObject:[updateResponse.result objectAtIndex:i] atIndex:0];
        }
        [blockSelf.cellModel resetData];
        [blockSelf.cellModel computePosition];
        blockSelf.contentArray = self.cellModel.typeArray;
        blockSelf.totalCount = blockSelf.contentArray.count;
        [blockSelf reloadData];
        [blockSelf setContentOffset:CGPointMake(0, 0) animated:YES];
        

        if (_updateTimes >= [updateResponse.times integerValue]) {
            [[SejieUpdateControl sharedInstance] stopTimer];
        } else {
            [[SejieUpdateControl sharedInstance] startTimer];
            _updateTimes = [updateResponse.times integerValue];
            [UserDefaultsManager saveUpdateTimes:_updateTimes];
        }
        //精彩色界更新成功 发送通知 当前更新数清空
        if ([SejieUpdateControl sharedInstance].updateCount > 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kSejieUpdateSuccessNotification object:[[SejieUpdateControl sharedInstance] getCountString]];
        }
        [[SejieUpdateControl sharedInstance] resetCount];
    };
    
    idBlock failedBlock = ^(id content)
    {
        [blockSelf dealWithDataError];
    };
    
    SejieUpdateRequest *updateRequest = [[[SejieUpdateRequest alloc] init] autorelease];
    updateRequest.size = size;
    updateRequest.time = MIN(_updateTimes, [UserDefaultsManager updateTimes]);
    [WASBaseServiceFace serviceWithMethod:[URLMethod normalUpdate]
                                     body:[updateRequest toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
    
}

- (void) sendRequestToServer
{
    __block MainTableView *blockSelf = self;
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@">>>>>>>>>> request success !\n content = %@\n>>>>>>>>>>  total = %d", content, self.totalCount);
//        DEBUGLOG(@"content = %@", content);
        [blockSelf tableViewDidFinishedLoading];

        if ([_adapterBase.request isFristPage]) {
            Class response = NSClassFromString(_adapterBase.responseClass);
            blockSelf.response = [[[response alloc] initWithJsonString:content] autorelease];
            
            NSInteger pageNo = ((ListSeiJieResponseBase*)blockSelf.response).realpageno;
            //DEBUGLOG(@">>>>>>>>>> %d", ((ListSeiJieResponseBase*)blockSelf.response).realpageno);
            if ((pageNo > 0)) {
                ((ListPaggingRequestBase *)_adapterBase.request).pageno = pageNo;
            }
            
            //精彩色界更新成功 发送通知 当前更新数清空
            if ([_adapterBase.method isEqualToString:[URLMethod normal]]) {
                
                if (_isUpdate && [SejieUpdateControl sharedInstance].updateCount > 0) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:kSejieUpdateSuccessNotification object:[[SejieUpdateControl sharedInstance] getCountString]];
                }
                [[SejieUpdateControl sharedInstance] resetCount];
                [[SejieUpdateControl sharedInstance] startTimer];
            }
            
        } else {
            [blockSelf.response appendPaggingFromJsonString:content];
            [blockSelf refreshData];
        }
        if ([blockSelf.response.result count] == 0) {
            [blockSelf showEmtpyView:_adapterBase.keyWord];
        }
        else {
            [blockSelf hideEmtpyView];
        }
        
        blockSelf.reachTheEndCount = _response.count + 1;
        blockSelf.didReachTheEnd = NO;[_response reachTheEnd];
        _adapterBase.request.max = [(ListSeiJieResponseBase*)_response maxId];
//        NSNumber *number = [NSNumber numberWithBool:[blockSelf.response reachTheEnd]];
        NSNumber *number = [NSNumber numberWithBool:NO];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDidReceiveDataFromServerNotification object:number];
    };
    
    idBlock failedBlock = ^(id content)
    {
        ERRLOG(@"error = %@", content);
        [blockSelf tableViewDidFinishedLoading];
        [blockSelf dealWithDataError];
        if (!blockSelf.response) {
            [blockSelf showEmtpyView:_adapterBase.keyWord];
        }
        NSNumber *number = [NSNumber numberWithBool:[blockSelf.response reachTheEnd]];
        [[NSNotificationCenter defaultCenter] postNotificationName:kDidReceiveDataFromServerNotification object:number];
    };
    _adapterBase.request.method = _adapterBase.method;
    [WASBaseServiceFace serviceWithMethod:[_adapterBase.request toJsonString]//_adapterBase.method
                                     body:nil//[_adapterBase.request toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
}


- (void) setResponse:(ListPaggingResponseBase *)response
{
    if (_response != response) {
        [_response release];
        _response = [response retain];
        Class model = NSClassFromString(_adapterBase.modelClass);
        self.cellModel = [[[model alloc] init] autorelease];
        self.cellModel.contentArray = _response.result;
        [self.cellModel computePosition];
        self.contentArray = self.cellModel.typeArray;
        [self reloadData];
    }
    
    self.reachTheEndCount = _response.count;
    self.didReachTheEnd = [_response reachTheEnd];
}

- (void) setAdapterBase:(SheJieAdapterBase *)adapterBase
{
    if (_adapterBase != adapterBase) {
        if (_adapterBase) {
            [WASBaseServiceFace cancelServiceMethod:_adapterBase.method];
        }
        [_adapterBase release];
        _adapterBase = [adapterBase retain];
        
    }
}

- (UIButton *) toTopButton
{
    if (!_toTopButton) {
        _toTopButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [_toTopButton setNormalImage:@"backup_to_top" selectedImage:nil];
        [_toTopButton setFrame:CGRectMake(260, self.height - 10, 44, 44)];
        [_toTopButton addTarget:self action:@selector(gotoTop:) forControlEvents:UIControlEventTouchUpInside];
        [_toTopButton setHidden:NO];
    }
    return _toTopButton;
}

- (IBAction)gotoTop:(id)sender
{
    if (self.totalCount != 0)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void) emptyData
{
    [self hideEmtpyView];
    _response = nil;
    [_adapterBase.request firstPage];
    self.totalCount = 0;
    [self.cellModel resetData];
    [self reloadData];
}

- (void) refreshData
{
    [self.cellModel computePosition];
    [super refreshData];
}

- (void) doSendRequest:(BOOL) flag
{
    if (flag) {
        self.response = nil;
        [self.cellModel resetData];
    }
    [self hideEmtpyView];
    [super doSendRequest:flag];
}

- (void) showEmtpyView:(NSString *)title
{
    [self.toTopButton setHidden:YES];
    if (eTipTypeNormal == _adapterBase.tipType) {
        [super showEmtpyView:title];
    } else if (eTipTypeCustom == _adapterBase.tipType) {
        [super showShareEmtpyView];
    } else {
        [super showShareNoErr];
    }
    // 404 PV
    [[DataTracker sharedInstance] trackEvent:TD_EVENT_404_PV withLabel:title category:TD_EVENT_Category];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [super scrollViewDidScroll:scrollView];
    
    if (self.allowTopButton) {
        if (self.contentOffset.y > kBoundsHeight) {
            [self.toTopButton setHidden:NO];
        } else {
            [self.toTopButton setHidden:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LayoutCellModelBase *item = [self.contentArray objectAtIndex:indexPath.row];
    return [item itemsHeight] * kLayoutCellItemtHeight + 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"_CELL";
    LayoutNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[[LayoutNormalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    cell.layoutType = [self.contentArray objectAtIndex:indexPath.row];
    cell.block = _adapterBase.cellBlock;
    return cell;
}

- (void)tableViewDidStartRefreshing:(WASScrollViewDecorate *)tableView
{
    if (self.refreshBlock)
    {
        self.refreshBlock(nil);
    }
}

@end
