//
//  SJResultView.m
//  EscapeIt
//
//  Created by 陈少杰 on 15/6/13.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJResultView.h"

@implementation SJResultView
{
    CGRect _backgroundViewRect;
    CGRect _totalLabelRect;
    CGRect _maxMarkLabelRect;
    CGRect _thisMarkLabelRect;
    CGRect _retryBtnRect;
    CGRect _exitBtnRect;
}


@synthesize backgroundView=_backgroundView;
@synthesize totalLabel=_totalLabel;
@synthesize maxMarkLabel=_maxMarkLabel;
@synthesize thisMarkLabel=_thisMarkLabel;
@synthesize retryBtn=_retryBtn;
@synthesize exitBtn=_exitBtn;


#pragma mark - 初始化

-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadSetting];
        [self loadUI];
    }
    return self;
}

-(void)loadSetting{
    _backgroundViewRect= CGRectMake((WIDTH-300)/2, (HEIGHT-300)/2, 300, 300);
    _totalLabelRect= CGRectMake(0, 30, CGRectGetWidth(_backgroundViewRect), 40);
    _maxMarkLabelRect= CGRectMake(30, 110, CGRectGetWidth(_backgroundViewRect)-60, 18);
    _thisMarkLabelRect= CGRectMake(30, 150, CGRectGetWidth(_backgroundViewRect)-60, 30);
    _exitBtnRect= CGRectMake(10, 250, CGRectGetWidth(_backgroundViewRect)/2-10, 14);
    _retryBtnRect= CGRectMake(CGRectGetWidth(_backgroundViewRect)/2, 250, CGRectGetWidth(_backgroundViewRect)/2-10, 18);
}

-(void)loadUI{
    self.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.6];
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.totalLabel];
    [self.backgroundView addSubview:self.maxMarkLabel];
    [self.backgroundView addSubview:self.thisMarkLabel];
    [self.backgroundView addSubview:self.retryBtn];
    [self.backgroundView addSubview:self.exitBtn];
}

#pragma mark - 属性定义

-(UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView=[[UIView alloc]initWithFrame:_backgroundViewRect];
        _backgroundView.backgroundColor=[UIColor whiteColor];
        _backgroundView.clipsToBounds=YES;
        _backgroundView.layer.cornerRadius=4;
    }
    return _backgroundView;
}

-(UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel=[[UILabel alloc]initWithFrame:_totalLabelRect];
        [_totalLabel quicklySetFontPoint:40 textColorHex:@"313746" textAlignment:NSTextAlignmentCenter];
    }
    return _totalLabel;
}

-(UILabel *)maxMarkLabel{
    if (!_maxMarkLabel) {
        _maxMarkLabel=[[UILabel alloc]initWithFrame:_maxMarkLabelRect];
        [_maxMarkLabel quicklySetFontPoint:18 textColorHex:@"313746" textAlignment:NSTextAlignmentLeft];
    }
    return _maxMarkLabel;
}

-(UILabel *)thisMarkLabel{
    if (!_thisMarkLabel) {
        _thisMarkLabel=[[UILabel alloc]initWithFrame:_thisMarkLabelRect];
        [_thisMarkLabel quicklySetFontPoint:30 textColorHex:@"313746" textAlignment:NSTextAlignmentLeft];
    }
    return _thisMarkLabel;
}

-(UIButton *)retryBtn{
    if (!_retryBtn) {
        _retryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _retryBtn.frame=_retryBtnRect;
        [_retryBtn quicklySetFontPoint:18 textColorHex:@"313746" textAlignment:NSTextAlignmentCenter title:@"再来一局"];
    }
    return _retryBtn;
}

-(UIButton *)exitBtn{
    if (!_exitBtn) {
        _exitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _exitBtn.frame=_exitBtnRect;
        [_exitBtn quicklySetFontPoint:14 textColorHex:@"313746" textAlignment:NSTextAlignmentCenter title:@"返回"];
    }
    return _exitBtn;
}



#pragma mark - 其他方法
-(void)showWithMark:(NSInteger)mark maxMark:(NSInteger)maxMark{
    if(mark>=maxMark){
        self.totalLabel.text=@"新纪录!!";
    }else{
        self.totalLabel.text=@"游戏结束";
    }
    self.thisMarkLabel.text=[NSString stringWithFormat:@"本局得分：%d",mark];
    self.maxMarkLabel.text=[NSString stringWithFormat:@"历史最高分：%d",maxMark];
    
    self.hidden=NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
