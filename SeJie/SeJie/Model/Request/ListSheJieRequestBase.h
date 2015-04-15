//
//  ListSheJieRequestBase.h
// sejieios
//
//  Created by allen.wang on 1/8/13.
//  Copyright (c) 2013 B5M. All rights reserved.
//

#import "ListPaggingRequestBase.h"

@interface ListSheJieRequestBase : ListPaggingRequestBase

@end



@interface ListSheJieNormalRequest : ListPaggingRequestBase

@end


@interface ListSheJieExplorerRequest : ListPaggingRequestBase
@property (nonatomic, copy) NSString   *label;
@property (nonatomic, copy) NSString   *labelTwo;
@property (nonatomic, copy) NSString   *labelThree;

@end
