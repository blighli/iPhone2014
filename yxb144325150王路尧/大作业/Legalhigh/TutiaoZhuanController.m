//
//  TutiaoZhuanController.m
//  Legalhigh
//
//  Created by 王路尧 on 14/12/10.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import "TutiaoZhuanController.h"
#import "BIDViewController.h"
#import "TupianBianji.h"
@implementation TutiaoZhuanController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //加载完视图后，执行其他的额外设置。
    self.YellowViewController = [[BIDViewController alloc]
                                 initWithNibName:@"BIDViewController" bundle:nil];
    [self.view insertSubview:self.YellowViewController.view atIndex:0];
    self.backButton.hidden = YES;
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.image=self.YellowViewController.image;
    
    if (self.image==nil) {
        return;
    }
    
    
   [UIView beginAnimations:@"View Flip" context:nil];
   [UIView setAnimationDuration:1.25];
   [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    //如果该视图没有父视图，则释放它。
    
    if(self.BlueViewController == nil){
        self.BlueViewController =
        [[TupianBianji alloc] initWithNibName:@"TupianBianji" bundle:nil];
    }
    
    self.BlueViewController.image=self.image;
    
    [UIView setAnimationTransition:
     UIViewAnimationTransitionFlipFromLeft
                          forView:self.view cache:YES];
    [self.YellowViewController.view removeFromSuperview];
    [self.view insertSubview:self.BlueViewController.view atIndex:0];
        self.backButton.hidden = NO;
    [UIView commitAnimations];
        self.YellowViewController = nil;
    
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    //释放没有用到的缓存的数据和图片等。
    if(self.YellowViewController.view.superview == nil){
        self.YellowViewController = nil;
    }else{
        self.BlueViewController = nil;
    }
}

- (IBAction)backPressed:(id)sender {
    
    if (self.YellowViewController == nil){
        [UIView beginAnimations:@"View Flip" context:nil];
        [UIView setAnimationDuration:1.25];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
        [self.BlueViewController.view removeFromSuperview];
    self.YellowViewController = [[BIDViewController alloc]
                                 initWithNibName:@"BIDViewController" bundle:nil];
        [UIView setAnimationTransition:
         UIViewAnimationTransitionFlipFromLeft
                               forView:self.view cache:YES];
    [self.view insertSubview:self.YellowViewController.view atIndex:0];
        
        [UIView commitAnimations];
        self.BlueViewController=nil;
        self.backButton.hidden=YES;
    }
}

@end