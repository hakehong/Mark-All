//
//  RootTabBarViewController.m
//  Mark
//
//  Created by hong on 2017/3/17.
//  Copyright © 2017年 hong. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "HQMyMovieViewController.h"
#import "HQFindTableViewController.h"
#import "HQAccountTableViewController.h"
#import "GlobalHeader.h"

@interface RootTabBarViewController ()

@end

@implementation RootTabBarViewController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] =GlobalBg;
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = RGB(16, 24, 30);
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self  setupChildVC:[[HQFindTableViewController alloc] init] title:@"发现" image:@"foundDownIcon" selectedImage:@"foundUpIcon"];
    [self setupChildVC:[[HQMyMovieViewController alloc] init] title:@"我的电影" image:@"mymovieDownIcon" selectedImage:@"mymovieUpIcon"];
    [self  setupChildVC:[[HQAccountTableViewController alloc] init] title:@"账号" image:@"personDownIcon" selectedImage:@"personUpIcon"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setupChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image =[UIImage imageNamed:image];
    vc.tabBarItem.selectedImage =[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
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
