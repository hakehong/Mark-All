//
//  HQMovieTableViewCell.h
//  Mark
//
//  Created by hong on 2017/3/21.
//  Copyright © 2017年 hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQMovieTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *backImage;  //背景图片
@property (nonatomic,strong)UILabel *titleLabel;   //标题
@property (nonatomic,strong)UIImageView *loveImage;  //喜欢图片
@property (nonatomic,strong)UILabel *countLabel;   //喜欢人数
@end
