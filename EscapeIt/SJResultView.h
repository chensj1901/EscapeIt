//
//  SJResultView.h
//  EscapeIt
//
//  Created by 陈少杰 on 15/6/13.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJResultView : UIView
@property(nonatomic,readonly)UIView *backgroundView;
@property(nonatomic,readonly)UILabel *totalLabel;
@property(nonatomic,readonly)UILabel *maxMarkLabel;
@property(nonatomic,readonly)UILabel *thisMarkLabel;
@property(nonatomic,readonly)UIButton *retryBtn;
@property(nonatomic,readonly)UIButton *exitBtn;
-(void)showWithMark:(NSInteger)mark maxMark:(NSInteger)maxMark;
@end
