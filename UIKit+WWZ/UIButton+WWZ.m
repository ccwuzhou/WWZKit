//
//  UIButton+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UIButton+WWZ.h"

@implementation UIButton (WWZ)
#pragma mark - title

- (void)wwz_setNTitle:(NSString *)nTitle{
    [self wwz_setNTitle:nTitle sTitle:nil];
}
- (void)wwz_setSTitle:(NSString *)sTitle{
    [self wwz_setNTitle:nil sTitle:sTitle];
}
- (void)wwz_setNTitle:(NSString *)nTitle sTitle:(NSString *)sTitle{
    if (nTitle) {
        [self setTitle:nTitle forState:UIControlStateNormal];
    }
    if (sTitle) {
        [self setTitle:sTitle forState:UIControlStateSelected];
    }
}

#pragma mark - color

- (void)wwz_setNColor:(UIColor *)nColor{
    [self wwz_setNColor:nColor hColor:nil sColor:nil];
}
- (void)wwz_setSColor:(UIColor *)sColor{
    [self setTitleColor:sColor forState:UIControlStateSelected];
}
- (void)wwz_setNColor:(UIColor *)nColor hColor:(UIColor *)hColor{
    [self wwz_setNColor:nColor hColor:hColor sColor:nil];
}
- (void)wwz_setNColor:(UIColor *)nColor sColor:(UIColor *)sColor{
    [self wwz_setNColor:nColor hColor:nil sColor:sColor];
}
- (void)wwz_setNColor:(UIColor *)nColor hColor:(UIColor *)hColor sColor:(UIColor *)sColor{
    if (nColor) {
        [self setTitleColor:nColor forState:UIControlStateNormal];
    }
    if (hColor) {
        [self setTitleColor:hColor forState:UIControlStateHighlighted];
    }
    if (sColor) {
        [self setTitleColor:sColor forState:UIControlStateSelected];
    }
}

#pragma mark - image

- (void)wwz_setNImage:(NSString *)nImage{
    [self setImage:nImage state:UIControlStateNormal];
}
- (void)wwz_setSImage:(NSString *)sImage{
    [self setImage:sImage state:UIControlStateSelected];
}
- (void)wwz_setNImage:(NSString *)nImage hImage:(NSString *)hImage{
    [self wwz_setNImage:nImage hImage:hImage sImage:nil];
}
- (void)wwz_setNImage:(NSString *)nImage sImage:(NSString *)sImage{
    
    [self wwz_setNImage:nImage hImage:nImage sImage:sImage];
}
- (void)wwz_setNImage:(NSString *)nImage hImage:(NSString *)hImage sImage:(NSString *)sImage{
    
    if (nImage) {
        [self setImage:nImage state:UIControlStateNormal];
    }
    if (hImage) {
        [self setImage:hImage state:UIControlStateHighlighted];
    }
    if (sImage) {
        [self setImage:sImage state:UIControlStateSelected];
    }
}


#pragma mark - bgImage
- (void)wwz_setNBImage:(NSString *)nBImage{
    
    [self wwz_setNBImage:nBImage hBImage:nil sBImage:nil];
}
- (void)wwz_setHBImage:(NSString *)hBImage{
    
    [self wwz_setNBImage:nil hBImage:hBImage sBImage:nil];
}
- (void)wwz_setNBImage:(NSString *)nBImage hBImage:(NSString *)hBImage{
    
    [self wwz_setNBImage:nBImage hBImage:hBImage sBImage:nil];
    
}
- (void)wwz_setNBImage:(NSString *)nBImage sBImage:(NSString *)sBImage{
    
    [self wwz_setNBImage:nBImage hBImage:nil sBImage:sBImage];
    
}
- (void)wwz_setNBImage:(NSString *)nBImage hBImage:(NSString *)hBImage sBImage:(NSString *)sBImage{
    
    if (nBImage) {
        [self setBackgroundImage:[UIImage imageNamed:nBImage] forState:UIControlStateNormal];
    }
    if (hBImage) {
        [self setBackgroundImage:[UIImage imageNamed:hBImage] forState:UIControlStateHighlighted];
    }
    if (sBImage) {
        [self setBackgroundImage:[UIImage imageNamed:sBImage] forState:UIControlStateSelected];
    }
}

#pragma mark - 自定义

/**
 *  文字（正常）
 */
+ (instancetype)wwz_buttonWithFrame:(CGRect)frame nTitle:(NSString *)nTitle nColor:(UIColor *)nColor tFont:(UIFont *)tFont{
    return [self wwz_buttonWithFrame:frame nTitle:nTitle sTitle:nil tFont:tFont nColor:nColor sColor:nil];
}
/**
 *  文字（正常和选中）
 */
+ (instancetype)wwz_buttonWithFrame:(CGRect)frame nTitle:(NSString *)nTitle sTitle:(NSString *)sTitle tFont:(UIFont *)tFont nColor:(UIColor *)nColor sColor:(UIColor *)sColor{
    
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    
    button.frame = frame;
    
    [button wwz_setTitleFont:tFont];
    
    [button wwz_setNTitle:nTitle sTitle:sTitle];
    [button wwz_setNColor:nColor sColor:sColor];
    
    return button;
}

/**
 *  只含图片（button大小与图片大小一样）
 */
+ (instancetype)wwz_buttonWithNImage:(NSString *)nImage sImage:(NSString *)sImage{
    
    return [self wwz_buttonWithFrame:CGRectZero nImage:nImage hImage:nil sImage:sImage];
}

/**
 *  只含图片（button大小与图片大小一样）
 */
+ (instancetype)wwz_buttonWithNImage:(NSString *)nImage hImage:(NSString *)hImage sImage:(NSString *)sImage{
    
    return [self wwz_buttonWithFrame:CGRectZero nImage:nImage hImage:hImage sImage:sImage];
}
/**
 *  只含图片（指定button frame）
 */
+ (instancetype)wwz_buttonWithFrame:(CGRect)frame nImage:(NSString *)nImage hImage:(NSString *)hImage sImage:(NSString *)sImage{
    
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    
    [button wwz_setNImage:nImage hImage:hImage sImage:sImage];
    
    if (!CGRectEqualToRect(frame, CGRectZero)) {
        
        button.frame = frame;
    }else{
        
        [button sizeToFit];
    }
    
    return button;
}


/**
 *  文字和图片（正常）
 */
+ (instancetype)wwz_buttonWithFrame:(CGRect)frame nTitle:(NSString *)nTitle tFont:(UIFont *)tFont nColor:(UIColor *)nColor nImage:(NSString *)nImage{
    return [self wwz_buttonWithFrame:frame nTitle:nTitle sTitle:nil tFont:tFont nColor:nColor sColor:nil nImage:nImage sImage:nil];
}
/**
 *  文字和图片（正常和选中）
 */
+ (instancetype)wwz_buttonWithFrame:(CGRect)frame nTitle:(NSString *)nTitle sTitle:(NSString *)sTitle tFont:(UIFont *)tFont nColor:(UIColor *)nColor sColor:(UIColor *)sColor nImage:(NSString *)nImage sImage:(NSString *)sImage{
    
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    
    [button wwz_setTitleFont:tFont];
    
    [button wwz_setNTitle:nTitle sTitle:sTitle];
    
    [button wwz_setNColor:nColor sColor:sColor];
    
    [button wwz_setNImage:nImage sImage:sImage];
    
    if (!CGRectEqualToRect(frame, CGRectZero)) {
        
        button.frame = frame;
    }else{
        
        [button sizeToFit];
    }
    
    if (nTitle&&nImage) {
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 3)];
    }
    return button;
}



#pragma mark - 其它
/**
 *  文字大小
 */
- (void)wwz_setTitleFont:(UIFont *)titleFont{
    if (titleFont) {
        self.titleLabel.font = titleFont;
    }
}
/**
 *  间隔
 */
- (void)wwz_setLeftRightInset:(CGFloat)inset{
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, inset, 0, 0)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, inset)];
}
/**
 *  方法
 */
- (void)wwz_setTarget:(id)target action:(SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - 私有

- (void)setImage:(NSString *)imageName state:(UIControlState)state{
    
    if (!imageName) {
        return;
    }
    [self setImage:[UIImage imageNamed:imageName] forState:state];
}
@end
