//
//  UIView+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

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

#pragma mark - launch image

/**
 *  获取启动图片并保持
 *
 *  @param duration duration后启动图片消失
 *
 *  @return 启动图片
 */
+ (UIImageView *)wwz_launchImageAnimateWithDuration:(NSTimeInterval)duration;
/**
 *  启动图片消失动画
 *
 *  @param launchView 启动图片
 */
+ (void)wwz_dismissLaunchImageView:(UIView *)launchView;
@end











