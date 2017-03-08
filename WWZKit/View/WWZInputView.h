//
//  KJMessageView.h
//  KJD
//
//  Created by appple on 15/8/27.
//  Copyright (c) 2015年 WL. All rights reserved.
//

#import "WWZShowView.h"

@interface WWZInputView : WWZShowView

/**
 *  允许输入汉字长度
 */
@property (nonatomic, assign) int textFieldMaxCount;

/**
 *  input view
 *
 *  @param title           title
 *  @param text            text
 *  @param placeHolderText placeHolder text
 *
 *  @return input view
 */
- (instancetype)initWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeHolder:(NSString *)placeHolder
                 buttonTitles:(NSArray *)buttonTitles
                clickButtonAtIndex:(void(^)(NSString *inputText, int index))block;

/**
 *  title color
 */
- (void)setTitleColor:(UIColor *)titleColor;

/**
 *  title font
 */
- (void)setTitleFont:(UIFont *)titleFont;

/**
 *  inputTextColor
 */
- (void)setInputTextColor:(UIColor *)inputTextColor;

/**
 *  inputTextFont
 */
- (void)setInputTextFont:(UIFont *)inputTextFont;

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
