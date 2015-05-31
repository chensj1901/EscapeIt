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

@interface SJIndexViewController ()
@property(nonatomic)SJIndexView *mainView;
@end

@implementation SJIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.mainView.startBtn addTarget:self action:@selector(openGameVC) forControlEvents:UIControlEventTouchUpInside];
}

-(void)openGameVC{
    
    SJGameViewController *gameVC=[[SJGameViewController alloc]init];
    [self.navigationController pushViewController:gameVC animated:YES];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
