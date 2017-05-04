//
//  WWZButton.m
//  BCSmart
//
//  Created by wwz on 16/10/27.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WWZButton.h"

@implementation WWZButton

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGRect imageFrame = self.imageView.frame;
    CGRect titleFrame = self.titleLabel.frame;
    
    // title
    titleFrame.size = [self.titleLabel textRectForBounds:self.bounds limitedToNumberOfLines:1].size;
    
    // imageView
    CGFloat spaceY = _spaceY == 0 ? 5 : _spaceY;
    
    imageFrame.origin.x = (self.bounds.size.width-imageFrame.size.width)*0.5;
    imageFrame.origin.y = (self.frame.size.height-imageFrame.size.height-titleFrame.size.height-spaceY)*0.5;
    
    
    titleFrame.origin.x = (self.bounds.size.width-titleFrame.size.width)*0.5;
    titleFrame.origin.y = CGRectGetMaxY(imageFrame)+spaceY;
    

    self.imageView.frame = imageFrame;
    
    self.titleLabel.frame = titleFrame;
}
@end




