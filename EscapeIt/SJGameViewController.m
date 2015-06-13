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
#import "AdMoGoDelegateProtocol.h"
#import "AdMoGoWebBrowserControllerUserDelegate.h"
#import "SJMarkManager.h"

@interface SJGameViewController ()<AdMoGoDelegate,AdMoGoWebBrowserControllerUserDelegate>
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
    
    [self.mainView.resultView.retryBtn addTarget:self action:@selector(retry) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.resultView.exitBtn addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)loadUI{
    self.mainView.adMogobarView.delegate=self;
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
    
    POPSpringAnimation *shockAnimate=[POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    shockAnimate.fromValue=[NSValue valueWithCGPoint:CGPointMake(WIDTH/2, HEIGHT/2)];
    shockAnimate.toValue=[NSValue valueWithCGPoint:CGPointMake(WIDTH/2, -HEIGHT/2)];
    shockAnimate.springSpeed=20;
    shockAnimate.springBounciness=12;
    
    [self.mainView.resultView.backgroundView pop_addAnimation:shockAnimate forKey:@"shock"];
}

-(void)exit{
    [self.navigationController popViewControllerAnimated:YES];
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
    shockAnimate.fromValue=[NSValue valueWithCGPoint:CGPointMake(WIDTH/2, -HEIGHT/2)];
    shockAnimate.toValue=[NSValue valueWithCGPoint:CGPointMake(WIDTH/2, HEIGHT/2)];
    shockAnimate.springSpeed=20;
    shockAnimate.springBounciness=12;
    
    [self.mainView.resultView.backgroundView pop_addAnimation:shockAnimate forKey:@"shock"];
    
    [UIView animateWithDuration:0.6 animations:^{
        self.mainView.resultView.alpha=1;
        [self.mainView.leftPeopleImageView quicklySetOriginX:WIDTH/2-CGRectGetWidth(self.mainView.leftPeopleImageView.frame)];
        [self.mainView.rightPeopleImageView quicklySetOriginX:WIDTH/2];
    }];
    
    [self.mainView.resultView showWithMark:self.mark maxMark:[SJMarkManager getMark]];
}

-(void)update{
    static int i=0;
    i++;
    
//    static float scale=1;
//    if (i%1000<500) {
//        scale+=0.0005;
//    }else{
//        scale-=0.0005;
//    }
    
    self.mainView.backgroundImageView.transform=CGAffineTransformMakeRotation(i/4800.);
    
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
        UIImageView *v=(UIImageView*)[self.things objectAtIndex:i];
        [v quicklySetOriginY:CGRectGetMinY(v.frame)+self.thingV];
        
        
        if(CGRectIntersectsRect(v.frame, self.mainView.leftPeopleImageView.frame)||CGRectIntersectsRect(v.frame, self.mainView.rightPeopleImageView.frame)){
            
            if ([self.hasCollisionTag containsObject:@(v.tag)]) {
                continue;
            }
            [self.hasCollisionTag addObject:@(v.tag)];
            
            [self showBombEffect:v];
            //[v startAnimating];
            
            self.life--;
            
            if (self.life<=0) {
                [self gameOver];
                continue;
            }
        }
        
        if(CGRectGetMinY(v.frame)>HEIGHT){
            [self showBombEffect:v];
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
    
    [SJMarkManager refreshMarkWithMark:self.mark];
    self.mainView.markLabel.text=[NSString stringWithFormat:@"%lu",(unsigned long)self.mark];
}

-(void)showBombEffect:(UIView *)obj{
    if (obj.hidden) {
        return;
    }
    obj.hidden=YES;
    
    NSMutableArray *imgs=[NSMutableArray new];
    for (int i=0; i<8; i++) {
        [imgs addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i]]];
    }
    
    UIImageView *bomb=[[UIImageView alloc]initWithFrame:obj.frame];
    bomb.animationImages=imgs;
    bomb.animationDuration=0.6;
    bomb.transform=CGAffineTransformMakeScale(2, 2);
    [bomb startAnimating];
    [self.mainView addSubview:bomb];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [bomb stopAnimating];
        [bomb removeFromSuperview];
    });
}

-(void)createOneThing{
    static NSInteger objectTag=1;
    
    UIImageView *v=[[UIImageView alloc]initWithFrame:CGRectMake(arc4random()%(int)(WIDTH-20), -20, 20, 20)];
    v.image=[UIImage imageNamed:@"bomb.png"];
    v.tag=objectTag;
    
    [self.mainView.backgroundView addSubview:v];
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


#pragma mark -
#pragma mark AdMoGoDelegate delegate
/*
 返回广告rootViewController
 */
- (UIViewController *)viewControllerForPresentingModalView{
    return self;
}



/**
 * 广告开始请求回调
 */
- (void)adMoGoDidStartAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告开始请求回调");}
/**
 * 广告接收成功回调
 */
- (void)adMoGoDidReceiveAd:(AdMoGoView *)adMoGoView{
    NSLog(@"%@",NSStringFromCGRect(adMoGoView.frame));
    NSLog(@"广告接收成功回调");
}
/**
 * 广告接收失败回调
 */
- (void)adMoGoDidFailToReceiveAd:(AdMoGoView *)adMoGoView didFailWithError:(NSError *)error{
    NSLog(@"广告接收失败回调");
    
}
/**
 * 点击广告回调
 */
- (void)adMoGoClickAd:(AdMoGoView *)adMoGoView{
    NSLog(@"点击广告回调");
}
/**
 *You can get notified when the user delete the ad
 广告关闭回调
 */
- (void)adMoGoDeleteAd:(AdMoGoView *)adMoGoView{
    NSLog(@"广告关闭回调");
}

#pragma mark -
#pragma mark AdMoGoWebBrowserControllerUserDelegate delegate

/*
 浏览器将要展示
 */
- (void)webBrowserWillAppear{
    NSLog(@"浏览器将要展示");
}

/*
 浏览器已经展示
 */
- (void)webBrowserDidAppear{
    NSLog(@"浏览器已经展示");
}

/*
 浏览器将要关闭
 */
- (void)webBrowserWillClosed{
    NSLog(@"浏览器将要关闭");
}

/*
 浏览器已经关闭
 */
- (void)webBrowserDidClosed{
    NSLog(@"浏览器已经关闭");
}

/**
 *直接下载类广告 是否弹出Alert确认
 */
-(BOOL)shouldAlertQAView:(UIAlertView *)alertView{
    return NO;
}

- (void)webBrowserShare:(NSString *)url{
    
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
