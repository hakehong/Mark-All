//
//  HQFactoryUI.m
//  GoldTree
//
//  Created by hongqing on 16/12/4.
//  Copyright © 2016年 miracle. All rights reserved.
//

#import "HQFactoryUI.h"
#import "GlobalHeader.h"
#define IsStringNotEmpty(string)        (string && ![@"" isEqualToString:string])
\
@implementation HQFactoryUI
+ (UIView *)separatorLine {
    UIView *view = [UIView new];
    view.backgroundColor = lineColor;
    return view;
}
+ (UIButton *)buttonWithImageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (IsStringNotEmpty(imageName)) {
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (IsStringNotEmpty(highlightImageName)) {
        [button setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    }
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor fontSize:(NSInteger)fontSize target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:fontSize]
;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
+ (UILabel *)labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize{
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}
+(UIImageView *)imageWithName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIImageView *imageView =[[UIImageView alloc]init];
    if (IsStringNotEmpty(imageName)) {
        [imageView setImage:[UIImage imageNamed:imageName]];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tap];
    return  imageView;
}
@end
