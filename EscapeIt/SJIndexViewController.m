//
//  ViewController.m
//  EscapeIt
//
//  Created by 陈少杰 on 15/5/20.
//  Copyright (c) 2015年 陈少杰. All rights reserved.
//

#import "SJIndexViewController.h"
#import "SJIndexView.h"
#import "SJGameViewController.h"
#import <POP.h>
#import "SJMarkManager.h"

@interface SJIndexViewController ()
@property(nonatomic)SJIndexView *mainView;
@property(nonatomic)NSTimer *timer;
@end

@implementation SJIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.mainView.startBtn addTarget:self action:@selector(openGameVC) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)initTimer{
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(update) userInfo:nil repeats:YES];
}

-(void)openGameVC{
    SJGameViewController *gameVC=[[SJGameViewController alloc]init];
    [self.navigationController pushViewController:gameVC animated:YES];
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
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initTimer];
    self.mainView.maxMarkLabel.text=[NSString stringWithFormat:@"最高分：%d",[SJMarkManager getMark]];
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
