//
//  UIAlertController+WWZ.m
//  WWZKit
//
//  Created by apple on 2017/4/23.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UIAlertController+WWZ.h"

@implementation UIAlertController (WWZ)

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle buttonTitles:(NSArray *)buttonTitles clickButtonAtIndex:(void(^)(int index))block
{
    self = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    if (self) {
        
        for (NSString *buttonTitle in buttonTitles) {
            
            int index = [buttonTitles indexOfObject:buttonTitle];
            
            UIAlertActionStyle style = index == 0 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault;
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitle style:style handler:^(UIAlertAction * _Nonnull action) {
                
                block(index);
            }];
            
            [self addAction:action];
        }
    }
    return self;
}

@end
