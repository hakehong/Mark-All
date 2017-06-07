//
//  HQMovieTableViewCell.m
//  Mark
//
//  Created by hong on 2017/3/21.
//  Copyright © 2017年 hong. All rights reserved.
//

#import "HQMovieTableViewCell.h"
#import "Masonry.h"
#import "GlobalHeader.h"
@interface HQMovieTableViewCell()
@property (nonatomic,strong)UIView *bgView;
@end
@implementation HQMovieTableViewCell
#pragma mark- 懒加载
-(UIView *)bgView{
    if (!_bgView) {
        _bgView =[[UIView alloc]init];
        _bgView.backgroundColor =[UIColor whiteColor];
    }
    return _bgView;
}
-(UIImageView *)backImage
{
    if (!_backImage) {
        _backImage =[[UIImageView alloc]init];
    }
    return _backImage;
}
-(UIImageView *)loveImage
{
    if (!_loveImage) {
        _loveImage =[[UIImageView alloc]init];
        [_loveImage setImage:[UIImage imageNamed:@"cardNotLikeIcon"]];
    }
    return _loveImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]init];
        _titleLabel.numberOfLines =2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel =[[UILabel alloc]init];
        _countLabel.font =[UIFont systemFontOfSize:11];
        _countLabel.textColor =RGB(192, 191, 191);
        
    }
    return _countLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return  self;
}
-(void)setupUI{
    self.contentView.backgroundColor =RGB(233, 233, 233);
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    [self.bgView addSubview:self.backImage];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.loveImage];
    [self.bgView addSubview:self.countLabel];
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.right.equalTo(self);
        make.height.equalTo(@140);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImage.mas_bottom).offset(10);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
    [self.loveImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@10);
        make.height.equalTo(@10);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loveImage.mas_right).offset(3);
        make.centerY.equalTo(self.loveImage.mas_centerY);
    }];

    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
