//
//  ViewController.m
//  Mark
//
//  Created by hongqing on 16/3/5.
//  Copyright © 2016年 hongqing. All rights reserved.
//


#define pading 10
#import "SearchViewController.h"
#import "HttpTool.h"
#import "seachMovieList.h"
#import "searchMovie.h"
#import "NSObject+YYModel.h"
#import "UIImageView+WebCache.h"
#import "searchCell.h"
#import "imageAll.h"
#import "GlobalHeader.h"
#import "Masonry.h"
#import "HQTextField.h"
static NSString *const searchUrl =@"https://api.douban.com//v2/movie/search?q=";
static NSString *const CellID =@"searchCell";
@interface SearchViewController ()<UITextFieldDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong) seachMovieList *list;
@property (nonatomic , strong) UICollectionView *collectionView;
@property (strong, nonatomic)  UIView *centerView;

@property (strong, nonatomic)  HQTextField *searchTextField;

@property (strong, nonatomic)  UILabel *firstLabel;
@property (strong, nonatomic)  UILabel *secondLabel;
@property (nonatomic,strong) UIImageView *colonImage;

//- (IBAction)movieListBtn:(UIButton *)sender;

@property(nonatomic,strong)UILabel *label;
@end

@implementation SearchViewController
#pragma mark 懒加载
-(HQTextField *)searchTextField{
    if (!_searchTextField) {
        _searchTextField =[[HQTextField alloc]init];
        _searchTextField.backgroundColor =[UIColor whiteColor];
        //    _searchTextField.placeholder =@"输入电影名/导演/演员/编剧";
        _searchTextField.font = [UIFont systemFontOfSize:14];
        NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"输入电影名/导演/演员/编剧" attributes:
                                          @{NSForegroundColorAttributeName:RGB(163, 170, 172),
                                            NSFontAttributeName:_searchTextField.font
                                            }];
        _searchTextField.attributedPlaceholder = attrString;
        _searchTextField.delegate =self;
    }
    return _searchTextField ;
}
-(UILabel *)firstLabel{
    if (!_firstLabel) {
        _firstLabel =[[UILabel alloc]init];
        _firstLabel.textColor = [UIColor blackColor];
        _firstLabel.numberOfLines =0;
        _firstLabel.font =[UIFont systemFontOfSize:14];
        
    }
    return _firstLabel;
}
-(UILabel *)secondLabel{
    if (!_secondLabel) {
        _secondLabel =[[UILabel alloc]init];
        _secondLabel.textColor =GlobalBg;
        
    }
    return _secondLabel;
}
-(UIImageView *)colonImage{
    if (!_colonImage) {
        _colonImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchEmptyIcon"]];
    }
    return _colonImage;
}
-(UIView *)centerView{
    if (!_centerView) {
        _centerView =[[UIView alloc]init];
        
    }
    return _centerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton =YES;
    self.title =@"搜索";
    self.view.backgroundColor =BackgroundColor;
    [self setupUI];
     [_searchTextField addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.collectionView reloadData];
//    });
//    [self.collectionView reloadData];
    [self setSearchView];
    [self getTheLines];
    
}
-(void)getTheLines{
    NSString *url =@"http://api.markapp.cn/v160/resources/lines?";
    [HttpTool get:url withCompletionBlock:^(id returnValue) {
        NSDictionary *dic =returnValue;
        self.firstLabel.text =dic[@"data"][@"word"];
        self.secondLabel.text =dic[@"data"][@"title"];
        
    } withFailureBlock:^(NSError *error) {
        nil;
    }];

}
-(void)setupUI{
    
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"checkCloseIcon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
    [self.view addSubview:self.searchTextField];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.equalTo(@40);
    }];
    [self.view addSubview:self.centerView];
    [self.centerView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.searchTextField.mas_bottom).offset(80);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@80);
    }];
    [self.centerView addSubview:self.colonImage];
    [self.centerView addSubview:self.firstLabel];
    [self.centerView addSubview:self.secondLabel];
    [self.colonImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerView.mas_left).offset(60);
        make.top.equalTo(self.centerView.mas_top);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerView.mas_centerX);
        make.top.equalTo(self.colonImage.mas_bottom).offset(8);
        make.left.equalTo(self.colonImage.mas_left);
        make.right.equalTo(self.centerView.mas_right).offset(-60);
    }];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstLabel.mas_bottom).offset(20);
        make.right.equalTo(self.firstLabel.mas_right);
    }];
}
-(void)dismissVC{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setSearchView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((kScreenWidth -40)/3, (kScreenWidth -40)*4/9);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.minimumLineSpacing = 10;//设置每个item之间的间距
//  搜索框的高度为40
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 104, kScreenWidth, kScreenHeight-104) collectionViewLayout:flowLayout];
    collectionView.backgroundColor =BackgroundColor;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsVerticalScrollIndicator = YES;
    
    _collectionView=collectionView;
    
    [self.collectionView registerClass:[searchCell class] forCellWithReuseIdentifier:CellID];
//     [self.collectionView registerNib:[UINib nibWithNibName:@"searchCell" bundle:nil] forCellWithReuseIdentifier:CellID];

    
}
//定义每个UICollectionView 的边距
- ( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section {
    return UIEdgeInsetsMake ( pading , pading , pading , pading );
}
//设置水平间距 (同一行的cell的左右间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return pading;
}
//垂直间距 (同一列cell上下间距)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return pading;
}
//- (IBAction)movieListBtn:(UIButton *)sender {
//    MovieListViewController *movieList =[[MovieListViewController alloc]init];
//    [self.navigationController pushViewController:movieList animated:YES];
//}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.searchTextField resignFirstResponder];
    return YES;
}
- (void)textFieldEditChanged:(UITextField *)textField

{
    
    NSLog(@"textfield text %@",textField.text);
    if (textField.text.length != 0 ) {
        
//        [self.centerView removeFromSuperview];
        [self.view addSubview:_collectionView];
//        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
//        
//        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//            [self getSearchMovieList:textField.text];
//        });
         [self getSearchMovieList:textField.text];
    }
   
}
-(void)getSearchMovieList:(NSString *)searchText
{
    NSString *url =[searchUrl stringByAppendingString:searchText];
    [HttpTool get:url withCompletionBlock:^(id returnValue) {
         _list =[seachMovieList yy_modelWithDictionary:returnValue];
//        CompletionBlock(_movieList);
        [self.collectionView reloadData];
    } withFailureBlock:^(NSError *error) {
        nil;
    }];
  
    
}

//-(seachMovieList *)setMovieList
//{
//    if (_movieList ==nil) {
//        _movieList =[seachMovieList new];
//    }
//    return _movieList;
//}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_list.subjects.count>0) {
        self.centerView.hidden =YES;
        return _list.subjects.count;
        
    }else{
        self.centerView.hidden =NO;
        
    }
    return 0;
   
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    searchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    if(!cell){
        cell = [[searchCell alloc] init];
    }
//    cell.movieImage.yy_imageURL =[NSURL URLWithString:_list.subjects]
//    cell.movieName.text =@"111";
    searchMovie *movie =_list.subjects[indexPath.item];
    [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:movie.images.small]];
//    cell.bgImageView. =[NSURL URLWithString:movie.images.small];
   
    cell.nameLabel.text =movie.title;
//    cell.movieName.text =@"11111";
    return cell;
}


//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    _searchTF =textField;
//    [self getSearchMovieList:_searchTF];
//    return  YES;
//}
//-(BOOL)textFieldShouldClear:(UITextField *)textField
//{
//    return YES;
//}

@end
