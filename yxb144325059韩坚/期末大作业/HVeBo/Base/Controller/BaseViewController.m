//
//  BaseViewController.m
//  HVeBo
//
//  Created by HJ on 14/12/19.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewExt.h"

@interface BaseViewController ()
{
    UIWindow *_tipWindow;
}
@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleAction)];
        self.navigationItem.leftBarButtonItem = left;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [_delegate disappear];
}

- (void)showStatuxsTip:(BOOL)show title:(NSString *)title
{
    if (_tipWindow == nil ) {
        _tipWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        _tipWindow.windowLevel = UIWindowLevelStatusBar+10;
        _tipWindow.backgroundColor = [UIColor blackColor];
        UILabel *labrl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        labrl.textAlignment = NSTextAlignmentCenter;
        labrl.font = [UIFont systemFontOfSize:13.0];
        labrl.textColor =  [UIColor whiteColor];
        labrl.backgroundColor = [UIColor clearColor];
        labrl.tag = 2014;
        [_tipWindow addSubview:labrl];
        
        UIImageView *progress = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"queue_statusbar_progress.png"]];
        progress.frame = CGRectMake(0, 14, 100, 6);
        progress.tag = 2013;
        [_tipWindow addSubview:progress];
    }
    UILabel *labrl = (UILabel *)[_tipWindow viewWithTag:2014];
    UIImageView *progress = (UIImageView *)[_tipWindow viewWithTag:2013];
    if (show) {
        labrl.text = title;
        _tipWindow.hidden = NO;
        //动画发送中效果
        progress.left = 0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:2];
        [UIView setAnimationRepeatCount:1000];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];//匀速移动
        progress.left = [UIScreen mainScreen].bounds.size.width;
        [UIView commitAnimations];
    }else{
        progress.hidden  = YES;
        labrl.text = title;
        [self performSelector:@selector(removeTipWindow) withObject:nil afterDelay:1.5];
    }
    
}
- (void)removeTipWindow
{
    _tipWindow.hidden = YES;
}
- (void)cancleAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
