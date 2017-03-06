//
//  BCShowView.m
//  wwz
//
//  Created by wwz on 16/8/9.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import "WZShowView.h"

static NSTimeInterval kAnimationDuration = 0.3;

@implementation WZShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

#pragma mark - 显示

- (void)wwz_show{
    
    [self wwz_showCompletion:nil];
}

- (void)wwz_showCompletion:(void (^)(BOOL finished))completion{
    
    // 背景view
    UIButton *containButton = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    containButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [containButton addTarget:self action:@selector(wwz_dismiss) forControlEvents:UIControlEventTouchUpInside];
    [containButton addSubview:self];
    
    // 添加到window上
    [[UIApplication sharedApplication].keyWindow addSubview:containButton];
    
    containButton.alpha = 0;
    
    __block CGRect selfFrame = self.frame;
    
    selfFrame.origin.y = CGRectGetMaxY(containButton.frame);
    self.frame = selfFrame;
    
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         
                         containButton.alpha = 1;
                         
                         selfFrame.origin.y = CGRectGetMaxY(containButton.frame)-selfFrame.size.height;
                         
                         self.frame = selfFrame;
                     }
                     completion:completion];
    
}


#pragma mark - 隐藏

- (void)wwz_dismiss{
    self.transform = CGAffineTransformMakeTranslation(1, 1);
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         
                         CGRect selfFrame = self.frame;
                         
                         selfFrame.origin.y = CGRectGetMaxY(self.superview.frame);
                         
                         self.frame = selfFrame;
                         
                         self.superview.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         
                         [self.superview removeFromSuperview];
                         [self removeFromSuperview];

                     }];
}
- (void)dealloc{
    NSLog(@"%s", __func__);
}

@end
