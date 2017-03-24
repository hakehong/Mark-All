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


NSString *const CycleUrl =@"http://114.215.104.21/v130/singles/banner?";
@interface HQFindTableViewController ()<SDCycleScrollViewDelegate>
@property(nonatomic,strong)UIView *headerView;
@property(nonatomic,copy)NSMutableArray *imagesURLStrings;
@end

@implementation HQFindTableViewController
{
    CycleMovieList *list;
    SDCycleScrollView *cycleScrollView;
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)loadNewData
{
    [HttpTool get:CycleUrl withCompletionBlock:^(id returnValue) {
        list=[CycleMovieList yy_modelWithDictionary:returnValue];
        _imagesURLStrings =[NSMutableArray arrayWithCapacity:list.data.count];
        NSArray *array =list.data;
        for (CycleMovie* movie in array) {
            [_imagesURLStrings addObject:movie.img_url];
        }
        cycleScrollView.imageURLStringsGroup =_imagesURLStrings;
        [self.tableView reloadData];
        
    } withFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)setTableViewHeader
{
    self.headerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
