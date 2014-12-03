//
//  TextViewController.m
//  MyNote
//
//  Created by yjq on 14/11/26.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import "TextViewController.h"

@interface TextViewController ()

@end

@implementation TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]   initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    NSLog(@"text:%@",self.textView.text);
    // Do any additional setup after loading the view.
    self.textView.text = self.textString;
    NSLog(@"views:%@",self.navigationController.viewControllers);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString *) textDocPath
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"NSDocumentDirectory:%@",pathList[0]);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

-(void)dismissKeyboard
{
    [self.textView resignFirstResponder];
}

@end
