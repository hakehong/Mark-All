//
//  HQFindClassificationViewController.m
//  Mark
//
//  Created by hong on 2017/7/27.
//  Copyright © 2017年 hong. All rights reserved.
//  分类查找界面
#define pading  20
#define separateLine  0.5
#import "HQFindClassificationViewController.h"
#import "classifyModel.h"
#import "ClassificationModel.h"
#import "GlobalHeader.h"
#import "imageNameCell.h"
#import "nameCollectionViewCell.h"
#import "HttpTool.h"
#import "YYModel.h"
#import "UIImageView+WebCache.h"

static NSString *const Url =@"http://api.markapp.cn/v160/singles/groupcat?";
static NSString *const CellID1 =@"imageNameCell";
static NSString *const CellID2 =@"nameCollectionViewCell";
@interface HQFindClassificationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *sectionArray;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation HQFindClassificationViewController
{
    ClassificationModel *listModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"分类查找";
//    [self setupUI];
    [self getData];
    self.sectionArray =[NSMutableArray array];
    self.dataArray =[NSMutableArray array];

    // Do any additional setup after loading the view.
}
-(void)setupUI{
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake((kScreenWidth -40)/3, (kScreenWidth -40)*4/9);
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    flowLayout.minimumLineSpacing = 10;//设置每个item之间的间距
    //  搜索框的高度为40
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(pading, 64, kScreenWidth-2*pading, kScreenHeight-64) collectionViewLayout:nil];
    collectionView.backgroundColor =BackgroundColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = YES;
    
    _collectionView=collectionView;
    [self.collectionView registerClass:[imageNameCell class] forCellWithReuseIdentifier:CellID1];
    [self.collectionView registerClass:[nameCollectionViewCell class] forCellWithReuseIdentifier:CellID2];
}
-(void)getData{
    
    [HttpTool get:Url withCompletionBlock:^(id returnValue) {
//        listModel =[ClassificationModel yy_modelWithDictionary:returnValue];
        NSArray *arr =[NSArray arrayWithArray:returnValue[@"data"]];
        for (int i=0; i<arr.count;i++) {
            ClassificationModel *model =[ClassificationModel yy_modelWithJSON:arr[i]];
            [self.dataArray addObject:model];
            
        }
        NSLog(@"%@",self.dataArray);
        //        CompletionBlock(_movieList);
        [self.collectionView reloadData];
    } withFailureBlock:^(NSError *error) {
        nil;
    }];
}
//定义每个UICollectionView 的边距
- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    return UIEdgeInsetsMake ( separateLine , separateLine , separateLine , separateLine );
}
//设置水平间距 (同一行的cell的左右间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return separateLine;
}
//垂直间距 (同一列cell上下间距)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return separateLine;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.dataArray.count >0) {
        ClassificationModel *model =[ClassificationModel yy_modelWithJSON:self.dataArray[section]];
        return model.cat.count;
    }
    return 0;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
       imageNameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID1 forIndexPath:indexPath];
        ClassificationModel *listModel =[ClassificationModel yy_modelWithJSON:self.dataArray[indexPath.section]];
        
        classifyModel *model =[classifyModel yy_modelWithJSON:listModel.cat[indexPath]];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
        cell.nameLabel.text = model.name;
        return cell;
    }else{
        nameCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID2 forIndexPath:indexPath];
        return cell;
 
    }
//    return cell;
    
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
