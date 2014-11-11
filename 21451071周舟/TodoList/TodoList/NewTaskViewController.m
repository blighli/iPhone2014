//
//  NewTaskViewController.m
//  TodoList
//
//  Created by 周舟 on 6/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "NewTaskViewController.h"

@interface NewTaskViewController ()

@end

@implementation NewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"views:%@",self.navigationController.viewControllers);
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



- (IBAction)tapView:(UITapGestureRecognizer *)sender {
    [self.taskContent resignFirstResponder];
}

- (IBAction)saveNewTask:(UIBarButtonItem *)sender {
    
   
    if (![self.taskName.text isEqualToString:@""]) {
        NSString *fileName = [NSString stringWithFormat:@"%@.txt",self.taskName.text];
        
        NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *filePath = [[pathList objectAtIndex:0] stringByAppendingPathComponent:fileName];
        
        
        NSLog(@"filePath:%@",filePath);
        
        NSString *contentStr = self.taskContent.text;
        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSData *data = [contentStr dataUsingEncoding:enc];
        
        [data writeToFile:filePath atomically:NO];
        
//        if ([self.delegate respondsToSelector:@selector(insertNewTask:)]) {
//            [self.delegate insertNewTask:self.taskName.text];
//        }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请先输入任务名称" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    
    
    
}
@end
