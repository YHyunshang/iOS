//
//  YLSingleDataSource.h
//  YLDataSource
//
//  Created by Yangli on 2019/5/8.
//


#import <Foundation/Foundation.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^yh_cellConfigureBefore)(id _Nonnull cell, id _Nonnull model, NSIndexPath *_Nonnull indexPath);
typedef void(^yh_selectCellBlock)(NSIndexPath *_Nonnull indexPath, id _Nonnull model);
typedef void(^yh_reloadBlock)(NSMutableArray *_Nonnull sourceArray);
typedef void(^yh_emptyImage)(UIImage *_Nonnull image);
typedef void(^yh_emptyTitle)(NSAttributedString *_Nonnull title);
typedef void(^yh_emptyTapAction)(BOOL refresh);
typedef CGFloat(^yh_cellHeightBlock)(id _Nonnull mode, NSIndexPath *indexPath);


/**
 单样式cell处理工具
 */
@interface YHSingleDataSource : NSObject<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/**
 追加数据源

 @param datas 追加数据源数组
 */
- (void)addDataArray:(NSArray *)datas;

/**
 刷新数据源

 @param datas 待刷新数据源
  该数据源为空是不进行清空源数据源操作
 */
- (void)refreshDataArray:(NSArray *)datas;

/**
 返回indexPath的模型

 @param indexPath indexPath
 @return model模型
 */
- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;

/**
 快捷配置
 
 @param identifier 重用标识
 @param configure cell配置
 @param selectBlock 选中回调
 @param reloadData 增删数据源回调
 @return YLDataSource实例
 */
- (instancetype)initWithIdentifier:(NSString *)identifier
                    configureBlock:(yh_cellConfigureBefore)configure
                       selectBlock:(yh_selectCellBlock)selectBlock
                        reloadData:(yh_reloadBlock)reloadData;

/**
 含空视图快捷配置(可配置行高)
 
 @param identifier 重用标识
 @param configure cell配置
 @param cellHeight 行高回调block
 @param emptyImage 无数据显示图
 @param emptyTitle 无数据富文本提示文字
 @param selectBlock 选中回调
 @param emptyAction 空视图点击回调
 @param reloadData 增删数据源回调
 @return YLDataSource实例
 */
- (instancetype)initWithIdentifier:(NSString *)identifier
                        emptyImage:(UIImage *)emptyImage
                        emptyTitle:(NSAttributedString *)emptyTitle
                    configureBlock:(yh_cellConfigureBefore)configure
                        cellHeight:(yh_cellHeightBlock)cellHeight
                       selectBlock:(yh_selectCellBlock)selectBlock
                       emptyAction:(yh_emptyTapAction)emptyAction
                        reloadData:(yh_reloadBlock)reloadData;
@end

NS_ASSUME_NONNULL_END
