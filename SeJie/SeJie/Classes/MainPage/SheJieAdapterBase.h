//
//  SheJieAdapterBase.h
// sejieios
//
//  Created by allen.wang on 1/5/13.
//  Copyright (c) 2013 allen.wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListSheJieRequestBase.h"

@interface SheJieAdapterBase : NSObject
{
    UITableView             *_tableView;
    ListPaggingRequestBase  *_request;
}

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *keyWord;

@property (nonatomic, copy) NSString *responseClass;

@property (nonatomic, copy) NSString *modelClass;

@property (nonatomic, copy) NSString *method;

@property (nonatomic, copy) voidBlock headerBlock;

@property (nonatomic, copy) idBlock itemBlock;

@property (nonatomic, copy) idBlock cellBlock;

@property (nonatomic, assign) BOOL  rightButtonHidden;

@property (nonatomic, assign) NSUInteger tipType;

@property (nonatomic, assign) BOOL  showArrow;

@property (nonatomic, retain) ListPaggingRequestBase *request;

@property (nonatomic, copy) NSString *pageViewId;

@property (nonatomic, copy) NSString *refreshPV;
@property (nonatomic, copy) NSString *imagePV;
@property (nonatomic, copy) NSString *imageSavePV;
@property (nonatomic, copy) NSString *imageLikePV;
@property (nonatomic, copy) NSString *imageSharePV;
@property (nonatomic, copy) NSString *imageUserPV;
@property (nonatomic, copy) NSString *imageGoodsPV;
@property (nonatomic, copy) NSString *imageGoodsMC;
@property (nonatomic, copy) NSString *imageGoodsCPS;


- (UITableView *) tableView;

- (void) setContentData;

- (void) setTableView:(UITableView *) tableView;

- (void) emptyContents;

- (void) sendRequestToServer;

- (void) actionBeforeCome;

- (void) actionNoLeave;

- (void) actionAfterLeave;

- (UIView *) contentView;

- (void) removeTopButton;

@end
