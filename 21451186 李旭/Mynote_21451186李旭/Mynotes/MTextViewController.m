//
//  MTextViewController.m
//  Mynotes
//
//  Created by lixu on 14/11/15.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import "MTextViewController.h"

@interface MTextViewController ()

@property(strong,nonatomic) MDBAccess *dbaccess;
@end

@implementation MTextViewController
@synthesize noteTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    _dbaccess=[[MDBAccess alloc] init];
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

- (IBAction)saveText:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"名称" message:@"请输入想要保存的名称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alert show];
//    [_dbaccess initializeDatabase];
//    [_dbaccess createTable];
//    [_dbaccess saveDatas:noteTextView.text and:0];
//    NSLog(@"========--------======");
//    NSMutableArray *datasArray=[_dbaccess getAllDatas];
//    NSLog(@"=================");
//    NSLog(@"%@",datasArray);
//    [_dbaccess closeDatabase];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        UITextField* textField=[alertView textFieldAtIndex:0];
        NSString * name=[textField.text stringByAppendingString:@"----文本"];
        [_dbaccess initializeDatabase];
        [_dbaccess createTable];
        [_dbaccess saveDatas:noteTextView.text Type:0 NibName:name];
        NSMutableArray *datasArray=[_dbaccess getAllDatas];
        NSLog(@"=================");
        NSLog(@"%@",datasArray);
        [_dbaccess closeDatabase];
        
    }
}



@end
