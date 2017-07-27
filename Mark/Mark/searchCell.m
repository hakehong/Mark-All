//
//  searchCell.m
//  Mark
//
//  Created by hongqing on 16/4/19.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import "searchCell.h"
#import "GlobalHeader.h"
#import "Masonry.h"
@interface searchCell()
@property(nonatomic,strong)UIView *btnView;  //按钮底下的白色背景
@end
@implementation searchCell
#pragma mark 懒加载
-(UIView *)btnView{
    if (!_btnView) {
        _btnView =[[UIView alloc]init];
        _btnView.backgroundColor =[UIColor whiteColor];
        _btnView.userInteractionEnabled =YES;
        
    }
    return _btnView ;
}
-(UIView *)labelView{
    if (!_labelView) {
        _labelView =[[UIView alloc]init];
        _labelView.backgroundColor =[UIColor whiteColor];
        
    }
    return _labelView;
}
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView =[[UIImageView alloc]init];
        _bgImageView.userInteractionEnabled =YES;
        
    }
    return _bgImageView;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"buildSingleIcon"] forState:UIControlStateNormal];
        _addBtn.tag = 0;
        [_addBtn addTarget:self action:@selector(addMovie) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]init];
        _nameLabel.font =[UIFont systemFontOfSize:13];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.lineBreakMode =NSLineBreakByTruncatingTail;
        _nameLabel.textColor =GlobalBg;
        
    }
    return _nameLabel;
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
}
-(void)setupUI{
  ;
    [self addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.btnView] ;
    [self.btnView addSubview:self.addBtn];
    [self addSubview:self.labelView];
    [self.labelView addSubview:self.nameLabel];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
    [self.btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.bgImageView.mas_bottom);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.btnView.mas_centerX);
        make.centerY.equalTo(self.btnView.mas_centerY);
    }];
    [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(self.bgImageView.mas_bottom);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.labelView.mas_centerX);
        make.centerY.equalTo(self.labelView.mas_centerY);
        make.left.equalTo(self.labelView.mas_left).offset(3);
        make.right.equalTo(self.labelView.mas_right).offset(-3);
    }];
}
-(void)addMovie{
    NSLog(@"just-test");
    if (self.addBtn.tag ==0) {
        [self.addBtn setImage:[UIImage imageNamed:@"alreadyAddIcon"] forState:UIControlStateNormal];
        self.addBtn.tag =1;
    }else if (self.addBtn.tag ==1){
        [self.addBtn setImage:[UIImage imageNamed:@"buildSingleIcon"] forState:UIControlStateNormal];
        self.addBtn.tag =0;
    }
//    self.addBtn setValue:; forKey:<#(nonnull NSString *)#>
    if (self.addMovieBlock) {
        self.addMovieBlock();
    }
}

//-(void)layoutSubviews
//{
//    [super layoutSubviews];
//    _movieImage.frame = CGRectMake(10, 0, (Kwidth -40)/3, (Kwidth -40)/3);
//    _movieName.frame = CGRectMake(10, (Kwidth -40)/3, (Kwidth -40)/3, 15);
//    
//}
//- (void)setImage: (NSString *)imageStr content : (NSString *)content
//{
//    
//    self.movieImage.yy_imageURL =[NSURL URLWithString:imageStr];
//    self.movieName.text =content;
//}

@end
