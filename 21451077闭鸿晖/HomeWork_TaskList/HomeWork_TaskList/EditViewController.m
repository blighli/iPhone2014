//
//  EditViewController.m
//  HomeWork_TaskList
//
//  Created by turbobhh on 11/9/14.
//  Copyright (c) 2014 org.bhh.homework. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;

@end

@implementation EditViewController

-(void)viewWillAppear:(BOOL)animated{
    self.taskTextField.text=self.preTaskLabel.text;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.title=@"编辑任务名";

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
- (IBAction)confirm:(id)sender {
    self.preTaskLabel.text=self.taskTextField.text;
     [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
