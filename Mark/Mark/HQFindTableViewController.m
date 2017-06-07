//
//  HQFindTableViewController.m
//  Mark
//
//  Created by hong on 2017/3/17.
//  Copyright © 2017年 hong. All rights reserved.
//

#import "HQFindTableViewController.h"
#import "GlobalHeader.h"
#import "SDCycleScrollView.h"
#import "CycleMovieList.h"
#import "HttpTool.h"
#import "YYModel.h"
#import "CycleMovie.h"
#import "DetailViewController.h"
#import "Masonry.h"
#import "HQFactoryUI.h"
#import "MJRefresh.h"
#import "HQMovieTableViewCell.h"
#import "UIImageView+WebCache.h"
 NSString *const CellID1 =@"CellID1";
 NSString *const CellID =@"CellID";
static NSString *const CycleUrl =@"http://114.215.104.21/v130/singles/banner?";
static NSString *const SecondUrl =@"http://114.215.104.21/v130/singles/cat?";
static NSString *const MovieListUrl =@"http://114.215.104.21/v130/singles/list";

@interface HQFindTableViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,copy)NSMutableArray *imagesURLStrings;
@property(nonatomic,copy)NSDictionary *params;
@property(nonatomic,assign) NSNumber *startNum;
@end

@implementation HQFindTableViewController
{
    CycleMovieList *list;
    SDCycleScrollView *cycleScrollView;
    CycleMovieList  *list2;
    CycleMovieList  *list3;
}
#pragma mark-- 懒加载
-(NSMutableArray *)imagesURLStrings
{
    if (!_imagesURLStrings) {
        _imagesURLStrings =[[NSMutableArray alloc]init];
    }
    return _imagesURLStrings;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNewData];
    [self setTableViewHeader];
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)loadNewData
{
    _params =  [NSDictionary dictionaryWithObjectsAndKeys:@"10",@"count",@"HU0QIAGVzI0xIDq6k9RHcA%3D%3D",@"muid",@"0",@"start",@"1718",@"uid", nil];
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [HttpTool get:CycleUrl withCompletionBlock:^(id returnValue) {
        list=[CycleMovieList yy_modelWithDictionary:returnValue];
        _imagesURLStrings =[NSMutableArray arrayWithCapacity:list.data.count];
        NSArray *array =list.data;
        for (CycleMovie* movie in array) {
            [_imagesURLStrings addObject:movie.img_url];
        }
        cycleScrollView.imageURLStringsGroup =_imagesURLStrings;
        dispatch_group_leave(group);
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [HttpTool post:MovieListUrl parameters:_params  withCompletionBlock:^(id returnValue) {
        list3=[CycleMovieList yy_modelWithJSON:returnValue];
        
        dispatch_group_leave(group);
    } withFailureBlock:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        NSLog(@"%@",error);
        dispatch_group_leave(group);
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    });
}

-(void)setTableViewHeader
{
    self.headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 280)];
    self.tableView.tableHeaderView = self.headerView;
    cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 160) delegate:self placeholderImage:nil];
    [self.headerView addSubview:cycleScrollView];
    UIView *functionView =[[UIView alloc]init];
    functionView.backgroundColor =[UIColor redColor];
    [self.headerView addSubview:functionView];
    [functionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@90);
        make.left.right.equalTo(self.headerView);
        make.top.equalTo(cycleScrollView.mas_bottom);
    }];
    UIView *oneView =[[UIView alloc]init];
    oneView.backgroundColor =[UIColor whiteColor];
    [functionView addSubview:oneView];
    UIImageView *oneImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notChooseSingle"]];
     UIImageView *oneImage1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"allSingleIcon"]];
    [oneView addSubview:oneImage];
    [oneImage addSubview:oneImage1];
    [oneImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(oneView.mas_centerX);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.top.equalTo(oneView.mas_top).offset(20);
    }];
    [oneImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(oneImage.mas_centerX);
        make.centerY.equalTo(oneImage.mas_centerY);
        make.width.equalTo(@25);
        make.height.equalTo(@25);
    }];
    UILabel *fenleiLabel =[HQFactoryUI labelWithTitle:@"分类查找" color:GlobalBg fontSize:15];
    [oneView addSubview:fenleiLabel];
    [fenleiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oneImage.mas_bottom).offset(5);
        make.centerX.equalTo(oneImage.mas_centerX);
    }];
    
    
    
    UIView *twoView =[[UIView alloc]init];
    twoView.backgroundColor =[UIColor whiteColor];
    [functionView addSubview:twoView];
     UIImageView *twoImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notChooseSingle"]];
    [twoView addSubview:twoImage];
    [twoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(twoView.mas_centerX);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.top.equalTo(oneView.mas_top).offset(20);
    }];
    UILabel *dateLabel =[[UILabel alloc]init];
    dateLabel.textColor =GlobalBg;
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    // 获取各时间字段的数值
    dateLabel.text =[NSString stringWithFormat:@"%ld",(long)comp.day];
    dateLabel.font =[UIFont boldSystemFontOfSize:25];
    [twoImage addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(twoImage.mas_centerX);
        make.centerY.equalTo(twoImage.mas_centerY);
    }];
    UILabel *cardLabel =[HQFactoryUI labelWithTitle:@"每日电影卡" color:GlobalBg fontSize:15];
    [twoView addSubview:cardLabel];
    [cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(twoImage.mas_bottom).offset(5);
        make.centerX.equalTo(twoImage.mas_centerX);
    }];
    
    UIView *thirdView =[[UIView alloc]init];
    thirdView.backgroundColor =[UIColor whiteColor];
    [functionView addSubview:thirdView];
    UIImageView *thirdImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"notChooseSingle"]];
    UIImageView *thirdImage1 =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"theatreIcon"]];
    [thirdView addSubview:thirdImage];
    [thirdImage addSubview:thirdImage1];
    [thirdImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(thirdView.mas_centerX);
        make.width.equalTo(@60);
        make.height.equalTo(@60);
        make.top.equalTo(thirdView.mas_top).offset(20);
    }];
    [thirdImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(thirdImage.mas_centerX);
        make.centerY.equalTo(thirdImage.mas_centerY);
        make.width.equalTo(@35);
        make.height.equalTo(@25);
    }];
    UILabel *CinemaHitLabel =[HQFactoryUI labelWithTitle:@"影院热映" color:GlobalBg fontSize:15];
    [thirdView addSubview:CinemaHitLabel];
    [CinemaHitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdImage.mas_bottom).offset(5);
        make.centerX.equalTo(thirdImage.mas_centerX);
    }];
    [@[oneView, twoView, thirdView] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [@[oneView, twoView, thirdView] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(functionView.mas_top);
        make.bottom.equalTo(functionView.mas_bottom);
    }];
    
//    cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    DetailViewController *DetailView =[DetailViewController new];
    DetailView.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:DetailView animated:YES];
    CycleMovie *movie =list.data[index];
    DetailView.movieId =movie.Cycle_id;
    //    DetailView.movieId =[list.data[index] Cycle_id];
    NSLog(@"%@",[list.data[index] Cycle_id]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return list3.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HQMovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell ==nil) {
        cell = [[HQMovieTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    CycleMovie *movie =list3.data[indexPath.item];
    [cell.backImage sd_setImageWithURL:[NSURL URLWithString:movie.img_url]];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    cell.countLabel.text = [numberFormatter stringFromNumber:movie.likes];
    cell.titleLabel.text =movie.name;
    //    cell.likeNum.text = movie.likes;
    return cell;
}
#pragma mark -点击对应cell进入影单详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *DetailView =[DetailViewController new];
    DetailView.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:DetailView animated:YES];
    CycleMovie *movie2 =list3.data[indexPath.item];
    DetailView.movieId =movie2.Cycle_id;
    //    DetailView.movieId =[list.data[index] Cycle_id];
    NSLog(@"%@", DetailView.movieId);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 230;
}


@end
