//
//  WWZActionSheetView.h
//  wwz
//
//  Created by wwz on 16/11/15.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWZActionSheetView : UIView

/**
 *  show
 */
+ (void)showActionSheetViewWithTitle:(NSString *)title
                   cancelButtonTitle:(NSString *)cancelButtonTitle
                   otherButtonTitles:(NSArray *)otherButtonTitles
                    clickButtonBlock:(void(^)(int index))clickButtonBlock;
/**
 *  WWZActionSheetView
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
             clickButtonBlock:(void(^)(int index))clickButtonBlock;

- (void)show;

- (void)dismiss;

/**
 *  title color
 */
- (void)setTitleColor:(UIColor *)titleColor;

/**
 *  title font
 */
- (void)setTitleFont:(UIFont *)titleFont;

/**
 *  button color
 */
- (void)setOtherButtonTitleColor:(UIColor *)buttonTitleColor;

/**
 *  cancel button color
 */
- (void)setCancelButtonTitleColor:(UIColor *)buttonTitleColor;

/**
 *  button font
 */
- (void)setOtherButtonTitleFont:(UIFont *)buttonTitleFont;

/**
 *  button font
 */
- (void)setCancelButtonTitleFont:(UIFont *)buttonTitleFont;

/**
 *  button back color
 */
- (void)setButtonNBColor:(UIColor *)nBColor hBColor:(UIColor *)hBColor;

@end
