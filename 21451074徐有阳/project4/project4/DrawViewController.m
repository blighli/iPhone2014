//
//  DrawViewController.m
//  project4
//
//  Created by xuyouyang on 14/11/23.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"

@interface DrawViewController ()
@property (strong,nonatomic)  DrawView *drawView;
@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    CGRect viewFrame = self.view.frame;
    CGRect viewFrame = CGRectMake(0, 64, 375, 520);
    self.drawView = [[DrawView alloc]initWithFrame:viewFrame];
    [self.drawView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview: self.drawView];
    [self.view sendSubviewToBack:self.drawView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
