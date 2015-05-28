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
    CGRect _lifeLabelRect;
    CGRect _leftPeopleImageViewRect;
    CGRect _rightPeopleImageViewRect;
}


@synthesize backgroundImageView=_backgroundImageView;
@synthesize leftPeopleImageView=_leftPeopleImageView;
@synthesize rightPeopleImageView=_rightPeopleImageView;
@synthesize markLabel=_markLabel;
@synthesize lifeLabel=_lifeLabel;


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
    _leftPeopleImageViewRect= CGRectMake(WIDTH/2-25, HEIGHT-100, 25, 40);
    _rightPeopleImageViewRect= CGRectMake(WIDTH/2, HEIGHT-100, 25, 40);
    _markLabelRect= CGRectMake(50, 50, 60, 50);
    _lifeLabelRect= CGRectMake(WIDTH-110, 50, 60, 50);
}

-(void)loadUI{
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.leftPeopleImageView];
    [self addSubview:self.rightPeopleImageView];
    [self addSubview:self.markLabel];
    [self addSubview:self.lifeLabel];
}

#pragma mark - 属性定义

-(UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView=[[UIImageView alloc]initWithFrame:_backgroundImageViewRect];
    }
    return _backgroundImageView;
}

-(UIImageView *)leftPeopleImageView{
    if (!_leftPeopleImageView) {
        _leftPeopleImageView=[[UIImageView alloc]initWithFrame:_leftPeopleImageViewRect];
        _leftPeopleImageView.backgroundColorHex=@"ff0000";
    }
    return _leftPeopleImageView;
}

-(UIImageView *)rightPeopleImageView{
    if (!_rightPeopleImageView) {
        _rightPeopleImageView=[[UIImageView alloc]initWithFrame:_rightPeopleImageViewRect];
        _rightPeopleImageView.backgroundColorHex=@"00ff00";
    }
    return _rightPeopleImageView;
}

-(UILabel *)markLabel{
    if (!_markLabel) {
        _markLabel=[[UILabel alloc]initWithFrame:_markLabelRect];
        [_markLabel quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentLeft text:@"分数:0"];
    }
    return _markLabel;
}

-(UILabel *)lifeLabel{
    if (!_lifeLabel) {
        _lifeLabel=[[UILabel alloc]initWithFrame:_lifeLabelRect];
        [_lifeLabel quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentRight text:@"生命:3"];
    }
    return _lifeLabel;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
