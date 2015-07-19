//
//  UpdateViewController.m
//  weiBo
//
//  Created by lixu on 15/1/10.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import "UpdateViewController.h"

@interface UpdateViewController ()

@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webService=[webServiceApi new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)updateButton:(id)sender {
    if ([self.textView.text isEqual:@""]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"输入的内容不能为空" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }else{
        NSString *string=self.textView.text;
        [self.webService updateMyNews:string];
        NSLog(@"------%@------",string);
    }
}
- (IBAction)cancelButton:(id)sender {
    self.textView.text=@"";
}
@end
