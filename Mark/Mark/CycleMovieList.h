//
//  movieList.h
//  Mark
//
//  Created by hongqing on 16/3/12.
//  Copyright © 2016年 hongqing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CycleMovie;
@interface CycleMovieList : NSObject
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) CycleMovie *singleData;
@end
