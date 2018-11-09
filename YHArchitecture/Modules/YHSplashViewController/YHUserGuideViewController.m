//
//  YHUserGuideViewController.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/29.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHUserGuideViewController.h"
#define GUIDE_IMAGES @[@"guide01",@"guide02",@"guide03",@"guide04",@"guide05"]

@interface YHUserGuideViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (strong,nonatomic) UIButton *button;

@end

@implementation YHUserGuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCollectionView];
}

- (void)initCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //行距
    layout.minimumLineSpacing = 0;
    // 间距
    layout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.dataSource = self;
    [collectionView setPagingEnabled:YES];
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [button addTarget:self action:@selector(disMissGuideView) forControlEvents:UIControlEventTouchUpInside];
    self.button = button;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 从缓存池里取
    // UICollectionViewCell 没有UIImageView
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // 取出每行的item，对应的背景名
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    imageview.image = YHImage(GUIDE_IMAGES[indexPath.row]);
    cell.backgroundView = imageview;
    
    for (UIView *view in cell.subviews) {
        if ([view isEqual:self.button]) {
            [self.button removeFromSuperview];
        }
    }
    
    if (indexPath.row == GUIDE_IMAGES.count-1) {
        [cell addSubview:self.button];
    }
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return GUIDE_IMAGES.count;
}

- (void)disMissGuideView
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self back];
    }];
}

- (void)back
{
    if (self.finishAndBack) {
        self.finishAndBack();
    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
