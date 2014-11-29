//
//  NoteTabBarViewController.m
//  EverNote
//
//  Created by 陈晓强 on 14/11/29.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "NoteTabBarViewController.h"
#import "ViewController.h"
@interface NoteTabBarViewController ()

@end

@implementation NoteTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftItemsSupplementBackButton = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Save:(id)sender {
    id viewController = [self selectedViewController];
    if ([viewController isKindOfClass:[ViewController class]]) {
        ViewController *myViewController = (ViewController *)viewController;
        UITextView *textView = myViewController.textView;
        NSLog(@"%@",textView.text);
        [self.navigationController popViewControllerAnimated:YES];

    }
    
}


#pragma ViewController data handle

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"sss");
}


@end
