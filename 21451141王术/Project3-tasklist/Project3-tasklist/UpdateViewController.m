//
//  UpdateViewController.m
//  Project3-tasklist
//
//  Created by  ws on 11/7/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import "UpdateViewController.h"
#import "ViewController.h"
@interface UpdateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *update;
@property (weak, nonatomic) NSString *exchangeString;
@property (weak, nonatomic) NSIndexPath *indexPath;
@end

@implementation UpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _update.text=_exchangeString;
    //[_tasks replaceObjectAtIndex:1 withObject:_update];
    [_tasks writeToFile:docPath() atomically:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)confirm:(id)sender {
    NSString *text = [_update text]; //从输入框获取新的任务
    [_tasks replaceObjectAtIndex:_indexPath.row withObject:text]; //将新的任务添加到模型
    [_update resignFirstResponder]; //关闭软键盘
    [_tasks writeToFile:docPath() atomically:YES];
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
