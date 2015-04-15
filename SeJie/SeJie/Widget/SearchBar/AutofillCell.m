//
//  AutofillCell.m
//  micker
//
//  Created by Jarry Zhu on 12-6-4.
//  Copyright (c) 2012年 micker. All rights reserved.
//

#import "AutofillCell.h"

@implementation AutofillCell

@synthesize nameLabel = _nameLabel;
@synthesize countLabel = _countLabel;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 180, frame.size.height)];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [self addSubview:_nameLabel];

        _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, frame.size.width-10, frame.size.height)];
        _countLabel.backgroundColor = [UIColor clearColor];
        _countLabel.textColor = [UIColor lightGrayColor];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont systemFontOfSize:13.0];
        [self addSubview:_countLabel];
        
    }
    
    return  self;
}

- (void)dealloc {
    
    [_nameLabel release];
    [_countLabel release];
    [super dealloc];
}

@end
