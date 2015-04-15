//
//  UserCenterView.h
// sejieios
//
//  Created by Jarry on 13-1-22.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "UserCountButton.h"
#import "UserHeaderView.h"
#import "ListUserRecordRequest.h"
#import "ListUserRecordResponse.h"
#import "WASScrollViewDecorate.h"

@interface UserCenterView : UIView <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,WASScrollViewDecorateDelegate>
{
    BOOL    isLoading;
}

@property (nonatomic, retain)   UIImageView     *headerImageView;
@property (nonatomic, retain)   UIImageView     *footerImageView;
//@property (nonatomic, retain)   UIView          *viewContent;
@property (nonatomic, retain)   UserHeaderView  *userHeader;
@property (nonatomic, assign)   UIViewController*controller;
@property (nonatomic, retain)   UITableView     *tableView;
@property (nonatomic, retain)   UserCountButton *likeButton;
@property (nonatomic, retain)   UserCountButton *shareButton;
@property (nonatomic, retain)   UIButton        *settingButton;
@property (nonatomic, assign)   id               content;
@property (nonatomic, assign)   BOOL             isFromOtherUser;
@property (nonatomic, retain)   UIButton          *toTopButton;

@property (nonatomic, retain)   UIView          *progressView;

@property (nonatomic, retain)   ListUserRecordRequest  *request;
@property (nonatomic, retain)   ListUserRecordResponse *response;
@property (nonatomic, copy  )   NSString               *userID;
@property (nonatomic, retain)   WASScrollViewDecorate *decorate;

@property (nonatomic, copy)     idBlock         itemBlock;

@property (nonatomic, retain)   NSMutableArray  * result;

- (void) clearData;

- (void) updateMyAccount;

- (void) updateAccount:(NSString *)userId userName:(NSString *)name userType:(NSString *)type;

- (void) showProgress;
- (void) dismissProgress;

@end
