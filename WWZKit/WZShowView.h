//
//  BCShowView.h
//  wwz
//
//  Created by wwz on 16/8/9.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZShowView : UIView


#pragma mark - 显示

- (void)wwz_show;
- (void)wwz_showCompletion:(void (^)(BOOL finished))completion;


#pragma mark - 隐藏

- (void)wwz_dismiss;

@end
