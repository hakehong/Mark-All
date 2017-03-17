//
//  DetailViewController.m
//  Mark
//
//  Created by hongqing on 16/4/29.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "DetailViewController.h"
#import "WebImgScrollView.h"
#import "DetailViewTool.h"
#import "CycleMovie.h"
#import "UIView+Extension.h"
#import "SVProgressHUD.h"
#import "GlobalHeader.h"
#import "BigButton.h"
#import "MAsonry.h"
@interface DetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIView *tabBarView;
@property (nonatomic, strong) BigButton *likeBtn;  //喜欢按钮
@property (nonatomic, strong) BigButton *commentsBtn;   //评论按钮
@property (nonatomic, strong) BigButton *shareBtn;  //分享按钮


@end

@implementation DetailViewController
//分享按钮
- (BigButton *)shareBtn{
    if (_shareBtn == nil) {
        _shareBtn = [[BigButton alloc]init];
        _shareBtn.title =@"101";
        _shareBtn.titleLabel.textColor = GlobalBg;
        _shareBtn.image =[UIImage imageNamed:@"cardShareIcon"];
        _shareBtn.tag =3;
        _shareBtn.heightPercent = 0.5;
        [_shareBtn addTarget:self
                      action:@selector(ButtonClick:)
            forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _shareBtn;
}
//评论按钮
- (BigButton *)commentsBtn{
    if (_commentsBtn == nil) {
        _commentsBtn = [[BigButton alloc]init];
        _commentsBtn.title =@"459";
        _commentsBtn.titleLabel.textColor = GlobalBg;
        _commentsBtn.image =[UIImage imageNamed:@"comemntSingleIcon"];
        _commentsBtn.tag =2;
        _commentsBtn.heightPercent = 0.5;
        [_commentsBtn addTarget:self
                      action:@selector(ButtonClick:)
            forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _commentsBtn;
}
//喜欢按钮
- (BigButton *)likeBtn{
    if (_likeBtn == nil) {
        _likeBtn = [[BigButton alloc]init];
        _likeBtn.titleLabel.textColor = GlobalBg;
        _likeBtn.title =@"222";
        _likeBtn.image =[UIImage imageNamed:@"cardNotLikeIcon"];
        _likeBtn.tag =1;
        _likeBtn.heightPercent = 0.5;
        [_likeBtn addTarget:self
                      action:@selector(ButtonClick:)
            forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _likeBtn;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
 
    
}
-(void)ButtonClick:(BigButton *)sender
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title =[NSString stringWithFormat:@"影单详情"];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"goBackIcon"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.tabBarView];
    [self.tabBarView addSubview:self.shareBtn];
    [self.tabBarView addSubview:self.likeBtn];
    [self.tabBarView addSubview:self.commentsBtn];
    [@[self.likeBtn, self.commentsBtn, self.shareBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [@[self.likeBtn, self.commentsBtn, self.shareBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabBarView.mas_top);
        make.bottom.equalTo(self.tabBarView.mas_bottom);
    }];
    // Do any additional setup after loading the view.
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss ];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //调整字号
    NSString *str = @"document.getElementsByTagName('content')[0].style.webkitTextSizeAdjust= '100%'";
    [webView stringByEvaluatingJavaScriptFromString:str];
    
    //js方法遍历图片添加点击事件 返回图片个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.src;\
    };\
    };\
    return objs.length;\
    };";
    
    [webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    [webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
    
//    //    上拉加载
//    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"];

    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    [SVProgressHUD show];
    NSString *str = request.URL.absoluteString;
    
    if ([str hasPrefix:@"myweb:imageClick:"]) {
        str = [str stringByReplacingOccurrencesOfString:@"myweb:imageClick:"
                                             withString:@""];
        [WebImgScrollView showImageWithStr:str];
        return YES;
    }
//    }else  ([str isEqualToString:@"about:blank"]){
//        
//    }
//    else{
//        WebViewController *webVC = [[WebViewController alloc] initWithNSString:str];
//        [self.navigationController pushViewController:webVC animated:YES];
//        return NO;
//    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    return YES;
}
- (UIWebView *)webView{
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight -124)];
        _webView.delegate = self;
        _webView.opaque = NO;
    }
    return _webView;
}
-(void)setMovieId:(NSNumber *)movieId
{
    _movieId =movieId;
    [DetailViewTool getDetailStoryWithStoryId:movieId Callback:^(id obj) {
        self.movieDetail =obj;
       [_webView loadHTMLString:self.movieDetail.contentInfo baseURL:nil];
    }];
    
    
}
-(void)setMovieDetail:(CycleMovie *)movieDetail
{
    _movieDetail = movieDetail;
  
}

#pragma mark- 如果多如此类的按钮的初始化，是不是可以使用一种方法如工厂方法批量生产
 



-(UIView *)tabBarView
{
    if (_tabBarView ==nil) {
        _tabBarView =[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-60, kScreenWidth, 60)];
        _tabBarView.backgroundColor =[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1];
    }
    return _tabBarView;
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
