//
//  DetailViewController.m
//  MyToDoList
//
//  Created by alwaysking on 14/11/9.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize delegate;
@synthesize textview;
@synthesize btnItemDone;

- (void)viewDidLoad {
    [super viewDidLoad];
    textview.text = [tableData objectAtIndex:tableDataRow];
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




- (IBAction)btnDone:(id)sender{
    if (![textview.text isEqual: @""]) {
        [tableData replaceObjectAtIndex:tableDataRow withObject:textview.text];
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];

//    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)btnCanle:(id)sender{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
