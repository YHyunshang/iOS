//
//  YHDataSource.h
//  YHTestDemo_Example
//
//  Created by Yangli on 2019/1/22.
//  Copyright © 2019年 2510479687@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^cellConfigureBefore)(id _Nonnull cell, id _Nonnull model, NSIndexPath * _Nonnull indexPath);
typedef void(^selectCellBlock)(NSIndexPath * _Nonnull indexPath, id _Nonnull model);
typedef void(^reloadBlock)(NSMutableArray * _Nonnull sourceArray);

NS_ASSUME_NONNULL_BEGIN

@interface YHDataSource : NSObject<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataSource;

- (void)addDataArray:(NSArray *)datas;

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;

- (instancetype)initWithIdentifier:(NSString *)identifier
                    configureBlock:(cellConfigureBefore)configure
                       selectBlock:(selectCellBlock)selectBlock
                        reloadData:(reloadBlock)reloadData;

@end

NS_ASSUME_NONNULL_END
