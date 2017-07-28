//
//  ClassificationModel.h
//  Mark
//
//  Created by hong on 2017/7/27.
//  Copyright © 2017年 hong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "classifyModel.h"

@interface ClassificationModel : NSObject
//name":"类型",
//"img_url":"http://7xqnv7.com2.z0.glb.qiniucdn.com/leixin.png",
//"cat":Array[9]
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *img_url;
@property (nonatomic,strong) NSArray *cat;
//@property (nonatomic,strong) classifyModel *cat;
@end
