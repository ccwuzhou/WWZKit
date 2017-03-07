//
//  WWZSearchController.m
//  BCSmart
//
//  Created by wwz on 16/12/17.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WWZSearchController.h"
#define kLocalizedString(string) NSLocalizedString(string,nil)

@implementation WWZLetterItem

@end

@interface WWZSearchController ()<UISearchResultsUpdating, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) NSMutableArray *mSearchResults;

@end

@implementation WWZSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return !self.searchController.active ? self.mLetterItems.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!self.searchController.active) {// 原
        WWZLetterItem *letterItem = self.mLetterItems[section];
        return letterItem.items.count;
    }
    return self.mSearchResults.count;// 搜索结果
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    id item = nil;
    BOOL isLast = NO;
    if (!self.searchController.active) {// 原
        WWZLetterItem *letterItem = self.mLetterItems[indexPath.section];
        item = letterItem.items[indexPath.row];
        isLast = letterItem.items.count == indexPath.row+1;
    }else{// 搜索结果
        item = self.mSearchResults[indexPath.row];
        isLast = self.mSearchResults.count == indexPath.row+1;
    }
    UITableViewCell *cell = [self tableView:tableView cellForItem:item isLast:isLast];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id item = nil;
    
    if (!self.searchController.active) {// 原
        
        WWZLetterItem *letterItem = self.mLetterItems[indexPath.section];
        
        item = letterItem.items[indexPath.row];
        
    }else{// 搜索结果
        
        item = self.mSearchResults[indexPath.row];
        self.searchController.active = NO;
    }
    
    [self didSelectedItem:item];
}
//分区头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return (!self.searchController.active) ? [self.mLetterItems[section] letter] : nil;
}

//section索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return (!self.searchController.active) ? [self.mLetterItems valueForKeyPath:@"letter"] : nil;
}

//问1：行 是否可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.searchController.active) {// 原
        
        WWZLetterItem *letterItem = self.mLetterItems[indexPath.section];
        
        id item = letterItem.items[indexPath.row];
        
        return [self canDeleteRowWithItem:item];
    }else{// 搜索结果
        
        return NO;
    }
}
//问2：行 是何种编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}
//答1 确认提交编辑动作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!self.searchController.active) {// 原
        
        WWZLetterItem *letterItem = self.mLetterItems[indexPath.section];
        
        id item = letterItem.items[indexPath.row];
        
        NSMutableArray *mArr = [letterItem.items mutableCopy];
        
        [mArr removeObjectAtIndex:indexPath.row];
        
        if (mArr.count == 0) {
            [self.mLetterItems removeObjectAtIndex:indexPath.section];
            //2.更新界面
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationRight];
        }else{
            letterItem.items = mArr;
            //2.更新界面
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        }
        [self didCommitDeleteRowWithItem:item];
    }
}
#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    [self.mSearchResults removeAllObjects];
    
    [self.mSearchResults addObjectsFromArray:[self filteredItemsWihtSearchingText:searchController.searchBar.text]];
    //刷新表格
    [self.tableView reloadData];
}
#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:YES animated:YES];
    
    for (UIView *view in [searchBar subviews]) {
        
        if (![view isKindOfClass:NSClassFromString(@"UIView")]) continue;
        
        for (UIView *subView in view.subviews) {
            
            if (![subView isKindOfClass:NSClassFromString(@"UINavigationButton")]) continue;
            
            UIButton *btn = (UIButton *)subView;
            [btn setTitle:kLocalizedString(@"cancel") forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            break;
        }
    }
}
#pragma mark - 子类中实现
- (UITableViewCell *)tableView:(UITableView *)tableView cellForItem:(id)item isLast:(BOOL)isLast{
    
    return nil;
}
- (void)didSelectedItem:(id)item{}
- (NSArray *)filteredItemsWihtSearchingText:(NSString *)searchingText{return nil;}
- (BOOL)canDeleteRowWithItem:(id)item{return NO;}

- (void)didCommitDeleteRowWithItem:(id)item{}

#pragma mark - getter
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
        
        _tableView.tableHeaderView = self.searchController.searchBar;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (UISearchController *)searchController{
    
    if (!_searchController) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        _searchController.searchBar.frame = CGRectMake(0, 0, 0, 44);
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.searchResultsUpdater = self;
        [_searchController.searchBar sizeToFit];
        _searchController.searchBar.delegate = self;
    }
    return _searchController;
}

- (NSMutableArray *)mSearchResults{
    
    if (!_mSearchResults) {
        _mSearchResults = [NSMutableArray array];
    }
    return _mSearchResults;
}
@end
