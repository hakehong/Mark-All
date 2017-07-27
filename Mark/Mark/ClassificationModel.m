//
//  ClassificationModel.m
//  Mark
//
//  Created by hong on 2017/7/27.
//  Copyright © 2017年 hong. All rights reserved.
//

#import "ClassificationModel.h"
#import "YYModel.h"
#import "classifyModel.h"

@implementation ClassificationModel
- (NSString *)description{
    return [self yy_modelDescription];
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"cat" : classifyModel.class
             };
}
@end
