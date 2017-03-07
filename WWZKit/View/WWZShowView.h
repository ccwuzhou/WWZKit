//
//  BCShowView.h
//  wwz
//
//  Created by wwz on 16/8/9.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WWZShowViewType) {
    WWZShowViewTypeNone,
    WWZShowViewTypeTop,
    WWZShowViewTypeLeft,
    WWZShowViewTypeRight,
    WWZShowViewTypeBottom
};

@interface WWZShowView : UIView

@property (nonatomic, assign, getter=isTapEnabled) BOOL tapEnabled;

- (instancetype)initWithFrame:(CGRect)frame showType:(WWZShowViewType)showType;

#pragma mark - 显示
- (void)wwz_showCompletion:(void (^)(BOOL finished))completion;


#pragma mark - 隐藏
- (void)wwz_dismiss;

@end
