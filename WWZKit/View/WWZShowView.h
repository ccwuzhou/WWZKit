//
//  BCShowView.h
//  wwz
//
//  Created by wwz on 16/8/9.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WWZShowViewAnimateType) {
    WWZShowViewAnimateTypeAlpha,         // 透明度
    WWZShowViewAnimateTypeFromTop,      // 从上面弹出
    WWZShowViewAnimateTypeFromLeft,     // 从左面弹出
    WWZShowViewAnimateTypeFromBottom,   // 从下面弹出
    WWZShowViewAnimateTypeFromRight     // 从右面弹出
   
};

@interface WWZShowView : UIView

/**
 *  点击空白区域消失，default is YES
 */
@property (nonatomic, assign, getter=isTapEnabled) BOOL tapEnabled;

/**
 *  空白区域背景颜色, default is [UIColor colorWithWhite:0 alpha:0.1]
 */
@property (nonatomic, strong) UIColor *backColor;

/**
 *  动画时间，default is 0.3s
 */
@property (nonatomic, assign) NSTimeInterval animateDuration;

/**
 *  弹出类型, default is none
 */
@property (nonatomic, assign) WWZShowViewAnimateType animateType;

/**
 *  显示
 */
- (void)wwz_showCompletion:(void (^)(BOOL finished))completion;

/**
 *  隐藏
 */
- (void)wwz_dismissCompletion:(void (^)(BOOL finished))completion;

@end
