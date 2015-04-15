//
//  LabelsManager.m
// sejieios
//
//  Created by Jarry on 13-1-7.
//  Copyright (c) 2013年 MICKER. All rights reserved.
//

#import "LabelsManager.h"
#import "SBJSON.h"
#import "UserDefaultsManager.h"

@implementation LabelsManager

@synthesize labelListData = _labelListData;
@synthesize currentItem   = _currentItem;

+ (LabelsManager *) sharedInstance
{
    static dispatch_once_t  onceToken;
    static LabelsManager * sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LabelsManager alloc] init];
        //sharedInstance.labelListData = [sharedInstance readDataFromPlist:@"labels"];
        sharedInstance.labelListData = [sharedInstance readDataFromJsonFile:eGenderMale];
        sharedInstance.currentItem = nil;
    });
    return sharedInstance;
}

- (LabelsManager *) init
{
    if ((self = [super init])) {
        //
        //_categoryList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_labelListData);
    [super dealloc];
}

- (NSMutableArray *) getMainLabelList
{
    NSMutableArray *array = [NSMutableArray array];

    for (LabelItem *data in _labelListData) {
        if (data.level == 0) {
            [array addObject:data];
        }
    }
    
    return array;
}

- (NSMutableArray *) getSubLabelList:(NSInteger)level title:(NSString *)title
{
    NSMutableArray *array = [NSMutableArray array];
    for (LabelItem *data in self.labelListData) {
        if (data.level == level && [data.superLabel isEqualToString:title]) {
            [array addObject:data];
        }
    }
    
    return array;
}

- (void) resetData:(NSInteger)gender
{
    self.labelListData = [self readDataFromJsonFile:gender];
}

- (void) setCurrentItem:(LabelItem *)currentItem {
    if (_currentItem != currentItem) {
        [_currentItem resetState];
        _currentItem = currentItem;
        _currentItem.isSelected  = YES;
    }
}


- (NSMutableArray *) readDataFromJsonFile:(NSInteger)gender
{
    gender = [UserDefaultsManager userGender];
    NSString *path = (gender==eGenderMale) ? kLabelJasonFileMale : kLabelJasonFileFemale;
    
    NSString *documentsDirectory = [[NSBundle mainBundle] resourcePath];
    
    NSString* jsonString = [NSString stringWithContentsOfFile:[documentsDirectory stringByAppendingPathComponent:path] usedEncoding:nil error:nil];
    SBJSON *json = [[[SBJSON alloc]init] autorelease];
    NSArray *arrayData = [json fragmentWithString:jsonString error:nil];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dic in arrayData) {
        
        LabelItem * item = [[[LabelItem alloc] init] autorelease];
        item.labelName = [dic objectForKey:@"key"];
        item.imageUrl = [dic objectForKey:@"image"];
        item.urlName = [dic objectForKey:@"urlname"];
        item.level = 0;
        
        NSArray *subData = [dic objectForKey:@"children"];
        for (NSDictionary *dicSub in subData) {
            
            LabelItem * subItem = [[[LabelItem alloc] init] autorelease];
            subItem.labelName = [dicSub objectForKey:@"key"];
            subItem.imageUrl = [dicSub objectForKey:@"image"];
            subItem.urlName = [dic objectForKey:@"urlname"];
            subItem.superLabel = item.labelName;
            subItem.level = 1;
            
            NSArray *thirdData = [dicSub objectForKey:@"children"];
            for (NSDictionary *third in thirdData) {
                LabelItem * thirdItem = [[[LabelItem alloc] init] autorelease];
                thirdItem.labelName = [third objectForKey:@"key"];
                thirdItem.imageUrl = [third objectForKey:@"image"];
                thirdItem.urlName = [third objectForKey:@"urlname"];
                thirdItem.superLabel = subItem.labelName;
                thirdItem.level = 2;
                
                [array addObject:thirdItem];
            }
            
            [array addObject:subItem];
        }
        
        [array addObject:item];
    }
    
    return array;
}


- (NSMutableArray *) readDataFromPlist:(NSString *)dicKey
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *documentsDirectory = [[NSBundle mainBundle] resourcePath];
    NSDictionary * data = [NSMutableDictionary dictionaryWithContentsOfFile:
                           [documentsDirectory stringByAppendingPathComponent:kLabelPlistName]];
    
    NSArray *arrayData = [data objectForKey:dicKey];
    for (NSDictionary *dic in arrayData) {
        
        LabelItem * item = [[[LabelItem alloc] init] autorelease];
        item.labelName = [dic objectForKey:@"name"];
        item.imageUrl = [dic objectForKey:@"image"];
        item.level = 0;
        //NSLog(@"===== name = %@", item.categoryName);
        
        NSArray *subData = [dic objectForKey:@"sub"];
        for (NSDictionary *dicSub in subData) {

            LabelItem * subItem = [[[LabelItem alloc] init] autorelease];
            subItem.labelName = [dicSub objectForKey:@"name"];
            subItem.imageUrl = [dicSub objectForKey:@"image"];
            subItem.superLabel = item.labelName;
            subItem.level = 1;
            
            NSArray *thirdData = [dicSub objectForKey:@"sub"];
            for (NSString *label in thirdData) {
                LabelItem * thirdItem = [[[LabelItem alloc] init] autorelease];
                thirdItem.labelName = label;
                thirdItem.superLabel = subItem.labelName;
                thirdItem.level = 2;
                
                [array addObject:thirdItem];
            }
            
            [array addObject:subItem];
        }
        
        [array addObject:item];
    }
    
    return array;
}


@end
