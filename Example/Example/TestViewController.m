//
//  TestViewController.m
//  Example
//
//  Created by apple on 2017/5/5.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "TestViewController.h"
#import <WWZKit/WWZKit.h>
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.title = @"车辆统计";
    vc1.view.backgroundColor = [UIColor redColor];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.title = @"车辆统";
    vc2.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.title = @"车辆";
    vc3.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.title = @"车";
    vc4.view.backgroundColor = [UIColor orangeColor];
    
    WWZSegementScrollView *view = [[WWZSegementScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-64)];
    view.segementControllers = @[vc1, vc2, vc3, vc4];
    view.segementView.segementType = WWZSegementTypeBottomLine;
    
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
