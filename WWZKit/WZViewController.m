//
//  WZViewController.m
//  wwz
//
//  Created by wwz on 16/8/4.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import "WZViewController.h"

@interface WZViewController ()

@end

@implementation WZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 解决设备navbar背景translucent为no是根视图下移问题
//    self.extendedLayoutIncludesOpaqueBars = YES;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}


- (BOOL)shouldAutorotate{
    
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
    
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    
    return UIInterfaceOrientationPortrait;
}
@end
