//
//  ReviewViewController.m
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/7.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property(weak, nonatomic) IBOutlet UIView *dialogView;
@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.view.bounds;
    [self.backgroundImageView addSubview:blurEffectView];

    CGAffineTransform scale = CGAffineTransformMakeScale(0.0, 0.0);
    CGAffineTransform translate = CGAffineTransformMakeTranslation(0, 500);
    self.dialogView.transform = CGAffineTransformConcat(scale, translate);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [UIView animateWithDuration:0.7
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.5
                        options:nil
                     animations:^{
                                    CGAffineTransform scale = CGAffineTransformMakeScale(1, 1);
                                    CGAffineTransform translate = CGAffineTransformMakeTranslation(0, 0);
                                    self.dialogView.transform = CGAffineTransformConcat(scale, translate);
                                } completion:nil];
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
