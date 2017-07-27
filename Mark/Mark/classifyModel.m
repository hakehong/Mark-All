//
//  classifyModel.m
//  Mark
//
//  Created by hong on 2017/7/27.
//  Copyright © 2017年 hong. All rights reserved.
//

#import "classifyModel.h"
#import "YYModel.h"

@implementation classifyModel
+(NSDictionary *)modelCustomPropertyMapper
{
    return @{@"h_id":@"id",
             @"name":@"name",
             @"img_url":@"img_url"
             };
}
@end
