//
//  ShareViewController.m
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/12.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.view.bounds;
    [self.backgroundImageView addSubview:blurEffectView];
    
//    CGAffineTransform scale = CGAffineTransformMakeScale(0.0, 0.0);
//    CGAffineTransform translate = CGAffineTransformMakeTranslation(0, 500);
//    self.dialogView.transform = CGAffineTransformConcat(scale, translate);
    
    // Move the buttons off screen (bottom)
    CGAffineTransform translateDown = CGAffineTransformMakeTranslation(0, 500);
    self.facebookButton.transform = translateDown;
    self.messageButton.transform = translateDown;
    
    // Move the buttons off screen (top)
    CGAffineTransform translateUp = CGAffineTransformMakeTranslation(0, -500);
    self.twitterButton.transform = translateUp;
    self.emailButton.transform = translateUp;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
  
    CGAffineTransform translate = CGAffineTransformMakeTranslation(0, 0);
    self.facebookButton.hidden = false;
    self.twitterButton.hidden = false;
    self.emailButton.hidden = false;
    self.messageButton.hidden = false;
    
    [UIView animateWithDuration:0.8
                          delay:0.0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:nil
                     animations:^{
                         self.facebookButton.transform = translate;
                         self.emailButton.transform = translate;
                     } completion:nil];
    
    [UIView animateWithDuration:0.8
                          delay:0.5
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:nil
                     animations:^{
                         self.twitterButton.transform = translate;
                         self.messageButton.transform = translate;
                     } completion:nil];
}

@end
