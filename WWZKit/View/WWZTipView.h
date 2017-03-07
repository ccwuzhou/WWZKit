//
//  WWZTipView.h
//  BCSmart
//
//  Created by wwz on 16/11/14.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWZTipView : UIView

/**
 *  show
 */
+ (void)showTipViewWithTitle:(NSString *)title
                   titleFont:(UIFont *)titleFont
                 lineSpacing:(CGFloat)lineSpacing
                buttonTitles:(NSArray *)buttonTitles
            clickButtonBlock:(void(^)(int index))block;
/**
 *  buttonTitles count is no more then 2.
 */
- (instancetype)initWithTitle:(NSString *)title
                    titleFont:(UIFont *)titleFont
                  lineSpacing:(CGFloat)lineSpacing
                 buttonTitles:(NSArray *)buttonTitles
             clickButtonBlock:(void(^)(int index))block;

- (void)show;

- (void)dismiss;

/**
 *  title color
 */
- (void)setTitleColor:(UIColor *)titleColor;

/**
 *  button color
 */
- (void)setButtonTitleColor:(UIColor *)buttonTitleColor;

/**
 *  button font
 */
- (void)setButtonTitleFont:(UIFont *)buttonTitleFont;

/**
 *  button high back color
 */
- (void)setButtonHighlightedBackgroundColor:(UIColor *)backgroundColor;
@end
