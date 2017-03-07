//
//  ViewController.m
//  Example
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "ViewController.h"
#import <WWZKit/WWZKit.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    WWZShowView *showView = [[WWZShowView alloc] initWithFrame:CGRectMake(0, 0, 250, 250) showType:WWZShowViewTypeBottom];
    [showView wwz_showCompletion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
