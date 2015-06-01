//
//  SJGameViewController.m
//  EscapeIt
//
//  Created by 陈少杰 on 15/5/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJGameViewController.h"
#import "SJGameView.h"
#import <POP.h>

@interface SJGameViewController ()
@property(nonatomic)SJGameView *mainView;
@property(nonatomic)NSTimer *timer;
@property(nonatomic)BOOL isTouch;
@property(nonatomic)CGFloat peopleV;
@property(nonatomic)CGFloat thingV;
@property(nonatomic)CGFloat createThingsP;
@property(nonatomic)NSMutableArray *things;
@property(nonatomic)NSUInteger mark;
@property(nonatomic)NSInteger life;
@property(nonatomic)NSMutableArray *hasCollisionTag;
@end


@interface SJGameViewController ()<UIGestureRecognizerDelegate>

@end

@implementation SJGameViewController
-(void)loadSetting{
    self.peopleV=2.5;
    self.thingV=3;
    self.createThingsP=1./8;
    self.life=3;
    self.mark=0;
}

-(void)loadTarget{
    UILongPressGestureRecognizer *tap=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(didReceiveTap:)];
    tap.minimumPressDuration=0.01;
    tap.delegate=self;
    [self.mainView addGestureRecognizer:tap];
    
    [self.mainView.retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTimer];
    
}

-(void)didReceiveTap:(UIGestureRecognizer*)tap{
    if (tap.state==UIGestureRecognizerStateBegan) {
        self.isTouch=YES;
    }
    if (tap.state==UIGestureRecognizerStateCancelled||tap.state==UIGestureRecognizerStateEnded) {
        self.isTouch=NO;
    }
}

-(void)initTimer{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(update) userInfo:nil repeats:YES];
}

-(void)retry{
    self.mark=0;
    self.life=3;
    for (UIView *v in self.things) {
        [v removeFromSuperview];
    }
    [self.things removeAllObjects];
    [self.mainView.leftPeopleImageView quicklySetOriginX:WIDTH/2-CGRectGetWidth(self.mainView.leftPeopleImageView.frame)];
    [self.mainView.rightPeopleImageView quicklySetOriginX:WIDTH/2];
    [self initTimer];
    
    [self.mainView reloadUI];
}

-(void)gameOver{
    [self.timer invalidate];
    for (UIView *v in self.things) {
        [v removeFromSuperview];
    }
    
//    UILabel *markLabel=[[UILabel alloc]initWithFrame:self.mainView.markLabel.frame];
//    markLabel=[self.mainView.markLabel copy];
//    [self.mainView addSubview:markLabel];
    
    

    POPSpringAnimation *shockAnimate=[POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    shockAnimate.toValue=[NSValue valueWithCGPoint:CGPointMake(WIDTH/2, HEIGHT/2)];
    shockAnimate.springSpeed=20;
    shockAnimate.springBounciness=12;
    
    [self.mainView.markLabel pop_addAnimation:shockAnimate forKey:@"shock"];
    
    [UIView animateWithDuration:0.6 animations:^{
    
        [self.mainView.leftPeopleImageView quicklySetOriginX:WIDTH/2-CGRectGetWidth(self.mainView.leftPeopleImageView.frame)];
        [self.mainView.rightPeopleImageView quicklySetOriginX:WIDTH/2];
    }];
    
    self.mainView.retryBtn.hidden=NO;
}

-(void)update{
    static int i=0;
    i++;
    if (i%10==0) {
        if ((arc4random()%100)<(self.createThingsP*100)) {
            [self createOneThing];
        }
    }
    
    if (self.isTouch) {
        
        [self.mainView.leftPeopleImageView quicklySetOriginX:MAX(0,CGRectGetMinX( self.mainView.leftPeopleImageView.frame)-self.peopleV)];
        [self.mainView.rightPeopleImageView quicklySetOriginX:MIN(WIDTH-CGRectGetWidth(self.mainView.rightPeopleImageView.frame),CGRectGetMinX(self.mainView.rightPeopleImageView.frame)+self.peopleV)];
    }else{
        [self.mainView.leftPeopleImageView quicklySetOriginX:MIN(WIDTH/2-CGRectGetWidth(self.mainView.leftPeopleImageView.frame),CGRectGetMinX( self.mainView.leftPeopleImageView.frame)+self.peopleV)];
        [self.mainView.rightPeopleImageView quicklySetOriginX:MAX(WIDTH/2,CGRectGetMinX(self.mainView.rightPeopleImageView.frame)-self.peopleV)];
    }
    
    for (int i=0;i<[self.things count];i++) {
        UIView *v=[self.things objectAtIndex:i];
        [v quicklySetOriginY:CGRectGetMinY(v.frame)+self.thingV];
        
        
        if(CGRectIntersectsRect(v.frame, self.mainView.leftPeopleImageView.frame)||CGRectIntersectsRect(v.frame, self.mainView.rightPeopleImageView.frame)){
            
            if ([self.hasCollisionTag containsObject:@(v.tag)]) {
                continue;
            }
            [self.hasCollisionTag addObject:@(v.tag)];
            
            self.life--;
            
            if (self.life<=0) {
                [self gameOver];
                continue;
            }
        }
        
        if(CGRectGetMinY(v.frame)>HEIGHT){
            [v removeFromSuperview];
            [self.things removeObject:v];
            i--;
            self.mark++;
        }
    }
    
    if (self.life==3) {
        self.mainView.heatOneImageView.image=[UIImage imageNamed:@"heat.png"];
        self.mainView.heatTwoImageView.image=[UIImage imageNamed:@"heat.png"];
        self.mainView.heatThreeImageView.image=[UIImage imageNamed:@"heat.png"];
    }else if(self.life==2){
        self.mainView.heatOneImageView.image=[UIImage imageNamed:@"heat.png"];
        self.mainView.heatTwoImageView.image=[UIImage imageNamed:@"heat.png"];
        self.mainView.heatThreeImageView.image=[UIImage imageNamed:@"heat_h.png"];
    }else if(self.life==1){
        self.mainView.heatOneImageView.image=[UIImage imageNamed:@"heat.png"];
        self.mainView.heatTwoImageView.image=[UIImage imageNamed:@"heat_h.png"];
        self.mainView.heatThreeImageView.image=[UIImage imageNamed:@"heat_h.png"];
    }else{
        self.mainView.heatOneImageView.image=[UIImage imageNamed:@"heat_h.png"];
        self.mainView.heatTwoImageView.image=[UIImage imageNamed:@"heat_h.png"];
        self.mainView.heatThreeImageView.image=[UIImage imageNamed:@"heat_h.png"];
    }
    
    self.mainView.markLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.mark];
}

-(void)createOneThing{
    static NSInteger objectTag=1;
    
    UIImageView *v=[[UIImageView alloc]initWithFrame:CGRectMake(arc4random()%(int)(WIDTH-20), -20, 20, 20)];
    v.image=[UIImage imageNamed:@"bomb.png"];
    v.tag=objectTag;
    
    [self.mainView.backgroundImageView addSubview:v];
    [self.things addObject:v];
    
    objectTag++;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(NSMutableArray *)things{
    if (!_things) {
        _things=[[NSMutableArray alloc]init];
    }
    return _things;
}

-(NSMutableArray *)hasCollisionTag{
    if (!_hasCollisionTag) {
        _hasCollisionTag=[[NSMutableArray alloc]init];
    }
    return _hasCollisionTag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
