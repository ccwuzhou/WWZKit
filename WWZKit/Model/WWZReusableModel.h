//
//  WWZReusableModel.h
//  wwz
//
//  Created by wwz on 16/8/4.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWZReusableModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) UIImage *image;

+ (instancetype)reusableModelWithTitle:(NSString *)title image:(UIImage *)image;

@end
