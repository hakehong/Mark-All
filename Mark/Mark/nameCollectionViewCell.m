//
//  nameCollectionViewCell.m
//  Mark
//
//  Created by hong on 2017/7/27.
//  Copyright © 2017年 hong. All rights reserved.
//

#import "nameCollectionViewCell.h"
#import "GlobalHeader.h"
#import "HQFactoryUI.h"
@interface nameCollectionViewCell()
@property(nonatomic,strong)UILabel *nameLabel;
@end
@implementation nameCollectionViewCell
#pragma mark 懒加载
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
    UIView *lineView1= [HQFactoryUI separatorLine];
    UIView *lineView2= [HQFactoryUI separatorLine];
    UIView *lineView3= [HQFactoryUI separatorLine];
    UIView *lineView4= [HQFactoryUI separatorLine];
}
@end
