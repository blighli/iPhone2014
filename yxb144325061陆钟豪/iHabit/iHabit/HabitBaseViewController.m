//
//  HabitBaseViewController.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/15.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "HabitBaseViewController.h"

@interface HabitBaseViewController ()

@end

@implementation HabitBaseViewController

-(instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    _viewController = viewController;
    [_viewController setValue:self forKey:@"habitBaseViewController"];
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, -20, 320, 100)];
    navigationBar.translucent = NO;
    _navigationBar = navigationBar;
    [self addChildViewController:_viewController];
    [self.view addSubview:_viewController.view];
    [self.view addSubview:navigationBar];
    [navigationBar pushNavigationItem:_viewController.navigationItem animated:NO];
    
    // 添加nav阴影
    navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
    navigationBar.layer.shadowOffset = CGSizeMake(0, 0);
    navigationBar.layer.shadowOpacity = 0.5;
    navigationBar.layer.shadowRadius = 5;
    

    _viewController.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 80 - 20, self.view.frame.size.width, self.view.frame.size.height + 80 - 20); // FIXME (80 - 20) is hard code
    
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

@end
