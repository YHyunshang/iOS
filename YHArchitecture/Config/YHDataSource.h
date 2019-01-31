//
//  YHDataSource.h
//  YHTestDemo_Example
//
//  Created by Yangli on 2019/1/22.
//  Copyright © 2019年 2510479687@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^cellConfigureBefore)(id cell, id model, NSIndexPath *indexPath);
typedef void(^selectCellBlock)(NSIndexPath *indexPath, id model);
typedef void(^reloadBlock)(NSMutableArray *sourceArray);

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
