//
//  imageNameCell.m
//  Mark
//
//  Created by hong on 2017/7/27.
//  Copyright © 2017年 hong. All rights reserved.
//

#import "imageNameCell.h"
#import "GlobalHeader.h"
#import "Masonry.h"
@interface imageNameCell()

@end

@implementation imageNameCell
#pragma mark 懒加载
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView =[[UIImageView alloc]init];
    }
    return _imageView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel =[[UILabel alloc]init];
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
    [self addSubview:self.nameLabel];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_centerY).equalTo(@5);
    }];
}
@end
