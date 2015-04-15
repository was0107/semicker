//
//  CustomAnimation.h
//  micker
//
//  Created by Jarry Zhu on 12-5-7.
//  Copyright (c) 2012年 b5m. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DegreesToRadians(degrees) (degrees * M_PI / 180)


@interface CustomAnimation : NSObject

// drop to recycle animation
+ (void)dropRecycleAnim:(UIView*)view center:(CGPoint)point size:(CGSize)size;

// shake animation
+ (void)shakeAnimation:(UIView*)view 
              duration:(CGFloat)duration 
                vigour:(CGFloat)vigour 
                number:(NSInteger)number 
             direction:(NSInteger)direction;


/**
 *  @brief  Flip animation
 *  
 *  @param [in]  N/A      view      // the content view
 *  @param [in]  N/A      flipView  // the flip view
 *  @param [in]  N/A      duration  // the time 
 *  @param [in]  N/A      flag      // YES: means flipView add to view
                                    // NO:  means flipView remove from super view, view can be nil right now
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+ (void) flipAnimation:(UIView *)view
              flipView:(UIView *)flipView
              duration:(CGFloat)duration
                 isAdd:(BOOL) flag;

/**
 *  @brief  Flip animation
 *  
 *  @param [in]  N/A      imageView     // the image view
 *  @param [in]  N/A      image         // the image
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+ (void) flipAnimationEx:(UIImageView *)imageView
                flipView:(UIImage  *)image;


/**
 *  @brief  Flip animation
 *  
 *  @param [in]  N/A      imageView     // the image view
 *  @param [in]  N/A      time          // the time
 *  @param [in]  N/A      from          // the from
 *  @param [in]  N/A      to            // the to
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+ (void) moveToPosition:(UIImageView *) imageView
                   time:(CGFloat )time
                   from:(NSNumber *) from
                     to:(NSNumber *) to ;

+ (void) addOrRemoveAnimate:(UIView *) parentView subView:(UIView *) subView flag:(BOOL) flag;


/**
 *  @brief  横向移动
 *  
 *  @param [in]  N/A      
 *  @param [in]  N/A      
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+(CABasicAnimation *)moveX:(float)time 
                         X:(NSNumber *)x; 

/**
 *  @brief  横向移动
 *  
 *  @param [in]  N/A      time   
 *  @param [in]  N/A      fromX, toX
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+(CABasicAnimation *)moveX:(float)time 
                     fromX:(NSNumber *)FromX 
                       ToX:(NSNumber *)ToX;

/**
 *  @brief  纵向移动
 *  
 *  @param [in]  N/A         
 *  @param [in]  N/A     
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+(CABasicAnimation *)moveY:(float)time 
                         Y:(NSNumber *)y ;


/**
 *  @brief  缩放
 *  
 *  @param [in]  N/A      
 *  @param [in]  N/A      
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+(CABasicAnimation *)scale:(NSNumber *)Multiple 
                     orgin:(NSNumber *)orginMultiple 
                  durTimes:(float)time
                       Rep:(float)repeatTimes;


/**
 *  @brief  组合动画
 *  
 *  @param [in]  N/A      
 *  @param [in]  N/A      
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry 
                           durTimes:(float)time 
                                Rep:(float)repeatTimes; 

/**
 *  @brief  路径动画
 *  
 *  @param [in]  N/A      
 *  @param [in]  N/A      
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path 
                                 durTimes:(float)time 
                                      Rep:(float)repeatTimes; 

/**
 *  @brief  点移动
 *  
 *  @param [in]  N/A      
 *  @param [in]  N/A     
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+(CABasicAnimation *)movepoint:(CGPoint )point; 

/**
 *  @brief  旋转
 *  
 *  @param [in]  N/A      
 *  @param [in]  N/A      
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+(CABasicAnimation *)rotation:(float)dur 
                       degree:(float)degree 
                    direction:(int)direction 
                  repeatCount:(int)repeatCount; 


/**
 *  @brief  放大缩小frame
 *  
 *  @param [in]  N/A      
 *  @param [in]  N/A      
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+ (CAKeyframeAnimation *) scaleKeyFrameAnimation:(CGFloat) time;


/**
 *  @brief  有闪烁次数的动画
 *  
 *  @param [in]  N/A      
 *  @param [in]  N/A      
 *  @param [out] N/A        
 *  @return void
 *  @note           
 **/
+ (CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time;

/**
 *  @brief  旋转变换
 *  
 *  @param [in]  N/A      orientation
 *  @param [out] N/A        
 *  @return CGAffineTransform
 *  @note           
 **/
+ (CGAffineTransform)transformForOrientation:(UIInterfaceOrientation)orientation;

@end
