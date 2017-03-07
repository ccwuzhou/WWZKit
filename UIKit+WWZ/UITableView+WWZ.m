//
//  UITableView+WWZ.m
//  WWZKit
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UITableView+WWZ.h"

@implementation UITableView (WWZ)

+ (instancetype)wwz_tableViewWithFrame:(CGRect)frame dataSource:(id <UITableViewDataSource>)dataSource delegate:(id <UITableViewDelegate>)delegate{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    
    return tableView;
}
////去掉 UItableview headerview 黏性(sticky)
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.tableView)
//    {
//        CGFloat sectionHeaderHeight = 30; //sectionHeaderHeight
//        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
//}
@end
