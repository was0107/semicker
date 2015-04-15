//
//  ListGuangRequest.h
// sejieios
//
//  Created by allen.wang on 12/27/12.
//  Copyright (c) 2012 allen.wang. All rights reserved.
//

#import "ListPaggingRequestBase.h"

@interface ListGuangRequest : ListPaggingRequestBase

@property (nonatomic, assign)   NSUInteger      group;      //(int): １：明确指示需要group支持, 0:明确指示不要（除非pageno为０或１）
@property (nonatomic, copy)     NSString        *keywords;  //*(String)：关键字（支持空格分离，默认条件是and）
@property (nonatomic, copy)     NSString        *keywords2;  //*(String)：关键字（支持空格分离，默认条件是and）
@property (nonatomic, retain)   NSMutableArray  *categorys; //(Object)：分类
@property (nonatomic, retain)   NSMutableArray  *sources;   //(Array)：供应商
@property (nonatomic, retain)   NSMutableArray  *brands;    //(Array):品牌
@property (nonatomic, retain)   NSString        *price;     //(Object):价格区间，大于等于min及小于等于max，若指定一个，则采用其中一个功能 //	min //	max
@property (nonatomic, retain)   NSMutableArray  *sort;      //(Array); //　　排序功能 //	property(String) 取值{“Price” , “Score”}  //	order(String)  取值{”ASC”, ”DESC”}
@property (nonatomic, assign)   BOOL            barcodeflag;


@end
