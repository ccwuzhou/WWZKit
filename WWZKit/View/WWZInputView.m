//
//  KJMessageView.m
//  KJD
//
//  Created by appple on 15/8/27.
//  Copyright (c) 2015年 WL. All rights reserved.
//

#import "WWZInputView.h"

#define WWZ_INPUTVIEW_LINE_COLOR [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]

@interface WWZInputView()<UITextFieldDelegate>

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UITextField *inputTextField;

@property (nonatomic, copy) void(^clickBtnIndexBlock)(NSString *, int);

@end

@implementation WWZInputView

static int const BUTTON_TAG = 99;

- (instancetype)initWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeHolder:(NSString *)placeHolder
                 buttonTitles:(NSArray *)buttonTitles
           clickButtonAtIndex:(void(^)(NSString *inputText, int index))block{
    
    if (self = [super initWithFrame:CGRectZero]) {
        
        if (buttonTitles.count != 2) {
            return self;
        }
        
        self.tapEnabled = NO;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _clickBtnIndexBlock = block;
        
        _textFieldMaxCount = INT_MAX;
        
        
        CGFloat inputViewW = UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad ? 250*[UIScreen mainScreen].bounds.size.width/320 : 425;
        CGFloat inputViewH = UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad ? 150 : 183;
        
        self.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width-inputViewW)*0.5, [UIScreen mainScreen].bounds.size.height*0.25, inputViewW, inputViewH);
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15;
        
        CGSize viewSize = self.frame.size;
        
        
        // title label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:20];
        [titleLabel sizeToFit];
        CGRect titleLFrame = titleLabel.frame;
        CGFloat kSpaceY = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 15:20);
        titleLFrame.origin = CGPointMake((viewSize.width - titleLFrame.size.width)*0.5, kSpaceY);
        titleLabel.frame = titleLFrame;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        // textField
        CGFloat inputTextFieldX = 20;
        
        UITextField *inputTextField = [[UITextField alloc] init];
        inputTextField.placeholder = placeHolder;
        inputTextField.returnKeyType = UIReturnKeyDone;
        inputTextField.borderStyle = UITextBorderStyleRoundedRect;
        inputTextField.delegate = self;
        inputTextField.font = [UIFont systemFontOfSize:14];
        [inputTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        CGRect textFFrame = CGRectMake(inputTextFieldX, CGRectGetMaxY(titleLabel.frame) + kSpaceY, viewSize.width-2*inputTextFieldX, 40);
        inputTextField.frame = textFFrame;
        [self addSubview:inputTextField];
        _inputTextField = inputTextField;
        
        if (text.length>0) {
            _inputTextField.text = text;
        }
        
        CGFloat kBtnH = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 45:55);
        for (int i = 0; i < buttonTitles.count; i++) {
            
            UIButton *btn = [self buttonWithFrame:CGRectMake(i*viewSize.width*0.5, viewSize.height - kBtnH, viewSize.width*0.5, kBtnH) title:buttonTitles[i] tag:i];
            [self addSubview:btn];
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(viewSize.width*0.5-0.25, viewSize.height-kBtnH, 0.5, kBtnH)];
        lineView.backgroundColor = WWZ_INPUTVIEW_LINE_COLOR;
        [self addSubview:lineView];
    }
    return self;
    
}

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title tag:(int)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self imageWithColor:WWZ_INPUTVIEW_LINE_COLOR size:frame.size alpha:1] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    btn.tag = BUTTON_TAG+tag;
    
    [btn addTarget:self action:@selector(clickButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
    lineView.backgroundColor = WWZ_INPUTVIEW_LINE_COLOR;
    [btn addSubview:lineView];
    
    return btn;
}


/**
 *  titleColor
 */
- (void)setTitleColor:(UIColor *)titleColor{
    
    if (!titleColor) {
        return;
    }
    
    self.titleLabel.textColor = titleColor;
}

/**
 *  titleFont
 */
- (void)setTitleFont:(UIFont *)titleFont{
    
    if (!titleFont) {
        return;
    }
    
    self.titleLabel.font = titleFont;
}

/**
 *  inputTextColor
 */
- (void)setInputTextColor:(UIColor *)inputTextColor{
    
    if (!inputTextColor) {
        return;
    }
    
    self.inputTextField.textColor = inputTextColor;
}

/**
 *  inputTextFont
 */
- (void)setInputTextFont:(UIFont *)inputTextFont{
    
    if (!inputTextFont) {
        return;
    }
    
    self.inputTextField.font = inputTextFont;
}

/**
 *  button color
 */
- (void)setButtonTitleColor:(UIColor *)buttonTitleColor{
    
    if (!buttonTitleColor) {
        return;
    }
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)subView;
            [btn setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        }
    }
}

/**
 *  button font
 */
- (void)setButtonTitleFont:(UIFont *)buttonTitleFont{
    
    if (!buttonTitleFont) {
        return;
    }
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)subView;
            btn.titleLabel.font = buttonTitleFont;
        }
    }
}
/**
 *  button high back color
 */
- (void)setButtonHighlightedBackgroundColor:(UIColor *)backgroundColor{
    
    if (!backgroundColor) {
        return;
    }
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)subView;
            [btn setBackgroundImage:[self imageWithColor:backgroundColor size:btn.frame.size alpha:1] forState:UIControlStateHighlighted];
        }
    }
}

- (void)setTextFieldMaxCount:(int)textFieldMaxCount{
    
    if (textFieldMaxCount>0) {
        _textFieldMaxCount = textFieldMaxCount;
    }
}
/**
 *  点击btn
 */
- (void)clickButtonAtIndex:(UIButton *)sender{
    
    if (_clickBtnIndexBlock) {
        _clickBtnIndexBlock(self.inputTextField.text, (int)sender.tag-BUTTON_TAG);
    }
    [self wwz_dismissCompletion:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_inputTextField resignFirstResponder];
    return YES;
}


#pragma mark - textField delegate

/**
 *  textField 内容改变
 */
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField == _inputTextField) {
        float percent = 1.4;
        NSString *toBeString = textField.text;
        NSString *lang = textField.textInputMode.primaryLanguage; // 键盘输入模式
        
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textField markedTextRange];
            //获取高亮部分(输入的英文还没有转化为汉字的状态)
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                NSInteger chineseCount = [self wwz_chineseCountOfString:toBeString];
                NSInteger characterCount = toBeString.length-chineseCount;
                
                NSInteger maxCount = (_textFieldMaxCount*percent-characterCount)/percent+characterCount;
                if (maxCount>_textFieldMaxCount*percent) {
                    maxCount = _textFieldMaxCount*percent;
                }
                if (toBeString.length > maxCount) {
                    textField.text = [toBeString substringToIndex:maxCount];
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
//                NSLog(@"输入的英文还没有转化为汉字的状态");
            }
        }
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else{
            NSInteger chineseCount = [self wwz_chineseCountOfString:toBeString];
            NSInteger maxCount = (_textFieldMaxCount-chineseCount)*percent+chineseCount;
            if (toBeString.length > maxCount) {
                textField.text = [toBeString substringToIndex:maxCount];
            }
        }
    }
}
- (void)dealloc{
    NSLog(@"%s", __func__);
}

#pragma mark - help

/**
 *  计算汉字的个数
 */
- (NSInteger)wwz_chineseCountOfString:(NSString *)string{
    
    if (!string||string.length == 0) {
        return 0;
    }
    int chineseCount = 0;
    
    for (int i = 0; i<string.length; i++) {
        unichar c = [string characterAtIndex:i];
        if (c >=0x4E00 && c <=0x9FA5){
            chineseCount++ ;//汉字
        }
    }
    return chineseCount;
}

#pragma mark - 背景转换成图片

- (UIImage *)wwz_backgroundGradientImageWithSize:(CGSize)size
{
    CGPoint center = CGPointMake(size.width * 0.5, size.height * 0.5);
    CGFloat innerRadius = 0;
    CGFloat outerRadius = sqrtf(size.width * size.width + size.height * size.height) * 0.5;
    
    BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(size, opaque, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const size_t locationCount = 2;
    CGFloat locations[locationCount] = { 0.0, 1.0 };
    CGFloat components[locationCount * 4] = {
        0.0, 0.0, 0.0, 0.1, // More transparent black
        0.0, 0.0, 0.0, 0.7  // More opaque black
    };
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, locationCount);
    
    CGContextDrawRadialGradient(context, gradient, center, innerRadius, center, outerRadius, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
    return image;
}


- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
