//
//  WWZSwipeButton.h
//  WZCategoryTool
//
//  Created by wwz on 16/4/30.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWZSwipeButton : UIButton

typedef BOOL (^WZSwipeButtonCallBack)(UITableViewCell *cell);

@property (nonatomic, copy) WZSwipeButtonCallBack callBack;


+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color;

+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color padding:(NSInteger)padding;

+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color insets:(UIEdgeInsets)insets;

+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color callback:(WZSwipeButtonCallBack)callback;
+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color padding:(NSInteger)padding callback:(WZSwipeButtonCallBack)callback;

+ (instancetype)wwz_buttonWithTitle:(NSString *)title backgroundColor:(UIColor *)color insets:(UIEdgeInsets)insets callback:(WZSwipeButtonCallBack)callback;

+ (instancetype)wwz_buttonWithTitle:(NSString *)title image:(UIImage*)image backgroundColor:(UIColor *)color;

+ (instancetype)wwz_buttonWithTitle:(NSString *)title image:(UIImage*)image backgroundColor:(UIColor *)color padding:(NSInteger)padding;

+ (instancetype)wwz_buttonWithTitle:(NSString *)title image:(UIImage*)image backgroundColor:(UIColor *)color insets:(UIEdgeInsets)insets;

+ (instancetype)wwz_buttonWithTitle:(NSString *)title image:(UIImage*)image backgroundColor:(UIColor *)color callback:(WZSwipeButtonCallBack)callback;

+ (instancetype)wwz_buttonWithTitle:(NSString *)title image:(UIImage*)image backgroundColor:(UIColor *)color padding:(NSInteger)padding callback:(WZSwipeButtonCallBack)callback;

+ (instancetype)wwz_buttonWithTitle:(NSString *)title
                              image:(UIImage *)image
                    backgroundColor:(UIColor *)color
                             insets:(UIEdgeInsets)insets
                           callback:(WZSwipeButtonCallBack)callback;

- (BOOL)callWZSwipeConvenienceCallback:(UITableViewCell *)sender;

- (void)centerIconOverText;

- (void)centerIconOverTextWithSpacing:(CGFloat)spacing;

- (void)setPadding:(CGFloat)padding;


- (void)setEdgeInsets:(UIEdgeInsets)insets;
@end
