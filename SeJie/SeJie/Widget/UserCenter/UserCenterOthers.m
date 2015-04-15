//
//  UserCenterOthers.m
// sejieios
//
//  Created by Jarry on 13-2-6.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserCenterOthers.h"
#import "UserRecordItem.h"
#import "UserCenterTableCell.h"
#import "LayoutTableViewCellBase.h"

@implementation UserCenterOthers

@synthesize tagImageView    = _tagImageView;
@synthesize emptyTipView    = _emptyTipView;
@synthesize photoRequest    = _photoRequest;
@synthesize photoResponse   = _photoResponse;
@synthesize contentArray    = _contentArray;
@synthesize cellModel       = _cellModel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.tableView addSubview:[self photoTopView]];
                
    }
    return self;
}

- (void) dealloc
{
    TT_RELEASE_SAFELY(_tagImageView);
    TT_RELEASE_SAFELY(_emptyTipView);
    TT_RELEASE_SAFELY(_photoRequest);
    TT_RELEASE_SAFELY(_photoResponse);
    TT_RELEASE_SAFELY(_contentArray);
    TT_RELEASE_SAFELY(_cellModel);
    
    [super dealloc];
}

- (UIImageView *) headerImageView
{
    UIImageView *imageView = [super headerImageView];
    if (imageView) {
        [imageView setFrameHeight:500];
    }
    return imageView;
}

- (UIImageView *) tagImageView
{
    if (!_tagImageView) {
        _tagImageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_other_photo_tag"]] autorelease];
        _tagImageView.frame = CGRectMake(240, 8, 80, 30);
    }
    return _tagImageView;
}

- (UIImageView *) emptyTipView
{
    if (!_emptyTipView) {
        _emptyTipView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not_found_ex"]] autorelease];
        _emptyTipView.frame = CGRectMake(55, 60, 210, 64);
    }
    return _emptyTipView;
}

- (UIView *) photoTopView
{
    UIView *topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 210, 320, 40)] autorelease];
    topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMainBackGroundImage]];
    
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:kShareBottomBGImage]] autorelease];
    imageView.frame = CGRectMake(37, 10, 60, 12);
    [topView addSubview:imageView];
    
    UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(66, 0, 2, 10)] autorelease];
    lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_line_bg"]];
    [topView addSubview:lineView];

    [topView addSubview:self.tagImageView];
    
    return topView;
}

- (IBAction)gotoTop:(id)sender
{
    if (self.photoResponse.count != 0)
    {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void) requestRecordList:(NSString *)userId
{
    isLoading = YES;
    
    self.userID = userId;
    
    if (!self.request) {
        self.request  = [[[ListUserRecordRequest alloc] init] autorelease];
    }
    
    self.request.userid = userId;
    
    __block UserCenterOthers *blockSelf = self;
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@"content = %@", content);
        if ([blockSelf.request isFristPage]) {
            blockSelf.response = [[[ListUserRecordResponse alloc] initWithJsonString:content] autorelease];
            blockSelf.result = blockSelf.response.result;
            
            [blockSelf.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else
        {
            [blockSelf.response appendPaggingFromJsonString:content];
        }
        
        blockSelf.decorate.didReachTheEnd = [blockSelf.response reachTheEnd];
        [blockSelf.tableView reloadData];
        [[blockSelf decorate] tableViewDidFinishedLoading];
        
        //if (blockSelf.response.count == 0) {
            
            [blockSelf requestPhotoList];
            
        //}
        
        //[self.footerImageView setHidden:([self.response count] == 0) ? NO : ![self.response reachTheEnd]];
    };
    
    idBlock failedBlock = ^(id content)
    {
        ERRLOG(@"error = %@", content);
        [[blockSelf decorate] tableViewDidFinishedLoading];
    };
    
    [WASBaseServiceFace serviceWithMethod:[URLMethod recordsearch]
                                     body:[self.request toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
}

- (void) requestPhotoList
{
    isLoading = YES;
    
    __block UserCenterOthers *blockSelf = self;
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@"content = %@", content);
        isLoading = NO;
        [self dismissProgress];
        
        blockSelf.photoResponse = [[[ListAccountResponseBase alloc] initWithJsonString:content] autorelease];
        
    };
    
    idBlock failedBlock = ^(id content)
    {
        ERRLOG(@"error = %@", content);
        isLoading = NO;
        [self dismissProgress];
    };

    if (!self.photoRequest) {
        self.photoRequest = [[[ListAccountRequest alloc] init] autorelease];
    }
    ListSeiJieItem *item = (ListSeiJieItem *)self.content;
    self.photoRequest.userID = item.userid;
    self.photoRequest.userType = item.userType;
    [self.photoRequest firstPage];
    
    [WASBaseServiceFace serviceWithMethod:[URLMethod picsearch]
                                     body:[self.photoRequest toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
}

- (void) setPhotoResponse:(ListAccountResponseBase *)photoResponse
{
    if (_photoResponse != photoResponse) {
        [_photoResponse release];
        _photoResponse = [photoResponse retain];
        //Class model = NSClassFromString(_adapterBase.modelClass);
        self.cellModel = [[[LayoutCellShejieModel alloc] init] autorelease];
        self.cellModel.contentArray = _photoResponse.result;
        [self.cellModel computePosition];
        self.contentArray = self.cellModel.typeArray;
        [self.tableView reloadData];
    }
    
    //self.reachTheEndCount = _response.count;
    //self.didReachTheEnd = [_response reachTheEnd];
}

#pragma mark ==

- (void)tableViewDidStartRefreshing:(WASScrollViewDecorate *)tableView
{
    if (self.photoRequest && self.userID) {
        [self.photoRequest firstPage];
        [self requestPhotoList];
    }
}

- (void)tableViewDidStartLoading:(WASScrollViewDecorate *)tableView
{
    if (self.photoResponse) {
        [self.photoRequest nextPage];
        [self requestPhotoList];
    }
}

#pragma mark - UITableViewDataSource UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (self.result.count == 0) {
        LayoutCellModelBase *item = [self.contentArray objectAtIndex:indexPath.row];
        return [item itemsHeight] * kLayoutCellItemtHeight + 4;
        //return 130;
//    }
//    UserRecordItem *item = [self.result objectAtIndex:indexPath.row];
//    return item.imageHeight + 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [self.contentArray count]; //self.result.count > 0 ? self.result.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (self.result.count == 0) {
        /*static NSString *emptyIdentifier = @"emptyIdentifier";
        UITableViewCell *emptycell = [tableView dequeueReusableCellWithIdentifier:emptyIdentifier];
        if (!emptycell) {
            emptycell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:emptyIdentifier] autorelease];
            emptycell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:kShareBottomBGImage]] autorelease];
            imageView.frame = CGRectMake(37, 10, 60, 12);
            [emptycell addSubview:imageView];
            
            UIView *lineView = [[[UIView alloc] initWithFrame:CGRectMake(66, 0, 2, 10)] autorelease];
            lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_line_bg"]];
            [emptycell addSubview:lineView];
            
            [emptycell addSubview:self.tagImageView];
            
            [emptycell addSubview:self.emptyTipView];
        }
        return emptycell;*/
    
        if (self.photoResponse.count == 0 && !isLoading) {
            static NSString *emptyIdentifier = @"emptyIdentifier";
            UITableViewCell *emptycell = [tableView dequeueReusableCellWithIdentifier:emptyIdentifier];
            if (!emptycell) {
                emptycell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:emptyIdentifier] autorelease];
                emptycell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                [emptycell addSubview:self.emptyTipView];
            }
            return emptycell;
        }
        
        static NSString *identifier = @"photoIdentifier";
        LayoutNormalCell *photoCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!photoCell){
            photoCell = [[[LayoutNormalCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
            photoCell.block = self.itemBlock;
        }
        
        photoCell.layoutType = [self.contentArray objectAtIndex:indexPath.row];
        
        return photoCell;
    //}

    /*static NSString *normalIdentifier = @"normalIdentifier";
    UserCenterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:normalIdentifier];
    if (!cell) {
        cell = [[[UserCenterTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:normalIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.block = self.itemBlock;
    }
    
    [cell updateCellData:[self.result objectAtIndex:indexPath.row]];
    
    return cell;*/
}


@end
