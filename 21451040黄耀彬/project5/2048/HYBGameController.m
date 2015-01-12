//
//  HYBViewController.m
//  2048
//
//  Created by hyb on 14/12/30.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import "HYBGameController.h"

@interface HYBGameController ()

@end

@implementation HYBGameController

#pragma mark - UIViewController

- (void)loadView{
    [super loadView];
    self.chessboard = [[HYBChessboard alloc] initWithFrame:CGRectMake(15, 200, 290, 290)];
    self.chessboard.delegate = self;
    [self.view addSubview:self.chessboard];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - HYBChessboard delegate

- (void)chessboard:(HYBChessboard *)chessboard didPerformAction:(HYBChessboardAction)action withObject:(id)object{
    if (action == HYBChessboardActionSelectCard){
        JTSImageViewController *viewController = (JTSImageViewController *)object;
        [viewController showFromViewController:self transition:JTSImageViewControllerTransition_FromOffscreen];
        return;
    }
}

@end
