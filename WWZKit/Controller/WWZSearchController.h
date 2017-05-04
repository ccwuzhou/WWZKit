//
//  WWZSearchController.h
//  BCSmart
//
//  Created by wwz on 16/12/17.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WWZViewController.h"

@interface WWZLetterItem : NSObject

/**
 *  首字母
 */
@property (nonatomic, copy) NSString *letter;

/**
 *  letter对应的数组@[item]
 */
@property (nonatomic, strong) NSArray *items;

@end


@interface WWZSearchController : WWZViewController

@property (nonatomic, strong) UITableView *tableView;

/**
 *  @[WWZLetterItem]
 */
@property (nonatomic, strong) NSMutableArray *mLetterItems;


#pragma mark - 子类中必须重载的方法
/**
 *  通过模型item得到cell
 *  item:模型
 *  isLast:是否是最后一行cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForItem:(id)item isLast:(BOOL)isLast;

/**
 *  选择模型
 */
- (void)didSelectedItem:(id)item;

/**
 *  通过输入文本，筛选搜索结果，返回结果模型数组@[item]
 */
- (NSArray *)filteredItemsWihtSearchingText:(NSString *)searchingText;

/**
 *  行能否删除
 */
- (BOOL)canDeleteRowWithItem:(id)item;

/**
 *  执行删除行
 */
- (void)didCommitDeleteRowWithItem:(id)item;

@end
