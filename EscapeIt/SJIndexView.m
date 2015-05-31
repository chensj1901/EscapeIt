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
    _logoImageViewRect= CGRectMake((WIDTH-483/2)/2, 100, 483/2, 123/2);
    _startBtnRect= CGRectMake((WIDTH-130)/2, HEIGHT-120, 130, 45);
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
        _backgroundImageView.backgroundColorHex=@"00008B";
    }
    return _backgroundImageView;
}

-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView=[[UIImageView alloc]initWithFrame:_logoImageViewRect];
        _logoImageView.image=[UIImage imageNamed:@"logo_c.png"];
    }
    return _logoImageView;
}

-(UIButton *)startBtn{
    if (!_startBtn) {
        _startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.frame=_startBtnRect;
        _startBtn.backgroundColorHex=@"6CCA5C";
        [_startBtn quicklySetFontPoint:28 textColorHex:@"652709" textAlignment:NSTextAlignmentCenter title:@"PLAY"];
        _startBtn.layer.borderColor=[[UIColor colorWithHex:@"652709"]CGColor];
        _startBtn.layer.cornerRadius=5;
        _startBtn.layer.borderWidth=4;
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
