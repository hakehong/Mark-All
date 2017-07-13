//
//  HQAccountSettingTableViewController.m
//  Mark
//
//  Created by hong on 2017/7/11.
//  Copyright © 2017年 hong. All rights reserved.
//

#import "HQAccountSettingTableViewController.h"
#import "XBSettingCell.h"
#import "XBSettingItemModel.h"
#import "XBSettingSectionModel.h"
#import "GlobalHeader.h"
#import "Masonry.h"
#import "HQFactoryUI.h"
@interface HQAccountSettingTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *sectionArray; //section模型数组
@end

@implementation HQAccountSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = BackgroundColor ;
    self.view.backgroundColor =BackgroundColor;
    self.tableView.delegate =self;
    self.tableView.dataSource =self;
    [self setupHeadView];
    [self setupSections];
    [self setFooterView];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)logOut{
    NSLog(@"退出登录");
}
-(void)setFooterView{
    UIView *footerView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    footerView.backgroundColor =BackgroundColor;
    self.tableView.tableFooterView = footerView;
//    self.tableView.tableFooterView.backgroundColor =[UIColor redColor];
//    UIView *insertView =[[UIView alloc]init];
//    insertView.backgroundColor =BackgroundColor;
//    [footerView addSubview:insertView ];
//    [insertView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.equalTo(footerView);
//        make.height.equalTo(@18);
//    }];
    UIButton *logOutBtn=[HQFactoryUI buttonWithTitle:@"退出登录" titleColor:[UIColor redColor] fontSize:15 target:self action:@selector(logOut)];
    logOutBtn.backgroundColor =[UIColor whiteColor];
    [footerView addSubview:logOutBtn];
    [logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(footerView);
        make.top.equalTo(footerView.mas_top).offset(18);
        make.bottom.equalTo(footerView.mas_bottom).offset(-18);
    }];
}
-(void)setupHeadView{
    UIView *headView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 100)];
    headView.backgroundColor =[UIColor whiteColor];
    self.tableView.tableHeaderView =headView;
    UIImageView *iconImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"defaultUserIcon"]];
    iconImage.userInteractionEnabled=YES;
    [headView addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView.mas_left).offset(15);
        make.centerY.equalTo(headView.mas_centerY);
    }];
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.text = @"Q";
    nameLabel.textColor = GlobalBg;
    nameLabel.backgroundColor = [UIColor whiteColor];
    [headView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right).offset(7);
        make.centerY.equalTo(iconImage.mas_centerY);
    }];
    UIImageView *arrowImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiantou_zichan"]];
    arrowImage.userInteractionEnabled=YES;
    [headView addSubview:arrowImage];
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headView.mas_right).offset(-15);
        make.centerY.equalTo(headView.mas_centerY);
    }];
    
}
- (void)setupSections
{
    
    //************************************section1
    XBSettingItemModel *item1 = [[XBSettingItemModel alloc]init];
    item1.funcName = @"我的消息";
    item1.executeCode = ^{
        NSLog(@"我的任务1");
    };
    item1.img = [UIImage imageNamed:@"myMessageIcon"];
    item1.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    XBSettingSectionModel *section0 = [[XBSettingSectionModel alloc]init];
    section0.sectionHeaderHeight = 18;
    section0.itemArray = @[item1];
    
    XBSettingItemModel *item2 = [[XBSettingItemModel alloc]init];
    item2.funcName = @"我喜欢的影单";
    item2.img = [UIImage imageNamed:@"likeSingleIcon"];
    item2.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item3 = [[XBSettingItemModel alloc]init];
    item3.funcName = @"我投稿的影单";
    item3.img = [UIImage imageNamed:@"contributeSingleIcon"];
    item3.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item4 = [[XBSettingItemModel alloc]init];
    item4.funcName = @"我喜欢的电影卡片";
    item4.img = [UIImage imageNamed:@"likeCardIcon"];
    item4.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section1 = [[XBSettingSectionModel alloc]init];
    section1.sectionHeaderHeight = 18;
    section1.itemArray = @[item1,item2,item3,item4];
    
    XBSettingItemModel *item5 = [[XBSettingItemModel alloc]init];
    item5.funcName = @"邀请好友使用";
    item5.img = [UIImage imageNamed:@"setShareIcon"];
    item5.executeCode = ^{
        NSLog(@"充值中心");
    };
    item5.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item6 = [[XBSettingItemModel alloc]init];
    item6.funcName = @"给我们评分吧";
    item6.img = [UIImage imageNamed:@"setReviewIcon"];
    item6.executeCode = ^{
        
    };
    item6.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item7 = [[XBSettingItemModel alloc]init];
    item7.funcName = @"给我们提意见";
    item7.img = [UIImage imageNamed:@"setIdeaIcon"];
    item7.executeCode = ^{
        
    };
    item7.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingItemModel *item8 = [[XBSettingItemModel alloc]init];
    item8.funcName = @"关于";
    item8.detailText =@"v1.6.2(142)";
    item8.img = [UIImage imageNamed:@"setAboutIcon"];
    item8.executeCode = ^{
        
    };
    item8.accessoryType = XBSettingAccessoryTypeDisclosureIndicator;
    
    XBSettingSectionModel *section2 = [[XBSettingSectionModel alloc]init];
    section2.sectionHeaderHeight = 18;
    section2.itemArray = @[item5,item6,item7,item8];
    
    self.sectionArray = @[section0,section1,section2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    XBSettingSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.itemArray.count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"setting";
    XBSettingSectionModel *sectionModel = self.sectionArray[indexPath.section];
    sectionModel.sectionHeaderBgColor =BackgroundColor;
    XBSettingItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    
    XBSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[XBSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.item = itemModel;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    XBSettingSectionModel *sectionModel = self.sectionArray[section];
    return sectionModel.sectionHeaderHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    XBSettingSectionModel *sectionModel = self.sectionArray[indexPath.section];
    XBSettingItemModel *itemModel = sectionModel.itemArray[indexPath.row];
    if (itemModel.executeCode) {
        itemModel.executeCode();
    }
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
