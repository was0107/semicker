//
//  CustomShareViewController.m
// sejieios
//
//  Created by allen.wang on 1/24/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "CustomShareViewController.h"
#import "CustomShareViewController_Private.h"
#import "MainDetailViewController.h"

@implementation CustomShareViewController
@synthesize name        = _name;
@synthesize content     = _content;
@synthesize adapter     = _adapter;
@synthesize tableView   = _tableView;
@synthesize shareType   = _shareType;

- (id) initWithType:(int) type  userName:(NSString *) name
{
    self = [super init];
    if (self) {
        self.pageViewId = TD_PAGE_USERCENTER_SHARE;
        self.name      = name;
        self.shareType = type;
        [self.view addSubview:[self tableView]];
        [self sendMessageToServer];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareSucceed:) name:kShareSuccessNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.titleView addSubview:[self leftButton]];
}

- (void) reduceMemory
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    TT_RELEASE_SAFELY(_tableView);
    TT_RELEASE_SAFELY(_adapter);
    TT_RELEASE_SAFELY(_name);
    TT_RELEASE_SAFELY(pickerController);
    [super reduceMemory];
}

- (UIButton *) leftButton
{
    UIButton *leftButton = [super leftButton];
    if (leftButton) {
        [leftButton setNormalImage:kMainBackIconImage selectedImage:kMainBackIconHlImage];
    }
    return leftButton;
}

- (IBAction)leftButtonAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rightButtonAction:(id)sender
{
    if (!pickerController) {
        pickerController = [[CustomPickerViewController alloc] init];
        [pickerController setCustomImagePickerDelegate:self];
    }
    [self.navigationController presentViewController:pickerController animated:YES completion:nil];
}

- (void) shareSucceed:(NSNotification *)notification
{
    //[self. navigationController popToRootViewControllerAnimated:YES];
    [self sendMessageToServer];
}

- (void) sendMessageToServer
{
    [self.adapter sendRequestToServer];
}

- (void) setContent:(id)content
{
    if (_content != content) {
        _content = content;
        [[[self adapter] adapterUserAccount] setItem:content];
    }
}

- (void) setShareType:(int)shareType
{
    _shareType = shareType;
    switch (_shareType)
    {
        case eCustomAccountShare:
        {
            [[self titleLabel] setText:kTitleMyShareString];
            [[self adapter] setCurrentType:eSheJieCustomAccount];
            [[self adapter] changeToShare];
            [self.rightButton setNormalImage:kMainCameraIconImage hilighted:kMainCameraIconHlImage selectedImage:kMainCameraIconHlImage];
            [self.titleView addSubview:[self rightButton]];
        }
            break;
        case eCustomAccountLike:
        {
            [[self titleLabel] setText:kTitleMyLikeString];
            [[self adapter] setCurrentType:eSheJieCustomAccount];
            [[self adapter] changeToLike];
//            [self.rightButton setNormalImage:kMainCameraIconImage hilighted:kMainCameraIconHlImage selectedImage:kMainCameraIconHlImage];
//            [self.titleView addSubview:[self rightButton]];
        }
            break;
        case eOtherAccountLike:
        {
            [[self titleLabel] setText:kUserLikeString(self.name)];
            [[self adapter] setCurrentType:eSheJieOtherAccount];
            [[self adapter] changeToLike];
        }
            break;
        default:
        case eOtherAccountShare:
        {
            [[self titleLabel] setText:kUserShareString(self.name)];
            [[self adapter] setCurrentType:eSheJieOtherAccount];
            [[self adapter] changeToShare];
        }
            break;
    }
}

- (SheJieAdapterManagerEx *) adapter
{
    if (!_adapter) {
        _adapter = [[SheJieAdapterManagerEx alloc] initWithSuperView:self.view
                                                           titleView:self.titleLabel];
    }
    return _adapter;
}

- (MainTableView *) tableView
{
    if (!_tableView) {
        _tableView = [[MainTableView alloc] initWithFrame:kContentWithBarFrame
                                                    style:UITableViewStylePlain
                                                     type:(eTypeHeader | eTypeFooter)
                                                 delegate:nil];
        [self.adapter setNetTableView:_tableView];
        [self addItemsBlock];
    }
    return _tableView;
}

// 列表项的点击事件
- (id) addItemsBlock
{
    __block CustomShareViewController *blockSelf = self;
    idBlock itemBlock = ^(id content) {
        /*
        MainDetailViewController *detail = [[[MainDetailViewController alloc] init] autorelease];
        detail.adapter = _adapter.currentAdapter;
        [blockSelf.navigationController pushViewController:detail animated:YES];
        detail.responseItem = content;
        detail.keyword = [_adapter getKeyword];
        detail.contents = _tableView.response.result;
        detail.enableClickUser = YES;
        // 图片查看 PV
        [[DataTracker sharedInstance] trackEvent:_adapter.currentAdapter.imagePV
                                       withLabel:detail.responseItem.label
         category:TD_EVENT_Category];
         */
    };
    [self.adapter currentAdapter].cellBlock = itemBlock;
    return self;
}


#pragma mark ==
#pragma mark == UIImagePickerControllerDelegate

- (void)customImagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    DEBUGLOG(@"didFinishPickingImage  image = %@",image);
    [picker.navigationController setNavigationBarHidden:YES];
    B5MShareViewController *share = [[[B5MShareViewController alloc] init] autorelease];
    [share setShareImage:image];
    [picker pushViewController:share animated:YES];
}

- (void) rebackFromPhoto:(UIImagePickerController *)picker
{
    [self.navigationController presentViewController:pickerController animated:YES completion:nil];
}


@end
