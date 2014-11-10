//
//  ChangeDate.m
//  Todolist
//
//  Created by yjq on 14/11/8.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import "ChangeDate.h"
#import "ViewController.h"

@interface ChangeDate ()

@property(weak,nonatomic) IBOutlet UITextField *textfield;

@property(weak,nonatomic) NSIndexPath *indexPath;
@property(weak,nonatomic) NSString *changeDate;

-(IBAction)Done:(id)sender;
@end

@implementation ChangeDate

- (void)viewDidLoad {
    [super viewDidLoad];
    _textfield.text=_changeDate;
//    //定义修改键
//    UIBarButtonItem *changeDateButton = [[UIBarButtonItem   alloc]initWithTitle:@"确定修改"style:UIBarButtonItemStyleDone target:nil  action:@selector(dissMissModeAction)];
//    self.navigationItem.rightBarButtonItem = changeDateButton;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)Done:(id)sender
{
    if ([_textfield.text length]!=0) {
        NSString *temp=_textfield.text;
        [_list removeObjectAtIndex:[_indexPath row]];
        [_list insertObject:temp atIndex:[_indexPath row]];
    }
    //NSLog(@"%@",_list);
}

//-(void)dissMissModeAction
//{
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
