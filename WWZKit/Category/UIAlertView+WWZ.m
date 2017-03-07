//
//  UIAlertView+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UIAlertView+WWZ.h"
#import <objc/runtime.h>

static const char *WZDelegateKey = "!WZDelegateKey!";

#pragma mark - class
@interface WZAlertViewDelegate : NSObject <UIAlertViewDelegate>
{
    //block变量
    void(^_block)();
}

//初始化的时候传入一个block
- (instancetype)initWithBlock:(void(^)())block;

@end

@implementation WZAlertViewDelegate

- (instancetype)initWithBlock:(void(^)())block
{
    self = [super init];
    if (self) {
        //设置关联对象, 值为self
        objc_setAssociatedObject(self, WZDelegateKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        _block = block;
    }
    return self;
}

#pragma mark - delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (_block) {
        //执行block
        _block(alertView,buttonIndex);
    }
}

@end
@implementation UIAlertView (WWZ)

/**
 *  确定
 *
 *  @param message message
 *  @param block   block
 */
+ (void)wwz_alertViewWithMessage:(NSString *)message clickButtonWithBlock:(void(^)())block{
    [self wwz_alertViewWithTitle:nil message:message buttonTitles:@[@"确定"] clickButtonAtIndexWithBlock:block];
}
/**
 *  确定
 *
 *  @param title   title
 *  @param message message
 *  @param block   block
 */
+ (void)wwz_alertViewWithTitle:(NSString *)title message:(NSString *)message clickButtonWithBlock:(void(^)())block{
    [self wwz_alertViewWithTitle:title message:message buttonTitles:@[@"确定"] clickButtonAtIndexWithBlock:block];
}
/**
 *  取消, 确定
 *
 *  @param message message
 *  @param block   block(确定：1，取消：0)
 */
+ (void)wwz_alertViewWithMessage:(NSString *)message clickButtonAtIndexWithBlock:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))block{
    [self wwz_alertViewWithTitle:nil message:message buttonTitles:@[@"取消", @"确定"] clickButtonAtIndexWithBlock:block];
}
/**
 *  取消, 确定
 *
 *  @param title   title
 *  @param message message
 *  @param block   block(确定：1，取消：0)
 */
+ (void)wwz_alertViewWithTitle:(NSString *)title message:(NSString *)message clickButtonAtIndexWithBlock:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))block{
    [self wwz_alertViewWithTitle:title message:message buttonTitles:@[@"取消", @"确定"] clickButtonAtIndexWithBlock:block];
}
/**
 *  总alertView
 *
 *  @param title        title
 *  @param message      message
 *  @param buttonTitles buttonTitles
 *  @param block        block(确定：1，取消：0)
 */
+ (void)wwz_alertViewWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles clickButtonAtIndexWithBlock:(void(^)(UIAlertView *alertView, NSInteger buttonIndex))block{
    
    if (!buttonTitles||buttonTitles.count == 0) return;
    
    NSString *cancleTitle = buttonTitles[0];
    NSString *otherTitle = nil;
    if (buttonTitles.count == 2) {
        otherTitle = buttonTitles[1];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancleTitle otherButtonTitles:otherTitle, nil];
    //获取delegate对象
    id delegate = objc_getAssociatedObject([[WZAlertViewDelegate alloc] initWithBlock:block], WZDelegateKey);
    alertView.delegate = delegate;
    [alertView show];
}
@end
