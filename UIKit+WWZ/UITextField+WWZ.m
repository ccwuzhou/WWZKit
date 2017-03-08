//
//  UITextField+WWZ.m
//  WWZKit
//
//  Created by wwz on 17/3/8.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UITextField+WWZ.h"

@implementation UITextField (WWZ)

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.returnKeyType = UIReturnKeyDone;
        self.borderStyle = UITextBorderStyleRoundedRect;
        if (font) {
            self.font = font;
        }
        self.placeholder = placeholder;
    }
    return self;
}

@end
