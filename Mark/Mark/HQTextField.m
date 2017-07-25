//
//  HQTextField.m
//  Mark
//
//  Created by hong on 2017/7/25.
//  Copyright © 2017年 hong. All rights reserved.
//

#import "HQTextField.h"

@implementation HQTextField
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.leftView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        self.leftViewMode =UITextFieldViewModeAlways;
        UIButton *button = [self valueForKey:@"_clearButton"];
        [button setImage:[UIImage imageNamed:@"deleteSearchIcon"] forState:UIControlStateNormal];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//控制左视图位置
//- (CGRect)leftViewRectForBounds:(CGRect)bounds
//{
//    CGRect inset = CGRectMake(bounds.origin.x +20, bounds.origin.y, bounds.size.width, bounds.size.height);
//    return inset;
//    //return CGRectInset(bounds,50,0);
//}
//控制清除按钮的位置
-(CGRect)clearButtonRectForBounds:(CGRect)bounds
{
return CGRectMake(bounds.origin.x + bounds.size.width - 40, bounds.origin.y + bounds.size.height -28, 16, 16);
}

@end
