//
//  PageContentViewController.m
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/16.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "PageContentViewController.h"
#import "PageViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headingLabel.text = self.heading;
    self.subHeadingLabel.text = self.subHeading;
    self.contentImageView.image = [UIImage imageNamed:self.imageFile];
    self.pageControl.currentPage = self.index;
    
    if (self.index != 2) {
        self.forwardButton.hidden = false;
        self.getStartedButton.hidden = true;
    }else{
        self.forwardButton.hidden = true;
        self.getStartedButton.hidden = false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextScreen:(id)sender {
    PageViewController *pageViewController = (PageViewController *)self.parentViewController;
    [pageViewController forward:self.index];
}

- (IBAction)close:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:true forKey:@"hasViewedWalkthrough"];
    [self dismissViewControllerAnimated:true completion:nil];
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
