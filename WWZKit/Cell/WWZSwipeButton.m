//
//  WWZSwipeButton.m
//  WZCategoryTool
//
//  Created by wwz on 16/4/30.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WWZSwipeButton.h"

@implementation WWZSwipeButton

+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color
{
    return [self wwz_buttonWithTitle:title image:nil backgroundColor:color];
}

+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color padding:(NSInteger)padding
{
    return [self wwz_buttonWithTitle:title image:nil backgroundColor:color insets:UIEdgeInsetsMake(0, padding, 0, padding)];
}

+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color insets:(UIEdgeInsets)insets
{
    return [self wwz_buttonWithTitle:title image:nil backgroundColor:color insets:insets];
}

+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color callback:(WZSwipeButtonCallBack)callback
{
    return [self wwz_buttonWithTitle:title image:nil backgroundColor:color callback:callback];
}

+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color padding:(NSInteger)padding callback:(WZSwipeButtonCallBack)callback
{
    return [self wwz_buttonWithTitle:title image:nil backgroundColor:color insets:UIEdgeInsetsMake(0, padding, 0, padding)callback:callback];
}

+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color insets:(UIEdgeInsets)insets callback:(WZSwipeButtonCallBack)callback
{
    return [self wwz_buttonWithTitle:title image:nil backgroundColor:color insets:insets callback:callback];
}

+ (instancetype)wwz_buttonWithTitle:(NSString *)title image:(UIImage*)image backgroundColor:(UIColor *)color
{
    return [self wwz_buttonWithTitle:title image:image backgroundColor:color callback:nil];
}

+ (instancetype)wwz_buttonWithTitle:(NSString *)title image:(UIImage*)image backgroundColor:(UIColor *)color padding:(NSInteger)padding
{
    return [self wwz_buttonWithTitle:title image:image backgroundColor:color insets:UIEdgeInsetsMake(0, padding, 0, padding)callback:nil];
}

+ (instancetype)wwz_buttonWithTitle:(NSString *)title image:(UIImage*)image backgroundColor:(UIColor *)color insets:(UIEdgeInsets)insets
{
    return [self wwz_buttonWithTitle:title image:image backgroundColor:color insets:insets callback:nil];
}

+ (instancetype)wwz_buttonWithTitle:(NSString *)title image:(UIImage*)image backgroundColor:(UIColor *)color callback:(WZSwipeButtonCallBack)callback
{
    return [self wwz_buttonWithTitle:title image:image backgroundColor:color padding:10 callback:callback];
}

+ (instancetype)wwz_buttonWithTitle:(NSString *)title image:(UIImage*)image backgroundColor:(UIColor *)color padding:(NSInteger)padding callback:(WZSwipeButtonCallBack)callback
{
    return [self wwz_buttonWithTitle:title image:image backgroundColor:color insets:UIEdgeInsetsMake(0, padding, 0, padding)callback:callback];
}

+ (instancetype)wwz_buttonWithTitle:(NSString *)title
                              image:(UIImage *)image
                    backgroundColor:(UIColor *)color
                             insets:(UIEdgeInsets)insets
                           callback:(WZSwipeButtonCallBack)callback{
    WWZSwipeButton * button = [self buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    button.callBack = callback;
    [button setEdgeInsets:insets];
    return button;
}

- (BOOL)callWZSwipeConvenienceCallback:(UITableViewCell *)sender
{
    if (_callBack){
        return _callBack(sender);
    }
    return NO;
}

- (void)centerIconOverText{
    
    [self centerIconOverTextWithSpacing: 3.0];
}

- (void)centerIconOverTextWithSpacing:(CGFloat)spacing {
    CGSize size = self.imageView.image.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -size.width, -(size.height + spacing),0.0);
    size = [self.titleLabel.text sizeWithAttributes:@{ NSFontAttributeName: self.titleLabel.font }];
    self.imageEdgeInsets = UIEdgeInsetsMake(-(size.height + spacing), 0.0, 0.0, -size.width);
}

- (void)setPadding:(CGFloat)padding{
    
    self.contentEdgeInsets = UIEdgeInsetsMake(0, padding, 0, padding);
    [self sizeToFit];
}


- (void)setEdgeInsets:(UIEdgeInsets)insets{
    
    self.contentEdgeInsets = insets;
    [self sizeToFit];
}

@end
