//
//  UITableView+WWZ.h
//  WWZKit
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (WWZ)

+ (instancetype)wwz_tableViewWithFrame:(CGRect)frame dataSource:(id <UITableViewDataSource>)dataSource delegate:(id <UITableViewDelegate>)delegate;

@end
