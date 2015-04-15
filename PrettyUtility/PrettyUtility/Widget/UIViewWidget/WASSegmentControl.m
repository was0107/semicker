//
//  WASSegmentControl.m
//  micker
//
//  Created by allen.wang on 10/9/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASSegmentControl.h"

@interface WASSegmentControl() {
	NSMutableArray  *segments;
	UIImage         *normalImageLeft;
	UIImage         *normalImageMiddle;
	UIImage         *normalImageRight;
	UIImage         *selectedImageLeft;
	UIImage         *selectedImageMiddle;
	UIImage         *selectedImageRight;
	NSUInteger      numberOfSegments;
	NSInteger       selectedSegmentIndex;
	BOOL            programmaticIndexChange;
	BOOL            momentary;
}

/*!
 *	@brief	set the default image
 */
- (void) setDefalutImage;

/*!
 *	@brief	update UI
 */
- (void)updateUI;
/*!
 *	@brief	make all segment unselected
 */
- (void)deselectAllSegments;
/*!
 *	@brief	insert an object at the index
 *
 *	@param 	object 	object description
 *	@param 	index 	index description
 */
- (void)insertSegmentWithObject:(NSObject *)object atIndex:(NSUInteger)index;
/*!
 *	@brief	set object for the segement at the index
 *
 *	@param 	object 	object description
 *	@param 	index 	index description
 */
- (void)setObject:(NSObject *)object forSegmentAtIndex:(NSUInteger)index;
@end

@implementation WASSegmentControl
@synthesize     segments;
@synthesize     numberOfSegments;
@synthesize     selectedSegmentIndex;
@synthesize     momentary;
@synthesize     normalImageLeft;
@synthesize     normalImageMiddle;
@synthesize     normalImageRight;
@synthesize     selectedImageLeft;
@synthesize     selectedImageMiddle;
@synthesize     selectedImageRight;

- (id)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)])) {//WASSegmentedControlHeight
		self.backgroundColor = [UIColor clearColor];
        [self setDefalutImage];
		
		selectedSegmentIndex = WASSegmentedControlNoSegment;
		momentary = NO;
    }
    return self;
}

- (id)initWithItems:(NSArray *)items {
    if((self = [super init])) {
		self.backgroundColor = [UIColor clearColor];
		selectedSegmentIndex = WASSegmentedControlNoSegment;
		momentary = NO;
		
		/*
		 Set items
		 */
        if (!items) {
            [self setDefalutImage];
        }
        else {
            self.segments = [NSMutableArray arrayWithArray:items];
        }
    }
    return self;
}

#pragma mark -
#pragma mark initWithCoder for IB support

- (id)initWithCoder:(NSCoder *)decoder {
    if(self = [super initWithCoder:decoder]) {
		self.backgroundColor = [UIColor clearColor];
		self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);//WASSegmentedControlHeight
        [self setDefalutImage];
		selectedSegmentIndex = WASSegmentedControlNoSegment;
		momentary = NO;
	}
	
    return self;
}

#pragma mark -

- (void) setDefalutImage
{
    normalImageLeft = [[UIImage imageNamed:@"left_default_new"] retain];
    normalImageMiddle = [[UIImage imageNamed:@"normal_middle"] retain];
    normalImageRight= [[UIImage imageNamed:@"right_defalut_new"] retain];
    
    selectedImageLeft = [[UIImage imageNamed:@"left_down_new"] retain];
    selectedImageMiddle = [[UIImage imageNamed:@"selected_middle"] retain];
    selectedImageRight = [[UIImage imageNamed:@"right_down_new"] retain];
}

- (void)updateUI {
	/*
	 Remove every UIButton from screen
	 */
	[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	/*
	 We're only displaying this element if there are at least two buttons
	 */
	if([segments count] > 1)
	{
		numberOfSegments = [segments count];
		int indexOfObject = 0;
		
		float segmentWidth = (float)self.frame.size.width / numberOfSegments;
		float lastX = 0.0;
		
		for(NSObject *object in segments)
		{
			/*
			 Calculate the frame for the current segment
			 */
			int currentSegmentWidth; 
			
			if(indexOfObject < numberOfSegments - 1)
				currentSegmentWidth = round(lastX + segmentWidth) - round(lastX);
			else
				currentSegmentWidth = round(lastX + segmentWidth) - round(lastX);
			
			CGRect segmentFrame = CGRectMake(round(lastX), 0, currentSegmentWidth, self.frame.size.height);
			lastX += segmentWidth;
			
			/*
			 Give every button the background image it needs for its current state
			 */
			UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
			
			if(indexOfObject == 0)
			{
				if(selectedSegmentIndex == indexOfObject)
					[button setBackgroundImage:[selectedImageLeft stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
				else
					[button setBackgroundImage:[normalImageLeft stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
			}
			else if(indexOfObject == numberOfSegments - 1)
			{
				if(selectedSegmentIndex == indexOfObject)
					[button setBackgroundImage:[selectedImageRight stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
				else
					[button setBackgroundImage:[normalImageRight stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
			}
			else
			{
				if(selectedSegmentIndex == indexOfObject)
					[button setBackgroundImage:[selectedImageMiddle stretchableImageWithLeftCapWidth:1 topCapHeight:0] forState:UIControlStateNormal];
				else
					[button setBackgroundImage:[normalImageMiddle stretchableImageWithLeftCapWidth:1 topCapHeight:0] forState:UIControlStateNormal];
			}
			
			button.frame = segmentFrame;
			button.titleLabel.font = [UIFont systemFontOfSize:kSystemFontSize14];
			button.tag = indexOfObject + 1;
			button.adjustsImageWhenHighlighted = NO;
            [button setTitleColor:kLightGrayColor forState:UIControlStateNormal];
			
			/*
			 Check if we're dealing with a string or an image
			 */
            if([object isKindOfClass:[UIImage class]])
			{
				[button setImage:(UIImage *)object forState:UIControlStateNormal];
			}
			else if([object isKindOfClass:[NSString class]])
			{
				[button setTitle:(NSString *)object forState:UIControlStateNormal];
			}
			
			
			[button addTarget:self action:@selector(segmentTapped:) forControlEvents:UIControlEventTouchDown];
			[self addSubview:button];
			
			++indexOfObject;
		}
		
		/*
		 Make sure the selected segment shows both its separators
		 */
		[self bringSubviewToFront:[self viewWithTag:selectedSegmentIndex + 1]];
	}
}

- (void)deselectAllSegments {
	for(UIButton *button in self.subviews)
	{
		if(button.tag == 1)
		{
			[button setBackgroundImage:[normalImageLeft stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
		}
		else if(button.tag == numberOfSegments)
		{
			[button setBackgroundImage:[normalImageRight stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
		}
		else
		{
			[button setBackgroundImage:[normalImageMiddle stretchableImageWithLeftCapWidth:1 topCapHeight:0] forState:UIControlStateNormal];
		}
        [button setTitleColor:kBlackColor forState:UIControlStateNormal];
	}
}

- (void)resetSegments {
	selectedSegmentIndex = WASSegmentedControlNoSegment;
	[self sendActionsForControlEvents:UIControlEventValueChanged];
	
	[self updateUI];
}

- (void)segmentTapped:(id)sender {
	[self deselectAllSegments];
	UIButton *button = sender;
	[self bringSubviewToFront:button];
	
	if(selectedSegmentIndex != button.tag - 1 || programmaticIndexChange)
	{
		selectedSegmentIndex = button.tag - 1;
		programmaticIndexChange = NO;
		[self sendActionsForControlEvents:UIControlEventValueChanged];
	}
	if(button.tag == 1)
	{
		[button setBackgroundImage:[selectedImageLeft stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
	}
	else if(button.tag == numberOfSegments)
	{
		[button setBackgroundImage:[selectedImageRight stretchableImageWithLeftCapWidth:6 topCapHeight:0] forState:UIControlStateNormal];
	}
	else
	{
		[button setBackgroundImage:[selectedImageMiddle stretchableImageWithLeftCapWidth:1 topCapHeight:0] forState:UIControlStateNormal];
	}
    
    [button setTitleColor:kOrangeColor forState:UIControlStateNormal];

	if(momentary)
		[self performSelector:@selector(deselectAllSegments) withObject:nil afterDelay:0.2];
}

#pragma mark -
#pragma mark Manipulation methods

- (void)insertSegmentWithObject:(NSObject *)object atIndex:(NSUInteger)index {
	if(index <= numberOfSegments )
	{
		[segments insertObject:object atIndex:index];
		[self resetSegments];
	}
}

- (void)setObject:(NSObject *)object forSegmentAtIndex:(NSUInteger)index {
	if(index < numberOfSegments)
	{
		[segments replaceObjectAtIndex:index withObject:object];
		[self resetSegments];
	}
}

#pragma mark -

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index {
	[self insertSegmentWithObject:title atIndex:index];	
}

- (void)insertSegmentWithImage:(NSString *)image atIndex:(NSUInteger)index {
	[self insertSegmentWithObject:image atIndex:index];		
}

- (void)removeSegmentAtIndex:(NSUInteger)index
{
	if(index < numberOfSegments)
	{
		[segments removeObjectAtIndex:index];
		[self resetSegments];
	}
}

- (void)removeAllSegments {
	[segments removeAllObjects];
	
	selectedSegmentIndex = WASSegmentedControlNoSegment;
	[self updateUI];
}

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)index {    
    if(index < numberOfSegments)
	{
		[segments replaceObjectAtIndex:index withObject:title];
        UIButton *button = (UIButton *)[self viewWithTag:index + 1];
        [button setTitle:title forState:UIControlStateNormal];
    }
}

- (void)setImage:(NSString *)image forSegmentAtIndex:(NSUInteger)index {
	[self setObject:image forSegmentAtIndex:index];
}

#pragma mark -
#pragma mark Getters

- (NSString *)titleForSegmentAtIndex:(NSUInteger)index {
	if(index < [segments count])
	{
		if([[segments objectAtIndex:index] isKindOfClass:[NSString class]])
		{
			return [segments objectAtIndex:index];
		}
	}
	
	return nil;
}

- (UIImage *)imageForSegmentAtIndex:(NSUInteger)index {
	if(index < [segments count])
	{
		if([[segments objectAtIndex:index] isKindOfClass:[UIImage class]])
		{
			return [segments objectAtIndex:index];
		}
	}
	
	return nil;
}

#pragma mark -
#pragma mark Setters

- (void)setSegments:(NSMutableArray *)array
{
	if(array != segments)
	{
		[segments release];
		segments = [array retain];
        
		[self resetSegments];
	}
}

- (void)setSelectedSegmentIndex:(NSInteger)index
{
	if(index != selectedSegmentIndex)
	{
		selectedSegmentIndex = index;
		programmaticIndexChange = YES;
		
		if(index >= 0 && index < numberOfSegments)
		{
			UIButton *button = (UIButton *)[self viewWithTag:index + 1];
			[self segmentTapped:button];
		}
	}
}

- (void)setFrame:(CGRect)rect {
	[super setFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, WASSegmentedControlHeight)];
	[self updateUI];
}

#pragma mark -
#pragma mark Image setters

- (void)setNormalImageLeft:(UIImage *)image 
{
	if(image != normalImageLeft)
	{
		[normalImageLeft release];
		normalImageLeft = [image retain];
        
		[self updateUI];
	}
}

- (void)setNormalImageMiddle:(UIImage *)image
{
	if(image != normalImageMiddle)
	{
		[normalImageMiddle release];
		normalImageMiddle = [image retain];
        
		[self updateUI];
	}
}

- (void)setNormalImageRight:(UIImage *)image 
{
	if(image != normalImageRight)
	{
		[normalImageRight release];
		normalImageRight = [image retain];
        
		[self updateUI];
	}
}

- (void)setSelectedImageLeft:(UIImage *)image 
{
	if(image != selectedImageLeft)
	{
		[selectedImageLeft release];
		selectedImageLeft = [image retain];
        
		[self updateUI];
	}
}

- (void)setSelectedImageMiddle:(UIImage *)image 
{
	if(image != selectedImageMiddle)
	{
		[selectedImageMiddle release];
		selectedImageMiddle = [image retain];
        
		[self updateUI];
	}
}

- (void)setSelectedImageRight:(UIImage *)image
{
	if(image != selectedImageRight)
	{
		[selectedImageRight release];
		selectedImageRight = [image retain];
        
		[self updateUI];
	}
}

#pragma mark -

- (void)dealloc {
	[segments release],             segments = nil;
	[normalImageLeft release],      normalImageLeft = nil;
	[normalImageMiddle release],    normalImageMiddle = nil;
	[normalImageRight release],     normalImageRight = nil;
	[selectedImageLeft release],    selectedImageLeft = nil;
	[selectedImageMiddle release],  selectedImageMiddle = nil;
	[selectedImageRight release],   selectedImageRight = nil;
	[super dealloc];
}


@end
