//
//  ViewController.m
//  CrossGroove
//
//  Created by 陈晓强 on 14/12/21.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "ViewController.h"
#import "TopicTableViewController.h"
#import "User.h"
#import "UserDetailInfo.h"
#import "AFNetworking.h"

@interface ViewController ()


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES];
    _password.delegate = self;
    _username.delegate = self;
    CGRect phoneRect = [[UIScreen mainScreen] bounds];
    self.view.layer.contents = (id)[[UIImage imageNamed:@"background.png"] CGImage];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake((phoneRect.origin.x + phoneRect.size.width)/2 - 60,
                                                                66, 120, 120)];
    [headView.layer setCornerRadius:CGRectGetHeight([headView bounds])/2];
    headView.layer.masksToBounds = YES;
    headView.layer.borderWidth = 2;
    headView.layer.borderColor = [[UIColor whiteColor] CGColor];
    headView.layer.contents = (id)[[UIImage imageNamed:@"background.jpg"] CGImage];
    [self.view addSubview:headView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationItem.hidesBackButton = YES;
    [self.navigationItem setHidesBackButton:YES];

}

- (IBAction)loginHandle:(id)sender {
    
    NSLog(@"sa");
    //登陆处理
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = @{@"username": _username.text,
                                 @"password": _password.text};
    //服务器端检查账户名密码
    [manager POST:@"http://localhost:8080/Groose/main/Login.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray * answer = (NSArray *) responseObject;
        if (answer.count == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登陆失败" message:@"用户名或密码错误" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else{
            //将用户名密码存入沙盒
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:_username.text forKey:@"username"];
            [userDefaults setObject:_password.text forKey:@"password"];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"TopicStoryboard" bundle:nil];
            TopicTableViewController *topicViewController = [storyboard instantiateViewControllerWithIdentifier:@"topicViewController"];
            [self.navigationController setNavigationBarHidden:NO];
            [self.navigationController pushViewController:topicViewController animated:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
    }];
    
    
}
#pragma mark - HTTP Request

#pragma mark - Keyboard handle

- (IBAction)backgroundTap:(id)sender
{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
}


#pragma mark - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_username resignFirstResponder];
    [_password resignFirstResponder];
    return YES;
}

@end
