//
//  searchCell.h
//  Mark
//
//  Created by hongqing on 16/4/19.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *bgImageView; //背景图片
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UILabel *nameLabel; //电影名字
@property (nonatomic,strong) UIView *labelView;

@end
