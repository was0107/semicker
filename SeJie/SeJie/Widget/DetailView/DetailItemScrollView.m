//
//  DetailItemScrollView.m
// sejieios
//
//  Created by allen.wang on 1/15/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "DetailItemScrollView.h"
#import "ListDetailRequest.h"
#import "ListCommentsRequest.h"
#import "ListDetailResponse.h"
#import "ListCommentsResponse.h"
#import "UIView+extend.h"
#import "CreateObject.h"
#import "SNSShareViewController.h"
#import "UIImage+extend.h"
#import "ListAddCommentRequest.h"
#import "NSDate+extend.h"
#import "UserDefaultsManager.h"
#import "CustomShareViewController.h"
#import "UserHomeViewController.h"
#import "RecordUtility.h"
#import "MainViewController.h"

@implementation DetailItemScrollView
@synthesize topView     = _topView;
@synthesize middleView  = _middleView;
@synthesize tableView   = _tableView;
@synthesize guessLabel  = _guessLabel;
@synthesize keyword     = _keyword;
@synthesize commentsView= _commentsView;
@synthesize responseItem= _responseItem;
@synthesize imageURLString= _imageURLString;
@synthesize contentView   = _contentView;
@synthesize viewController = _viewController;
@synthesize adapter        = _adapter;
@synthesize enableClickUser= _enableClickUser;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        [self.contentView addSubview:self.topView];
        [self addSubview:self.contentView];
        
        [self addSubview:self.commentsView];
        _staticHeight = kBoundsHeight - 60;
        [self.contentView setContentSize:CGSizeMake(320, kBoundsHeight )];//+ 556 - kMiddleGoodsHeight
        [self.topView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}


- (void) dealloc
{
    [self.topView removeObserver:self forKeyPath:@"frame"];
    [WASBaseServiceFace cancelServiceMethod:[URLMethod detail]];
    [WASBaseServiceFace cancelServiceMethod:[URLMethod comment]];
    [WASBaseServiceFace cancelServiceMethod:[URLMethod stamppic]];
    [WASBaseServiceFace cancelServiceMethod:[URLMethod addcomment]];

    TT_RELEASE_SAFELY(_topView);
    TT_RELEASE_SAFELY(_middleView);
    TT_RELEASE_SAFELY(_tableView);
    TT_RELEASE_SAFELY(_guessLabel);
    TT_RELEASE_SAFELY(_responseItem);
    TT_RELEASE_SAFELY(_contentView);
    TT_RELEASE_SAFELY(_keyword);
    TT_RELEASE_SAFELY(_commentsView);
    [super dealloc];
}

- (void) resetData
{
    [self.contentView setContentOffset:CGPointZero animated:NO];
    [WASBaseServiceFace cancelServiceMethod:[URLMethod detail]];
    [WASBaseServiceFace cancelServiceMethod:[URLMethod comment]];
    [WASBaseServiceFace cancelServiceMethod:[URLMethod stamppic]];
    [WASBaseServiceFace cancelServiceMethod:[URLMethod addcomment]];

    self.middleView.contents = nil;
    [self.topView setFrameHeight:420];
    [self.middleView setFrameHeight:0];
    [self.tableView setFrameHeight:0];
    [self.guessLabel removeFromSuperview];
    [self.middleView removeFromSuperview];
    [self.tableView removeFromSuperview];
    [self.topView resetData];
    [self.commentsView emptyContentData];
    [self computePosition];
}

- (void) setEnableClickUser:(BOOL)enableClickUser
{
    _enableClickUser = enableClickUser;
    self.topView.enableClickUser = _enableClickUser;
}


- (void) setImageURLString:(NSString *)imageURLString
{
    _imageURLString = imageURLString;
    _topView.imageURLString  = _imageURLString;
}

- (void) setResponseItem:(ListSeiJieItem *)responseItem
{
    if (_responseItem != responseItem) {
        [_responseItem release];
        _responseItem = [responseItem retain];
        
        _topView.content = _responseItem;
    }
}

- (BOOL) sendRequestToServerEx
{
    __block DetailItemScrollView *blockSelf = self;
    
    if (blockSelf.responseItem.detailResponse && ![blockSelf.responseItem.detailResponse isEmpty]) {
        _middleView.contents = ((ListDetailResponse *)blockSelf.responseItem.detailResponse).result;
        _topView.detailContent = ((ListDetailResponse *)blockSelf.responseItem.detailResponse).detailItem;
        if ([_middleView.contents count]) {
            [blockSelf.contentView addSubview:blockSelf.middleView];
            [blockSelf.contentView addSubview:blockSelf.guessLabel];
            [blockSelf computePosition];
        } else {
            _middleView.contents = nil;
        }
        return YES;
    }
    return NO;
}

- (void) sendRequestToServer
{
    __block DetailItemScrollView *blockSelf = self;
    
    ListDetailRequest *detail = [[[ListDetailRequest alloc] init] autorelease];
    detail.docid = _responseItem.docid;
    detail.label = _responseItem.label;
    detail.userid = _responseItem.userid;
    detail.usertype = _responseItem.userType;
    detail.content = _responseItem.content;
    detail.keyword  = self.keyword;
    detail.labelname= _responseItem.labelname;
    
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@"DETAIL content = %@", content);
        ListDetailResponse *response = [[[ListDetailResponse alloc] initWithJsonString:content] autorelease];
        if (![response isEmpty]){
            [blockSelf.contentView addSubview:blockSelf.middleView];
            [blockSelf.contentView addSubview:blockSelf.guessLabel];
            blockSelf.responseItem.detailResponse = response;
            _middleView.contents = response.result;
            
            [blockSelf computePosition];
            
            if (response.result.count > 0) {
                [[DataTracker sharedInstance] trackEvent:_adapter.imageGoodsPV withLabel:@"" category:TD_EVENT_Category];
                if (_contentView.y < 0) {
                    [_contentView setContentOffset:CGPointMake(0, _middleView.y + _contentView.y) animated:YES];
                    [blockSelf computePosition];
                }
            }
        }
        _topView.detailContent = response.detailItem;
    };
    
    idBlock failedBlock = ^(id content)
    {
        ERRLOG(@"DETAIL error = %@", content);
        [_middleView setFrameHeight:0];
    };
    
    [WASBaseServiceFace serviceWithMethod:[URLMethod detail]
                                     body:[detail toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
    
}

- (BOOL) sendCommentsToServerEx
{
    __block DetailItemScrollView *blockSelf = self;
    if (blockSelf.responseItem.commentResponse) {
        _tableView.contentArray = ((ListCommentsResponse *)blockSelf.responseItem.commentResponse).result;
        [blockSelf.contentView addSubview:blockSelf.tableView];
        return YES;
    }
    return NO;
}

- (void) sendCommentsToServer
{
    __block DetailItemScrollView *blockSelf = self;
    ListCommentsRequest *commentRequest = [[[ListCommentsRequest alloc] init] autorelease];
    commentRequest.docid = _responseItem.docid;
    
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@"COMMENTS content = %@", content);
        ListCommentsResponse *response = [[[ListCommentsResponse alloc] initWithJsonString:content] autorelease];
        _tableView.contentArray = response.result;
        blockSelf.responseItem.commentResponse = response;
        [blockSelf.contentView addSubview:blockSelf.tableView];
    };
    
    idBlock failedBlock = ^(id content)
    {
        ERRLOG(@"COMMENTS error = %@", content);
        [blockSelf.contentView addSubview:blockSelf.tableView];
        _tableView.contentArray = nil;
    };
    
    [WASBaseServiceFace serviceWithMethod:[URLMethod comment]
                                     body:[commentRequest toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];
}

- (void) computePosition
{
    [_middleView setFrameHeight: (!_middleView.contents) ? 0 : kMiddleGoodsHeight];
    int height = [self.topView getContentHeight];
    CGSize size = CGSizeMake(320, height + self.middleView.height + self.tableView.height + kCommentsBottomHeight);
    if (size.height < self.contentView.height) {
        size.height = self.contentView.height + 4;
    } else {
        size.height += 4;
    }
    [self.contentView setContentSize:size];
    [[self guessLabel] setFrameY:(height + 5)];
    [[self middleView] setFrameY:height + 1];
    [[self tableView] setFrameY:(height + _middleView.height)];
    [self scrollViewDidScroll:self.contentView];
}

- (void) scrollToCommentsPosition:(id) content
{
    [[self contentView] setContentOffset:CGPointMake(0, [_tableView computeHeight:content] + _contentView.contentOffset.y + 26)];
}

- (void) addCommentToServer:(NSString *) content
{
    __block DetailItemScrollView *blockSelf = self;
    NSString *userName = [UserDefaultsManager userName];
    if ([userName length] == 0) {
        userName = @"匿名";
    }
    
    ListAddCommentRequest *request = [[[ListAddCommentRequest alloc] initWithDocID:_responseItem.docid
                                                                            userID:[UserDefaultsManager userId]
                                                                           comment:content
                                                                              item:_responseItem] autorelease];
    
//    request.touserid    = _responseItem.userid;
//    request.tousername  = _responseItem.username;
//    request.target      = _responseItem.img;
//    request.label       = _responseItem.label;
//    request.username    = [UserDefaultsManager userName];
//    
//    request.usertype    = _responseItem.userType;
//    request.keyword     = _responseItem.keyword;
//    request.content     = _responseItem.content;
//    request.labelnames  = _responseItem.labelname;
//    request.title       = _responseItem.title;
    
    
    ListCommentItem *comentItem = [[[ListCommentItem alloc] init] autorelease];
    comentItem.username = userName;
    comentItem.text = content;
    comentItem.time = [[NSDate date] relativeDateString];
    
    
    idBlock successedBlock = ^(id content)
    {
        DEBUGLOG(@"add comments content = %@", content);
        if (_tableView.contentArray) {
            [_tableView.contentArray insertObject:comentItem atIndex:0];
            [_tableView setContentArray:_tableView.contentArray];
        } else {
            _tableView.contentArray = [NSMutableArray arrayWithObject:comentItem];
        }
        
        if (!_tableView.superview) {
            [_contentView addSubview:_tableView];
        }
        [blockSelf computePosition];
        [blockSelf scrollToCommentsPosition:(id) content];
    };
    
    idBlock failedBlock = ^(id content)
    {
        ERRLOG(@"add comments error = %@", content);
    };
    
    [WASBaseServiceFace serviceWithMethod:[URLMethod addcomment]
                                     body:[request toJsonString]
                                    onSuc:successedBlock
                                 onFailed:failedBlock
                                  onError:failedBlock];

}

- (UIScrollView *) contentView
{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentView.delegate = self;
    }
    return _contentView;
}

- (DetailTopView *) topView
{
    if (!_topView) {
        _topView = [[DetailTopView alloc] initWithFrame:CGRectMake(0, 0, 320, 420)];
        _topView.enableClickUser = self.enableClickUser;
        __block DetailItemScrollView *blockSelf = self;
        _topView.shareBlock = ^(id content) {
            SNSShareViewController *shareController = [[[SNSShareViewController alloc] init] autorelease];
            [shareController setShareImage:((UIImage *)content)];
            [shareController setItemData:_responseItem];
            [blockSelf.viewController.navigationController pushViewController:shareController animated:YES];
        };
        
        _topView.userBlock = ^(id content) {
            ListSeiJieItem *item = (ListSeiJieItem *) content;
            NSArray * controllers = [blockSelf.viewController.navigationController viewControllers];
            for (int total = [controllers count] - 1; total >= 0; total--) {
                
                UIViewController *controllerTmp = [controllers objectAtIndex:total];
                if ([controllerTmp isKindOfClass:[UserHomeViewController class]]) {
                    UserHomeViewController *homeController = (UserHomeViewController *)controllerTmp;
                    ListSeiJieItem *itemTmp = (ListSeiJieItem *)homeController.userCenterView.content;
                    if ([item.userid isEqualToString:itemTmp.userid]) {
                        [blockSelf.viewController.navigationController popToViewController:controllerTmp animated:YES];
                        return ;
                    }
                }
                
                if ([controllerTmp isKindOfClass:[MainViewController class]]) {
                    MainViewController *mainViewController = (MainViewController *)controllerTmp;
                    if ([item.userid isEqualToString:mainViewController.userCenterView.userID] && [mainViewController isUserCenterView]) {
                        [blockSelf.viewController.navigationController popToViewController:controllerTmp animated:YES];
                        return ;
                    }
                }
            }
            
            UserHomeViewController *controller = [[[UserHomeViewController alloc] init] autorelease];
            [controller updateWithItem:item];
            [blockSelf.viewController.navigationController pushViewController:controller animated:YES];
            
        };
        
    }
    return _topView;
}

- (DetailMiddleView *) middleView
{
    if (!_middleView) {
        _middleView = [[DetailMiddleView alloc] initWithFrame:CGRectMake(0, 420, 320, 0)];
        [_middleView addBackgroundImage:@"goods_background"];
        __block DetailItemScrollView *blockSelf = self;
        _middleView.itemBlock = ^(id content) {
            ListGoodsItem *item = (ListGoodsItem *) content;
            if (item && item.docid) {
                [[DataTracker sharedInstance] trackEvent:_adapter.imageGoodsMC
                                               withLabel:item.title
                                                category:TD_EVENT_Category];
                //CommodityDetailViewController *detail = [[[CommodityDetailViewController alloc] initWithDocID:item.docid withType:([item.type isEqualToString:@"tuan"] ? 1 : 0)] autorelease];
                CommodityDetailViewController *detail = [[[CommodityDetailViewController alloc] initWithGoodsItem:item] autorelease];
                detail.cpsEvent = _adapter.imageGoodsCPS;
                [blockSelf.viewController.navigationController pushViewController:detail animated:YES];
            }
        };
    }
    return _middleView;
}

- (DetailCommentsView *) commentsView
{
    if (!_commentsView) {
        _commentsView = [[DetailCommentsView alloc] initWithFrame:kCommentsBottomFrame];
        __block DetailItemScrollView *blockSelf = self;
        _commentsView.commitBlock = ^(id content) {
            [blockSelf addCommentToServer:content];
        };
    }
    return _commentsView;
}

- (UILabel *) guessLabel
{
    if (!_guessLabel) {
        
        _guessLabel = [[CreateObject titleLabel] retain];
        _guessLabel.frame = CGRectMake(8, 425, 80, 22);
        _guessLabel.font = TNRFontSIZEBIG(kFontSize14);
        _guessLabel.textColor = kDarkGrayColor;
        _guessLabel.text = @"猜你喜欢";
    }
    return _guessLabel;
}

- (CommentsTableView *) tableView
{
    if (!_tableView) {
        
        _tableView = [[CommentsTableView alloc] initWithFrame:CGRectMake(0, 556 - kMiddleGoodsHeight, 320, 0) //kBoundsHeight-20
                                                        style:UITableViewStylePlain
                                                         type:eTypeNone
                                                     delegate:nil];
        __block DetailItemScrollView *blockSelf = self;
        _tableView.block = ^(id content) {
            [blockSelf computePosition];
        };
    }
    return _tableView;
}

- (void) setAdapter:(SheJieAdapterBase *)adapter
{
    _adapter = adapter;
    self.topView.adapter = adapter;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY =  _middleView.y + _middleView.height - scrollView.contentOffset.y + 3 + _contentView.y ;
    if ( offsetY > _staticHeight ) {
        [_commentsView setFrameY:offsetY];
    } else {
        [_commentsView setFrameY:_staticHeight  + _contentView.y];
    }
}

#pragma mark -

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    __block DetailItemScrollView *blockSelf = self;
    [UIView animateWithDuration:AnimateTime.SHORT
                     animations:^{
                         [blockSelf computePosition];
                     }];
}
@end
