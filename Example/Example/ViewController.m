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

//    WWZShowView *showView = [[WWZShowView alloc] initWithFrame:CGRectMake(30, 30, 250, 250) showType:WWZShowViewTypeRight];
//    showView.backgroundColor = [UIColor redColor];
//    [showView wwz_showCompletion:nil];
    
    
//    WWZTipView *tipView = [[WWZTipView alloc] initWithTitle:@"确定确定确定确定确定确定确定确定确定确定" titleFont:[UIFont systemFontOfSize:16] lineSpacing:5 buttonTitles:@[@"取消", @"确定"] clickButtonBlock:^(int index) {
//        
//        NSLog(@"%d", index);
//    }];
//    [tipView wwz_showCompletion:nil];
    
    WWZInputView *inputView = [[WWZInputView alloc] initWithTitle:@"确定确定确定" text:@"123" placeHolder:@"123" buttonTitles:@[@"取消", @"确定"] clickButtonAtIndex:^(NSString *inputText, int index) {
       
        NSLog(@"%@-%d", inputText, index);
    }];
    [inputView wwz_showCompletion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
