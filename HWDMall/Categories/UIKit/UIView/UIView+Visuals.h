//
//  UIView+Visuals.h
//
//  Created by Heiko Dreyer on 25.05.11.
//  Copyright 2011 boxedfolder.com. All rights reserved.
//  https://github.com/bfolder/UIView-Visuals

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum : NSUInteger {
    LBShadowPath_NoBottom = 0,
    LBShadowPath_NoTop,
    LBShadowPath_LeftAndRight, // 左右
    LBShadowPath_AllSiede
}LBShadowPathSide;


@interface UIView (Visuals)

/*
 *  Sets a corners with radius, given stroke size & color
 */
-(void)cornerRadius: (CGFloat)radius 
         strokeSize: (CGFloat)size 
              color: (UIColor *)color;
/*
 *  Sets a corners // 绝对布局
 */
-(void)setRoundedCorners:(UIRectCorner)corners
                  radius:(CGFloat)radius;

/*
 * Sets a corners // 相对布局
 */

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;

/*
 *  Draws shadow with properties
 */
-(void)shadowWithColor: (UIColor *)color 
                offset: (CGSize)offset 
               opacity: (CGFloat)opacity 
                radius: (CGFloat)radius;

/*
 *  Removes from superview with fade
 */
-(void)removeFromSuperviewWithFadeDuration: (NSTimeInterval)duration;

/*
 *  Adds a subview with given transition & duration
 */
-(void)addSubview: (UIView *)view withTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Removes view from superview with given transition & duration
 */
-(void)removeFromSuperviewWithTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Rotates view by given angle. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)rotateByAngle: (CGFloat)angle 
            duration: (NSTimeInterval)duration 
         autoreverse: (BOOL)autoreverse
         repeatCount: (CGFloat)repeatCount
      timingFunction: (CAMediaTimingFunction *)timingFunction;

/*
 *  Moves view to point. TimingFunction can be nil and defaults to kCAMediaTimingFunctionEaseInEaseOut.
 */
-(void)moveToPoint: (CGPoint)newPoint 
          duration: (NSTimeInterval)duration 
       autoreverse: (BOOL)autoreverse
       repeatCount: (CGFloat)repeatCount
    timingFunction: (CAMediaTimingFunction *)timingFunction;


/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，
 
 */

- (void)setShadowPathWith:(UIColor *)shadowColor
            shadowOpacity:(CGFloat)shadowOpacity
             shadowRadius:(CGFloat)shadowRadius
               shadowSide:(LBShadowPathSide)shadowPathSide
          shadowPathWidth:(CGFloat)shadowPathWidth;

@end
