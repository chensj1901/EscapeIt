//
//  SJGameView.h
//  EscapeIt
//
//  Created by 陈少杰 on 15/5/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIEffectDesignerView.h"
#import "AdMoGoView.h"
#import "SJResultView.h"

@interface SJGameView : UIView
@property(nonatomic,readonly)UIView *backgroundView;
@property(nonatomic,readonly)UIImageView *backgroundImageView;
@property(nonatomic,readonly)UILabel *markLabel;
@property(nonatomic,readonly)UIImageView *leftPeopleImageView;
@property(nonatomic,readonly)UIImageView *rightPeopleImageView;
@property(nonatomic,readonly)UIImageView *heatOneImageView;
@property(nonatomic,readonly)UIImageView *heatTwoImageView;
@property(nonatomic,readonly)UIImageView *heatThreeImageView;
@property(nonatomic,readonly)UIButton *retryBtn;
@property(nonatomic,readonly)UIImageView *cloudImageView;
@property(nonatomic,readonly)AdMoGoView *adMogobarView;
@property(nonatomic,readonly)SJResultView *resultView;
-(void)reloadUI;
@end
