//
//  YHUserGuideViewController.m
//  YHArchitecture
//
//  Created by Yangli on 2018/10/29.
//  Copyright © 2018年 永辉. All rights reserved.
//

#import "YHUserGuideViewController.h"
#define GUIDE_IMAGES @[@"guide01",@"guide02",@"guide03",@"guide04",@"guide05"]
#define GUIDE_BUTTONHEIGHT  30

@interface YHUserGuideViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/** skipBtn */
@property (strong,nonatomic) UIButton *skipBtn;

@end

@implementation YHUserGuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addSubViews];
}

- (void)addSubViews
{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.skipBtn];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.skipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.right.mas_equalTo(-30);
        make.size.mas_equalTo(CGSizeMake(75, GUIDE_BUTTONHEIGHT));
    }];
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

#pragma mark ============================    lazy method    ============================
- (UIButton *)skipBtn
{
    if (!_skipBtn) {
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _skipBtn.backgroundColor = [UIColor blackColor];
        _skipBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _skipBtn.alpha = 0.5;
        _skipBtn.layer.cornerRadius = GUIDE_BUTTONHEIGHT/2;
        [_skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [_skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_skipBtn addTarget:self action:@selector(disMissGuideView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipBtn;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = [UIScreen mainScreen].bounds.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //行距
        layout.minimumLineSpacing = 0;
        // 间距
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        _collectionView.dataSource = self;
        [_collectionView setPagingEnabled:YES];
    }
    return _collectionView;
}
@end
