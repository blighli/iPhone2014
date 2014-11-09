//
//  NewTaskViewController.m
//  TodoList
//
//  Created by Devon on 6/11/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "NewTaskViewController.h"

@interface NewTaskViewController ()

@end

@implementation NewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.taskName becomeFirstResponder];
    
    if (self.name != nil) {
        self.taskName.text = self.name;
    }
    if (self.content != nil) {
        self.taskContent.text = self.content;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveNewTask:(UIBarButtonItem *)sender {
    
   
    if (![self.taskName.text isEqualToString:@""]) {
        NSString *fileName = [NSString stringWithFormat:@"%@.txt",self.taskName.text];
        
        NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *filePath = [[pathList objectAtIndex:0] stringByAppendingPathComponent:fileName];
        
        NSString *contentStr = self.taskContent.text;
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData *data = [contentStr dataUsingEncoding:enc];
        
        [data writeToFile:filePath atomically:NO];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Prompt" message:@"Please enter task name first" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];        
    }
    
}
@end
