//
//  SJMarkManager.h
//  EscapeIt
//
//  Created by 陈少杰 on 15/6/12.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJMarkManager : NSObject
+(void)refreshMarkWithMark:(NSInteger)mark;
+(NSInteger)getMark;
@end
