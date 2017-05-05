//
//  ViewController.m
//  Example
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "ViewController.h"

#import "TestViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView = [UITableView wwz_tableViewWithFrame:self.view.bounds dataSource:self delegate:self];
//    [self.view addSubview:self.tableView];

    
   
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WWZTableViewCell *cell = [WWZTableViewCell wwz_cellWithTableView:tableView style:WWZTableViewCellStyleSubAndSwitchView];
    cell.textLabel.text = [NSString stringWithFormat:@"点击了点击了点击了点击了点击了点击了点击了点击了%d", indexPath.row];
    cell.subLabel.text = [NSString stringWithFormat:@"点击了点击了点击了点击了点击了点击了点击了%d", indexPath.row];
    cell.rightLabel.text = [NSString stringWithFormat:@"点击了点击了点击了点击了点击了点击了点击了%d", indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog([NSString stringWithFormat:@"点击了%d", indexPath.row]);
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
    
//    WWZInputView *inputView = [[WWZInputView alloc] initWithTitle:@"确定确定确定" text:@"123" placeHolder:@"123" buttonTitles:@[@"取消", @"确定"] clickButtonAtIndex:^(NSString *inputText, int index) {
//       
//        NSLog(@"%@-%d", inputText, index);
//    }];
//    [inputView wwz_showCompletion:nil];
    
    TestViewController *vc = [[TestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
