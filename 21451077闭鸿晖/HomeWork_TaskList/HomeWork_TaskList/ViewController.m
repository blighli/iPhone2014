//
//  ViewController.m
//  HomeWork_TaskList
//
//  Created by turbobhh on 11/9/14.
//  Copyright (c) 2014 org.bhh.homework. All rights reserved.
//

#import "ViewController.h"
#import "EditViewController.h"
static NSMutableArray* tasks;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    tasks=[[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* taskCell=[tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    UILabel* taskLabel= (UILabel*)[taskCell viewWithTag:0];
    taskLabel.text=[tasks objectAtIndex:indexPath.row];
    return taskCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tasks.count;
}

///删除cell
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tasks removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

#pragma mark delegate
//改变删除按钮tittle
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

#pragma mark myFunction
///插入
- (IBAction)insert:(id)sender {
    if (![self.taskTextField.text isEqual:@""]&&![tasks containsObject:self.taskTextField.text]) {
        [tasks addObject:self.taskTextField.text];
        NSIndexPath* indexPath=[NSIndexPath indexPathForRow:tasks.count-1 inSection:0];
        //插入cell
        [self.taskTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.taskTextField resignFirstResponder];
        //滑动到底部
        [self.taskTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        self.taskTextField.text=nil;
    }

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual:@"EditSegue"]) {
        if ([segue.destinationViewController isKindOfClass:[EditViewController class]]) {
            EditViewController* editVC=segue.destinationViewController;
            editVC.preTaskLabel=(UILabel*)[sender viewWithTag:0];
        } 
    }
}

+(NSArray*)getTasks{
    return tasks;
}
+(void)setTasks:(NSArray*)tasks{
    tasks=tasks;
}

@end
