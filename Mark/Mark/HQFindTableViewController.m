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
