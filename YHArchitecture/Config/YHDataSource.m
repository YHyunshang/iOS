//
//  YHDataSource.m
//  YHTestDemo_Example
//
//  Created by Yangli on 2019/1/22.
//  Copyright © 2019年 2510479687@qq.com. All rights reserved.
//

#import "YHDataSource.h"

@interface YHDataSource ()
//sb
@property (nonatomic, strong) IBInspectable NSString *cellIdentifier;

@property (nonatomic, copy) cellConfigureBefore cellConfigureBefore;
@property (nonatomic, copy) selectCellBlock selectBlock;
@property (nonatomic, copy) reloadBlock reloadData;
@end

@implementation YHDataSource

- (void)addDataArray:(NSArray *)datas
{
    if(!datas) return;
    
    if (self.dataSource.count > 0) {
        [self.dataSource removeAllObjects];
    }
    
    [self.dataSource addObjectsFromArray:datas];
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath
{
    return self.dataSource.count > indexPath.row ? self.dataSource[indexPath.row] : nil;
}

- (instancetype)initWithIdentifier:(NSString *)identifier
                    configureBlock:(cellConfigureBefore)configure
                       selectBlock:(selectCellBlock)selectBlock
                        reloadData:(reloadBlock)reloadData
{
    self = [super init];
    if(self) {
        _cellIdentifier = identifier;
        _cellConfigureBefore = [configure copy];
        _selectBlock = [selectBlock copy];
        _reloadData = [reloadData copy];
    }
    return self;
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return !self.dataSource  ? 0: self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }
    return cell;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return !self.dataSource  ? 0: self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    id model = [self modelsAtIndexPath:indexPath];
    
    if(self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model,indexPath);
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 将点击事件通过block的方式传递出去
    if (self.selectBlock) {
        self.selectBlock(indexPath, self.dataSource[indexPath.row]);
    }
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 将点击事件通过block的方式传递出去
    if (self.selectBlock) {
        self.selectBlock(indexPath, self.dataSource[indexPath.row]);
    }
}

- (NSMutableArray *)dataArray
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak __typeof(self) weakSelf = self;
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        //在这里添加点击事件
        [weakSelf.dataArray removeObjectAtIndex:indexPath.row];
        weakSelf.reloadData(weakSelf.dataArray);
        NSLog(@"shanchu");
    }];
    //    // 添加一个编辑按钮
    //    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"复制"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
    //        //
    //
    //        //在这里添加点击事件
    //        [weakSelf.dataArray insertObject:weakSelf.dataArray[indexPath.row] atIndex:indexPath.row];
    //        weakSelf.reloadData(weakSelf.dataArray);
    //    }];
    //    topRowAction.backgroundColor = [UIColor cyanColor];
    // 将设置好的按钮放到数组中返回
    return @[deleteRowAction];
}




@end
