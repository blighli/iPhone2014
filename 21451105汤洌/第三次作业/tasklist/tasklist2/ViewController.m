//
//  ViewController.m
//  tasklist2
//
//  Created by tanglie1993 on 14/11/9.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


NSIndexPath * tmp;
@implementation ViewController


NSMutableArray *tasks;
 

NSString *docPath() {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    tasks = [[NSMutableArray alloc] init];
    [self.taskTable setDataSource:self];
    [self.taskTable setDelegate:self];
    if ([tasks count] == 0) {
        [tasks addObject:@"a"];
        [tasks addObject:@"b"];
        [tasks addObject:@"c"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}

- (IBAction)insertButton:(id)sender {
    NSString *text = [self.taskField text]; 
    if ([text isEqualToString:@""]) {
        return; 
    }
    [tasks addObject: text]; 
    [self.taskTable reloadData]; 
    [self.taskField setText:@""]; 
    [self.taskField resignFirstResponder]; 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell )
    {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tasks removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.taskField.text=[tasks objectAtIndex:indexPath.row];
    tmp =indexPath;
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"修改" message:@"您确定要修改吗"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        
        UITextField *tf=[alertView textFieldAtIndex:0];
        NSString *editText=[tf text];
        tasks[tmp.row] = editText;
        [self.taskTable reloadData];
        [self.taskField setText:@""];
        [self.taskField resignFirstResponder];
    }
}


@end
