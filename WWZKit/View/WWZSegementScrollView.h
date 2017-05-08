//
//  WWZSegementScrollView.h
//  test
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 wwz. All rights reserved.
//

#import "WWZSegementView.h"

@interface WWZSegementScrollView : UIView

/**
 *  控制器集合
 */
@property (nonatomic, strong, readonly) NSArray *segementControllers;

/**
 *  切换segementView，需先设置控制器
 */
@property (nonatomic, strong, readonly) WWZSegementView *segementView;

- (instancetype)initWithFrame:(CGRect)frame segementViewFrame:(CGRect)segementViewFrame controllers:(NSArray *)controllers;
@end
