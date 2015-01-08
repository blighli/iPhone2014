//
//  ThirdViewController.m
//  Homework4
//
//  Created by 李丛笑 on 14/12/2.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import "ThirdViewController.h"
#import "FirstViewController.h"
#import "DB.h"
#import "Data.h"

@interface ThirdViewController ()


@end

@implementation ThirdViewController
@synthesize indexPath;
@synthesize param;
@synthesize textView;

- (void)viewDidLoad {
    [super viewDidLoad];
      // Do any additional setup after loading the view.
    NSString *A = param;
    DB *db = [[DB alloc]init];
    Data *data = [[Data alloc]init];
    NSArray *results = [db QueryDB];
    data = results[[A intValue]];
  //  NSString *thistitle = results[[A intValue]];
    self.title = data.title;
    NSString *thistext = data.text;
    textView.text = thistext;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController* view = segue.destinationViewController;
    NSString *title = self.title;
    NSString *text = textView.text;
    NSString *number = param;
        if ([segue.identifier isEqualToString:@"tofirst"]==YES) {
        FirstViewController *firstview =(FirstViewController *)view;
        // result = @"ssssssss";
        [firstview setValue:title forKey:@"thistitle"];
        [firstview setValue:text forKey:@"thistext"];
        [firstview setValue:number forKey:@"thisnumber"];
    }

    
}


@end
