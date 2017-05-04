//
//  UIAlertController+WWZ.h
//  WWZKit
//
//  Created by apple on 2017/4/23.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (WWZ)

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle buttonTitles:(NSArray *)buttonTitles clickButtonAtIndex:(void(^)(int index))block;

@end
