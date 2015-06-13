//
//  SJGameView.m
//  EscapeIt
//
//  Created by 陈少杰 on 15/5/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJGameView.h"
#import "config.h"

@implementation SJGameView

{
    CGRect _backgroundViewRect;
    CGRect _backgroundImageViewRect;
    CGRect _markLabelRect;
    CGRect _leftPeopleImageViewRect;
    CGRect _rightPeopleImageViewRect;
    CGRect _cloudImageViewRect;
    CGRect _heatOneImageViewRect;
    CGRect _heatTwoImageViewRect;
    CGRect _heatThreeImageViewRect;
    CGRect _retryBtnRect;
    CGRect _resultViewRect;
}


@synthesize backgroundImageView=_backgroundImageView;
@synthesize leftPeopleImageView=_leftPeopleImageView;
@synthesize rightPeopleImageView=_rightPeopleImageView;
@synthesize markLabel=_markLabel;
@synthesize cloudImageView=_cloudImageView;
@synthesize heatOneImageView=_heatOneImageView;
@synthesize heatTwoImageView=_heatTwoImageView;
@synthesize heatThreeImageView=_heatThreeImageView;
@synthesize retryBtn=_retryBtn;
@synthesize adMogobarView=_adMogobarView;
@synthesize backgroundView=_backgroundView;
@synthesize resultView=_resultView;




#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    CGFloat wk=WIDTH/320.;
    CGFloat k=3/wk;
    _backgroundViewRect= CGRectMake(0, 0, WIDTH, HEIGHT);
    _backgroundImageViewRect= CGRectMake(-HEIGHT, -HEIGHT, 2*HEIGHT, 2*HEIGHT);
    _leftPeopleImageViewRect= CGRectMake(WIDTH/2-107/k, HEIGHT-197/k-50, 107/k, 197/k);
    _rightPeopleImageViewRect= CGRectMake(WIDTH/2, HEIGHT-188/k-50, 101/k, 188/k);
    _markLabelRect= CGRectMake(0, 20, WIDTH/2, 28);
    _cloudImageViewRect= CGRectMake(0, HEIGHT-130, WIDTH, 130);
    _heatOneImageViewRect= CGRectMake(WIDTH-150, 20, 38, 29);
    _heatTwoImageViewRect= CGRectMake(WIDTH-100, 20, 38, 29);
    _heatThreeImageViewRect= CGRectMake(WIDTH-50, 20, 38, 29);
    _resultViewRect= CGRectMake(0, 0, WIDTH, HEIGHT);
    _retryBtnRect=  CGRectMake((WIDTH-130)/2, HEIGHT-160, 130, 45);
}

-(void)loadUI{
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.backgroundView];
    [self addSubview:self.heatOneImageView];
    [self addSubview:self.heatTwoImageView];
    [self addSubview:self.heatThreeImageView];
    [self addSubview:self.leftPeopleImageView];
    [self addSubview:self.rightPeopleImageView];
    [self addSubview:self.markLabel];
    [self addSubview:self.cloudImageView];
    [self addSubview:self.retryBtn];
    [self addSubview:self.adMogobarView];
    [self addSubview:self.resultView];
}

#pragma mark - 属性定义

-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView=[[UIView alloc]initWithFrame:_backgroundViewRect];
    }
    return _backgroundView;
}


-(UIImageView *)backgroundImageView{
    if (!_backgroundImageView) {
        _backgroundImageView=[[UIImageView alloc]initWithFrame:_backgroundImageViewRect];
        _backgroundImageView.image=[UIImage imageNamed:@"bg.jpg"];
//        _backgroundImageView.backgroundColorHex=@"00008B";
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
//        _cloudImageView=[[UIEffectDesignerView alloc]initWithFile:@"cloud.ped"];
//        _cloudImageView.emitter.position=CGPointMake(_cloudImageViewRect.origin.x+_cloudImageViewRect.size.width/2, _cloudImageViewRect.origin.y+_cloudImageViewRect.size.height/2);
        
//        _cloudImageView.emitter.emitterSize=_cloudImageViewRect.size;
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

-(UIButton *)retryBtn{
    if (!_retryBtn) {
        _retryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _retryBtn.frame=_retryBtnRect;
        [_retryBtn quicklySetFontPoint:28 textColorHex:@"652709" textAlignment:NSTextAlignmentCenter title:@"retry"];
        _retryBtn.backgroundColorHex=@"6CCA5C";
        _retryBtn.layer.borderColor=[[UIColor colorWithHex:@"652709"]CGColor];
        _retryBtn.layer.cornerRadius=5;
        _retryBtn.layer.borderWidth=4;
        _retryBtn.hidden=YES;
    }
    return _retryBtn;
}

-(UIView *)adMogobarView{
    if (!_adMogobarView) {
        _adMogobarView=[[AdMoGoView alloc]initWithAppKey:ADS_APPKEY adType:AdViewTypeNormalBanner adMoGoViewDelegate:nil adViewPointType:AdMoGoViewPointTypeDown_middle];
    }
    return _adMogobarView;
}

-(SJResultView *)resultView{
    if (!_resultView) {
        _resultView=[[SJResultView alloc]initWithFrame:_resultViewRect];
        _resultView.alpha=0;
    }
    return _resultView;
}


-(void)reloadUI{
    [UIView animateWithDuration:0.6 animations:^{
        self.resultView.alpha=0;
    }];
    self.markLabel.frame=_markLabelRect;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
