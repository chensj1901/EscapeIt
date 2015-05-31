//
//  SJGameView.m
//  EscapeIt
//
//  Created by 陈少杰 on 15/5/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJGameView.h"

@implementation SJGameView

{
    CGRect _backgroundImageViewRect;
    CGRect _markLabelRect;
    CGRect _leftPeopleImageViewRect;
    CGRect _rightPeopleImageViewRect;
    CGRect _cloudImageViewRect;
    CGRect _heatOneImageViewRect;
    CGRect _heatTwoImageViewRect;
    CGRect _heatThreeImageViewRect;
}


@synthesize backgroundImageView=_backgroundImageView;
@synthesize leftPeopleImageView=_leftPeopleImageView;
@synthesize rightPeopleImageView=_rightPeopleImageView;
@synthesize markLabel=_markLabel;
@synthesize cloudImageView=_cloudImageView;
@synthesize heatOneImageView=_heatOneImageView;
@synthesize heatTwoImageView=_heatTwoImageView;
@synthesize heatThreeImageView=_heatThreeImageView;



#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    CGFloat k=2.5;
    _backgroundImageViewRect= CGRectMake(0, 0, WIDTH, HEIGHT);
    _leftPeopleImageViewRect= CGRectMake(WIDTH/2-107/k, HEIGHT-197/k, 107/k, 197/k);
    _rightPeopleImageViewRect= CGRectMake(WIDTH/2, HEIGHT-188/k, 101/k, 188/k);
    _markLabelRect= CGRectMake(0, 20, WIDTH/2, 28);
    _cloudImageViewRect= CGRectMake(0, HEIGHT-40*HEIGHT/480., WIDTH, 40*HEIGHT/480.);
    _heatOneImageViewRect= CGRectMake(WIDTH-150, 20, 38, 29);
    _heatTwoImageViewRect= CGRectMake(WIDTH-100, 20, 38, 29);
    _heatThreeImageViewRect= CGRectMake(WIDTH-50, 20, 38, 29);
}

-(void)loadUI{
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.heatOneImageView];
    [self addSubview:self.heatTwoImageView];
    [self addSubview:self.heatThreeImageView];
    [self addSubview:self.leftPeopleImageView];
    [self addSubview:self.rightPeopleImageView];
    [self addSubview:self.markLabel];
    [self addSubview:self.cloudImageView];
}

#pragma mark - 属性定义

-(UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView=[[UIImageView alloc]initWithFrame:_backgroundImageViewRect];
        _backgroundImageView.backgroundColorHex=@"00008B";
    }
    return _backgroundImageView;
}

-(UIImageView *)leftPeopleImageView{
    if (!_leftPeopleImageView) {
        _leftPeopleImageView=[[UIImageView alloc]initWithFrame:_leftPeopleImageViewRect];
        _leftPeopleImageView.image=[UIImage imageNamed:@"peopleLeft.png"];
        
    }
    return _leftPeopleImageView;
}

-(UIImageView *)rightPeopleImageView{
    if (!_rightPeopleImageView) {
        _rightPeopleImageView=[[UIImageView alloc]initWithFrame:_rightPeopleImageViewRect];
        _rightPeopleImageView.image=[UIImage imageNamed:@"peopleRIght.png"];
    }
    return _rightPeopleImageView;
}

-(UILabel *)markLabel{
    if (!_markLabel) {
        _markLabel=[[UILabel alloc]initWithFrame:_markLabelRect];
        [_markLabel quicklySetFontPoint:28 textColorHex:@"ffffff" textAlignment:NSTextAlignmentCenter text:@"0"];
    }
    return _markLabel;
}

-(UIImageView *)cloudImageView{
    if (!_cloudImageView) {
        _cloudImageView=[[UIImageView alloc]initWithFrame:_cloudImageViewRect];
        _cloudImageView.image=[UIImage imageNamed:@"cloud.png"];
    }
    return _cloudImageView;
}


-(UIImageView *)heatOneImageView{
    if (!_heatOneImageView) {
        _heatOneImageView=[[UIImageView alloc]initWithFrame:_heatOneImageViewRect];
        _heatOneImageView.image=[UIImage imageNamed:@"heat.png"];
    }
    return _heatOneImageView;
}

-(UIImageView *)heatTwoImageView{
    if (!_heatTwoImageView) {
        _heatTwoImageView=[[UIImageView alloc]initWithFrame:_heatTwoImageViewRect];
        _heatTwoImageView.image=[UIImage imageNamed:@"heat.png"];
    }
    return _heatTwoImageView;
}

-(UIImageView *)heatThreeImageView{
    if (!_heatThreeImageView) {
        _heatThreeImageView=[[UIImageView alloc]initWithFrame:_heatThreeImageViewRect];
        _heatThreeImageView.image=[UIImage imageNamed:@"heat.png"];
    }
    return _heatThreeImageView;
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
