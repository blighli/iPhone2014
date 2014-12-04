//
//  WriteViewController.m
//  TODOListHW
//
//  Created by StarJade on 14-11-10.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//


#import "WriteViewController.h"
#import "DrawPlaneView.h"
#import "UIImage+DrawCaptureView.h"
#import "TaskStore.h"
@interface WriteViewController ()
@property (weak, nonatomic) IBOutlet DrawPlaneView *drawView;

@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancle:(id)sender {
	[self.drawplane backView];
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)reDraw:(id)sender {
	 [self.drawplane cleanView];
}

- (IBAction)done:(id)sender {
	TaskStore *taskStore = [TaskStore sharedStore];
	taskStore.isDoop = YES;
	taskStore.doop = [UIImage captureimageview:_drawView];
	[_drawView cleanView];
	[self.drawplane backView];
	[self dismissViewControllerAnimated:YES completion:nil];

}

@end
