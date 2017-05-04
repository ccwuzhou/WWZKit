//
//  WWZTipView.h
//  BCSmart
//
//  Created by wwz on 16/11/14.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WWZShowView.h"

@interface WWZTipView : WWZShowView

/**
 *  buttonTitles count is no more then 2.
 */
- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText
                          buttonTitles:(NSArray *)buttonTitles
                      clickButtonBlock:(void(^)(int index))block;

/**
 *  button color, default is black
 */
- (void)setButtonTitleColor:(UIColor *)buttonTitleColor;

/**
 *  button font， default is 16
 */
- (void)setButtonTitleFont:(UIFont *)buttonTitleFont;

/**
 *  button high back color, default is (204, 204, 204, 1)
 */
- (void)setButtonHighlightedBackgroundColor:(UIColor *)backgroundColor;
@end
