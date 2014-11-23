//
//  ViewController.m
//  TaskList
//
//  Created by lixu on 14/11/8.
//  Copyright (c) 2014年 lixu. All rights reserved.
//


#import "TLViewController.h"
@interface TLViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@end

@implementation TLViewController
@synthesize taskField;
@synthesize taskTable;

NSString *docPath()
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    return  [path stringByAppendingPathComponent:@"data.plist"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * plist=[NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks=[plist mutableCopy];
    }else{
        tasks=[[NSMutableArray alloc] init];
    }
    
    [taskTable setDataSource:self];
    [taskTable setDelegate:self];
    
    if ([tasks count]==0) {
        [tasks addObject:@"Walk the dogs"];
        [tasks addObject:@"Feed the hogs"];
        [tasks addObject:@"Chop the logs"];
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRows----");
    return tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRow---%ld", (long)indexPath.row);
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    NSString *item=tasks[indexPath.row];
    cell.textLabel.text = item;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        NSLog(@"%ld",(long)indexPath.row)  ;
        [tasks removeObjectAtIndex:[indexPath row]];
        [tasks writeToFile:docPath() atomically:YES];
        [taskTable deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationTop];
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"this is %ld row",(long)indexPath.row);
    NSString *string=tasks[indexPath.row];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改该项" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].text = string;
    [alert show];
    alert.tag = indexPath.row;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) return;
    
    NSString *test=[alertView textFieldAtIndex:0].text;
    [tasks replaceObjectAtIndex:alertView.tag withObject:test];
    [tasks writeToFile:docPath() atomically:YES];
    [taskTable reloadData];
    
}

- (IBAction)addTask:(id)sender {
    NSString *text=[taskField text];
    if ([text isEqualToString:@""]) {
        return;
    }
    [tasks addObject:text];
    [tasks writeToFile:docPath() atomically:YES];
    [taskTable reloadData];
    [taskField setText:@""];
    [taskField resignFirstResponder];
    
}

@end
