//
//  SJGameViewController.m
//  EscapeIt
//
//  Created by 陈少杰 on 15/5/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJGameViewController.h"
#import "SJGameView.h"
@interface SJGameViewController ()
@property(nonatomic)SJGameView *mainView;
@property(nonatomic)NSTimer *timer;
@property(nonatomic)BOOL isTouch;
@property(nonatomic)CGFloat peopleV;
@property(nonatomic)CGFloat thingV;
@property(nonatomic)CGFloat createThingsP;
@property(nonatomic)NSMutableArray *things;
@end

@implementation SJGameViewController
-(void)loadSetting{
    self.peopleV=3;
    self.thingV=3;
    self.createThingsP=1./5;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTimer];
    
    UILongPressGestureRecognizer *tap=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(didReceiveTap:)];
    tap.minimumPressDuration=0.01;
    [self.mainView addGestureRecognizer:tap];
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
    for (UIView *v in self.things) {
        [v removeFromSuperview];
    }
    [self.things removeAllObjects];
    [self.mainView.leftPeopleImageView quicklySetOriginX:WIDTH/2-CGRectGetWidth(self.mainView.leftPeopleImageView.frame)];
    [self.mainView.rightPeopleImageView quicklySetOriginX:WIDTH/2];
    [self initTimer];
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
        alert(@"GAMEOVER");
        [self.timer invalidate];
        [self retry];
        }
        if(CGRectGetMinY(v.frame)>HEIGHT){
            [v removeFromSuperview];
            [self.things removeObject:v];
            i--;
        }
    }

    
}

-(void)createOneThing{
    UIView *v=[[UIView alloc]initWithFrame:CGRectMake(arc4random()%(int)(WIDTH-20), -20, 20, 20)];
    v.backgroundColor=[UIColor blackColor];
    [self.mainView addSubview:v];
    [self.things addObject:v];
}

-(NSMutableArray *)things{
    if (!_things) {
        _things=[[NSMutableArray alloc]init];
    }
    return _things;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
