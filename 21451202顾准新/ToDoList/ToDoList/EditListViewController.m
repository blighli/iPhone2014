//
//  EditListViewController.m
//  ToDoList
//
//  Created by 顾准新 on 14-11-9.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "EditListViewController.h"
#import "ViewController.h"
@interface EditListViewController ()
{
    UINavigationController *_editController;
    UITextField *_editField;
}

@end

@implementation EditListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(backToList)];
    
    _editField = [[UITextField alloc]initWithFrame:CGRectMake(20, 90, 200, 31)];
    [_editField setBorderStyle:UITextBorderStyleRoundedRect];
    [_editField setPlaceholder:@"Enter to-do-thing"];
    
    if(![self.editText isEqualToString:@""])
    {
        _editField.text = self.editText;
    }
    [self.view addSubview:_editField];
    // Do any additional setup after loading the view.
}
-(void)backToList{
    if(![_editField.text isEqualToString:@""] )
    {
        //NSLog(@"lll%@",_editField.text);
        [self.delegate editTask:_editField.text withIndex:self.row];
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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

@end
