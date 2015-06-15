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
    CGRect _maxMarkLabelRect;
    CGRect _startBtnRect;
}


@synthesize backgroundImageView=_backgroundImageView;
@synthesize logoImageView=_logoImageView;
@synthesize maxMarkLabel=_maxMarkLabel;
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
    _backgroundImageViewRect= CGRectMake(-HEIGHT/2, -HEIGHT/2, 2*HEIGHT, 2*HEIGHT);
    _logoImageViewRect= CGRectMake((WIDTH-483/2)/2, 100, 483/2, 123/2);
    _maxMarkLabelRect= CGRectMake(0, 200, WIDTH, 20);
    _startBtnRect= CGRectMake((WIDTH-124)/2, HEIGHT-120, 124, 39);
}

-(void)loadUI{
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.maxMarkLabel];
    [self addSubview:self.logoImageView];
    [self addSubview:self.startBtn];
}

#pragma mark - 属性定义

-(UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView=[[UIImageView alloc]initWithFrame:_backgroundImageViewRect];
        
        _backgroundImageView.image=[UIImage imageNamed:@"bg.jpg"];
        //_backgroundImageView.backgroundColorHex=@"00008B";
    }
    return _backgroundImageView;
}

-(UILabel *)maxMarkLabel{
    if (!_maxMarkLabel) {
        _maxMarkLabel=[[UILabel alloc]initWithFrame:_maxMarkLabelRect];
        [_maxMarkLabel quicklySetFontPoint:20 textColorHex:@"ffffff" textAlignment:NSTextAlignmentCenter];
    }
    return _maxMarkLabel;
}

-(UIImageView *)logoImageView{
    if (!_logoImageView) {
        _logoImageView=[[UIImageView alloc]initWithFrame:_logoImageViewRect];
        _logoImageView.image=[UIImage imageNamed:NSLocalizedString(@"logo_e.png", nil)];
    }
    return _logoImageView;
}

-(UIButton *)startBtn{
    if (!_startBtn) {
        _startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.frame=_startBtnRect;
        [_startBtn quicklySetNormalBackgroundImageNamed:NSLocalizedString(@"startBtn_e.png", nil) highlightBackgroundImageNamed:nil selectedBackgroundImageNamed:nil];
//        _startBtn.backgroundColorHex=@"6CCA5C";
//        [_startBtn quicklySetFontPoint:28 textColorHex:@"652709" textAlignment:NSTextAlignmentCenter title:@"PLAY"];
//        _startBtn.layer.borderColor=[[UIColor colorWithHex:@"652709"]CGColor];
//        _startBtn.layer.cornerRadius=5;
//        _startBtn.layer.borderWidth=4;
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
