//
//  WWZReusableModel.m
//  wwz
//
//  Created by wwz on 16/8/4.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import "WWZReusableModel.h"

@implementation WWZReusableModel

+ (instancetype)reusableModelWithTitle:(NSString *)title image:(UIImage *)image{
    
    return [[self alloc] initWithTitle:title image:image];
}

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image
{
    self = [super init];
    if (self) {
        
        _title = title;
        _image = image;
    }
    return self;
}

@end
