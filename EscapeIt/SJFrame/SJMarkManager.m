//
//  SJMarkManager.m
//  EscapeIt
//
//  Created by 陈少杰 on 15/6/12.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJMarkManager.h"
#import <SJSettingRecode.h>

@implementation SJMarkManager

+(void)refreshMarkWithMark:(NSInteger)mark{
    if (mark>[self getMark]) {
        [SJSettingRecode set:@"mark" value:[NSString stringWithFormat:@"%ld",(long)mark]];
    }
}

+(NSInteger)getMark{
   return [[SJSettingRecode getSet:@"mark"]integerValue];
}

@end
