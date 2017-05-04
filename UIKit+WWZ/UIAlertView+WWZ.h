//
//  UIAlertView+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (WWZ)

/**
 *  确定
 *
 *  @param message message
 *  @param block   block
 */
+ (void)wwz_alertViewWithMessage:(NSString *)message clickButtonWithBlock:(void(^)())block;
/**
 *  确定
 *
 *  @param title   title
 *  @param message message
 *  @param block   block
 */
+ (void)wwz_alertViewWithTitle:(NSString *)title message:(NSString *)message clickButtonWithBlock:(void(^)())block;
/**
 *  取消, 确定
 *
 *  @param message message
 *  @param block   block(确定：1，取消：0)
 */
+ (void)wwz_alertViewWithMessage:(NSString *)message clickButtonAtIndexWithBlock:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))block;
/**
 *  取消, 确定
 *
 *  @param title   title
 *  @param message message
 *  @param block   block(确定：1，取消：0)
 */
+ (void)wwz_alertViewWithTitle:(NSString *)title message:(NSString *)message clickButtonAtIndexWithBlock:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))block;
/**
 *  总alertView
 *
 *  @param title        title
 *  @param message      message
 *  @param buttonTitles buttonTitles
 *  @param block        block(确定：1，取消：0)
 */
+ (void)wwz_alertViewWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles clickButtonAtIndexWithBlock:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))block;

@end
