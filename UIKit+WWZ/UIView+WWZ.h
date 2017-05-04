//
//  UIView+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (WWZ)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGPoint bottomLeft;
@property (nonatomic, assign) CGPoint bottomRight;
@property (nonatomic, assign) CGPoint topRight;

#pragma mark - Relative

// 右边距离父视图rightOffset为正值
- (void)wwz_alignRight:(CGFloat)rightOffset;

// 下边距离父视图bottomOffset为正值
- (void)wwz_alignBottom:(CGFloat)bottomOffset;

// 与父视图中心对齐
- (void)wwz_alignCenter;

// 与父视图的中心x对齐
- (void)wwz_alignCenterX;

// 与父视图的中心y对齐
- (void)wwz_alignCenterY;

/**
 *  纯色view
 */
- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor;
@end


#pragma mark - 手势
@interface UIView (GestureRecognizer)

/**
 *  tap
 */
- (void)wwz_tapPeformBlock:(void(^)())block;

/**
 *  swipe
 */
- (void)wwz_swipeDirection:(UISwipeGestureRecognizerDirection)direction peformBlock:(void(^)(UISwipeGestureRecognizer *swipe))block;
/**
 *  longPress
 */
- (void)wwz_longPressPeformBlock:(void(^)(UILongPressGestureRecognizer *longPress))block;
/**
 *  pan
 */
- (void)wwz_panPeformBlock:(void(^)(UIPanGestureRecognizer *pan))block;

@end











