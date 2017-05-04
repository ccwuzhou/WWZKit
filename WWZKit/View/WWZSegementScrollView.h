//
//  WWZSegementScrollView.h
//  test
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 wwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWZSegementView;

@interface WWZSegementScrollView : UIView

@property (nonatomic, strong) WWZSegementView *segementView;

- (instancetype)initWithFrame:(CGRect)frame controllers:(NSArray *)controllers;

@end
