//
//  ViewController.m
//  SXDHomeWork
//
//  Created by  sephiroth on 14/12/11.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import "ViewController.h"
#import "PaintViewController.h"
#import "PickViewController.h"

@interface ViewController ()

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) PaintViewController *paintViewContorller;

@property (strong ,nonatomic) PickViewController *pickViewController;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)donePressed:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"Picker"];
    [self.view insertSubview:self.pickViewController.view atIndex:0];
    self.doneButton.hidden=YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.image=self.pickViewController.image;
    if (self.image==nil) {
        //NSLog(@"NULL");
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"You need a picture" message:@"Please take a photo or pick a picture from library first!" delegate:nil cancelButtonTitle:@"OK!" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [UIView beginAnimations:@"View Flip" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if (!self.paintViewContorller.view.superview) {
        if (!self.paintViewContorller) {
            self.paintViewContorller=[self.storyboard instantiateViewControllerWithIdentifier:@"Painter"];
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [self.pickViewController.view removeFromSuperview];
        self.paintViewContorller.image=self.image;
        [self.view insertSubview:self.paintViewContorller.view atIndex:0];
        self.doneButton.hidden=NO;
    }
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (!self.paintViewContorller.view.superview) {
        self.paintViewContorller=nil;
    }
    else
    {
        self.pickViewController=nil;
    }
}

- (IBAction)donePressed:(id)sender {
    [UIView beginAnimations:@"View Flip" context:NULL];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    if (!self.pickViewController.view.superview) {
        if (!self.pickViewController) {
            self.pickViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"Picker"];
        }
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [self.paintViewContorller.view removeFromSuperview];
        [self.view insertSubview:self.pickViewController.view atIndex:0];
        self.doneButton.hidden=YES;
    }
    [UIView commitAnimations];}
@end
