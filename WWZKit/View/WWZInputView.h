//
//  KJMessageView.h
//  KJD
//
//  Created by appple on 15/8/27.
//  Copyright (c) 2015年 WL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWZInputView : UIView

/**
 *  输入文本
 */
@property (nonatomic, strong, readonly) NSString *text;

/**
 *  允许输入汉字长度
 */
@property (nonatomic, assign) int textFieldMaxCount;

/**
 *
 *  @param title           title
 *  @param text            text
 *  @param placeHolderText placeHolder text
 *
 *  @return input view
 */
+ (void)showInputViewWithTitle:(NSString *)title
                                  text:(NSString *)text
                           placeHolder:(NSString *)placeHolderText
                          buttonTitles:(NSArray *)buttonTitles
                         clickBtnIndex:(void(^)(WWZInputView *inputView, int index))block;
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
                  placeHolder:(NSString *)placeHolderText
                 buttonTitles:(NSArray *)buttonTitles
                clickBtnIndex:(void(^)(WWZInputView *inputView, int index))block;

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
