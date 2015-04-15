//
//  WASSegmentControl.h
//  micker
//
//  Created by allen.wang on 10/9/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WASSegmentedControlHeight 33.0 // the height of the control. Change this if you're making controls of a different height

enum {
    WASSegmentedControlNoSegment = -1 // segment index for no selected segment
};

@interface WASSegmentControl : UIControl 
@property (nonatomic, retain) NSMutableArray *segments; // at least two (2) NSStrings are needed for a STSegmentedControl to be displayed
@property (nonatomic, retain) UIImage *normalImageLeft;
@property (nonatomic, retain) UIImage *normalImageMiddle;
@property (nonatomic, retain) UIImage *normalImageRight;
@property (nonatomic, retain) UIImage *selectedImageLeft;
@property (nonatomic, retain) UIImage *selectedImageMiddle;
@property (nonatomic, retain) UIImage *selectedImageRight;
@property (nonatomic, readonly) NSUInteger numberOfSegments;
@property (nonatomic, getter=isMomentary) BOOL momentary;
@property (nonatomic, readwrite) NSInteger selectedSegmentIndex;


/*!
 *	@brief	Init with items,items can be NSStrings or UIImages.
 *
 *	@param 	items 	the items description
 *
 *	@return	self
 */
- (id)initWithItems:(NSArray *)items;

/*!
 *	@brief	insert with title ,insert before segment number
 *
 *	@param 	title 	title description
 *	@param 	index 	position description
 */
- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index;

/*!
 *	@brief	Description
 *
 *	@param 	image 	image description
 *	@param 	index 	index description
 */
- (void)insertSegmentWithImage:(NSString *)image atIndex:(NSUInteger)index;

/*!
 *	@brief	remove segment at the index 
 *
 *	@param 	index 	index description
 */
- (void)removeSegmentAtIndex:(NSUInteger)index;

/*!
 *	@brief	empty all segments
 */
- (void)removeAllSegments;

/*!
 *	@brief	set title at index
 *
 *	@param 	title 	title description
 *	@param 	index 	index description
 */
- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)index;

/*!
 *	@brief	get the titile at index 
 *
 *	@param 	index 	index description
 *
 *	@return	the title
 */
- (NSString *)titleForSegmentAtIndex:(NSUInteger)index;

/*!
 *	@brief	set image at index
 *
 *	@param 	image 	image description
 *	@param 	index 	index description
 */
- (void)setImage:(NSString *)image forSegmentAtIndex:(NSUInteger)index;

/*!
 *	@brief	get the image at index
 *
 *	@param 	index 	index description
 *
 *	@return	the image
 */
- (UIImage *)imageForSegmentAtIndex:(NSUInteger)index;

@end
