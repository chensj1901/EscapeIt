//
//  SJIndexView.m
//  EscapeIt
//
//  Created by 陈少杰 on 15/5/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJIndexView.h"

@implementation SJIndexView
{
    CGRect _backgroundImageViewRect;
    CGRect _logoImageViewRect;
    CGRect _startBtnRect;
}


@synthesize backgroundImageView=_backgroundImageView;
@synthesize logoImageView=_logoImageView;
@synthesize startBtn=_startBtn;


#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _backgroundImageViewRect= CGRectMake(0, 0, WIDTH, HEIGHT);
    _logoImageViewRect= CGRectMake(100, 100, 100, 100);
    _startBtnRect= CGRectMake(120, 300, 100, 50);
}

-(void)loadUI{
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.logoImageView];
    [self addSubview:self.startBtn];
}

#pragma mark - 属性定义

-(UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView=[[UIImageView alloc]initWithFrame:_backgroundImageViewRect];
    }
    return _backgroundImageView;
}

-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView=[[UIImageView alloc]initWithFrame:_logoImageViewRect];
    }
    return _logoImageView;
}

-(UIButton *)startBtn{
    if (!_startBtn) {
        _startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.frame=_startBtnRect;
//        [_startBtn quicklySetNormalImageNamed:<#(NSString *)#> highlightImageNamed:<#(NSString *)#> selectedImageNamed:<#(NSString *)#>];
        [_startBtn quicklySetFontPoint:28 textColorHex:@"313746" textAlignment:NSTextAlignmentCenter title:@"start"];
    }
    return _startBtn;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
