//
//  MainTableView.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "B5MTableViewBase.h"
#import "ListGuangRequest.h"
#import "ListGuangResponse.h"
#import "LayoutCellModel.h"
#import "SheJieAdapterBase.h"


@interface MainTableView : B5MTableViewBase
{
    __block NSInteger _updateTimes;
}
@property (nonatomic, retain) ListRequestBase           *request;
@property (nonatomic, retain) LayoutCellModel           *cellModel;
@property (nonatomic, retain) SheJieAdapterBase         *adapterBase;
@property (nonatomic, retain) ListPaggingResponseBase   *response;
@property (nonatomic, assign) NSInteger                 updateTimes;
@property (nonatomic, assign) BOOL                      isUpdate;
@property (nonatomic, retain) UIButton                  *toTopButton;

@property (nonatomic, assign) BOOL                      allowTopButton;

- (void) emptyData;

- (void) doNormalUpdateRequest;

- (void) doFirstRequest;

@end
