//
//  SheJieAdapterManagerBase.h
// sejieios
//
//  Created by allen.wang on 1/24/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageLabel.h"
#import "SheJieAdapterBase.h"

@interface SheJieAdapterManagerBase : NSObject
{
    NSUInteger      oldType;
    UIView          *_superView;
    UIImageLabel    *_titleView;
}
@property (nonatomic, assign) NSInteger  currentType;

- (id) initWithSuperView:(UIView *) superView titleView:(UIImageLabel *) titleView;

- (void) setTitleText:(NSString *)title;

- (void) exchangeTitle:(NSString *)title showImage:(BOOL)show;

- (SheJieAdapterBase *) currentAdapter;

- (SheJieAdapterBase *) adapterAt:(NSUInteger) type;

- (id) changeTypeTo:(int)type;

- (NSString *) getKeyword;

- (void) sendRequestToServer;

- (id) setNetTableView:(UITableView *) tableView;

@end

