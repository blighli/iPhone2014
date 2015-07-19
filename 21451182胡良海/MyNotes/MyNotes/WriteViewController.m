//
//  WriteViewController.m
//  MyNotes
//
//  Created by hu on 14/11/14.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import "WriteViewController.h"
#import "DrawPlaneView.h"
#import "UIImage+DrawCaptureView.h"

@interface WriteViewController ()

@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
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

- (IBAction)drawBack:(UIButton *)sender {
    [self.drawplane backView];
    
}

- (IBAction)drawClean:(UIButton *)sender {
    [self.drawplane cleanView];
}
@end
