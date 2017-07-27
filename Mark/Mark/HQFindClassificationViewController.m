//
//  HQFindClassificationViewController.m
//  Mark
//
//  Created by hong on 2017/7/27.
//  Copyright © 2017年 hong. All rights reserved.
//  分类查找界面

#import "HQFindClassificationViewController.h"
#import "classifyModel.h"
#import "ClassificationModel.h"
#import "GlobalHeader.h"

@interface HQFindClassificationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation HQFindClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"分类查找";
    [self setupUI];

    // Do any additional setup after loading the view.
}
-(void)setupUI{
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake((kScreenWidth -40)/3, (kScreenWidth -40)*4/9);
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    flowLayout.minimumLineSpacing = 10;//设置每个item之间的间距
    //  搜索框的高度为40
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) collectionViewLayout:nil];
    collectionView.backgroundColor =BackgroundColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = YES;
    
    _collectionView=collectionView;
    
    [self.collectionView registerClass:[searchCell class] forCellWithReuseIdentifier:CellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
