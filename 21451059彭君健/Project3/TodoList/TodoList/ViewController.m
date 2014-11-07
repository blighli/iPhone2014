//
//  ViewController.m
//  TodoList
//
//  Created by Mz on 14-11-7.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [self.taskTable setDataSource:self];
    [self.taskTable setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonAdd:(id)sender {
    if ([self.taskField.text isEqualToString:@""]) return;
    [self.appDelegate.tasks addObject:self.taskField.text];
    [self.taskTable reloadData];
    self.taskField.text = @"";
    [self.taskField resignFirstResponder];//关闭软键盘
}

- (IBAction)buttonEdit:(id)sender {
    UIButton *button = (UIButton*)sender;
    NSString *toEdit = @"编辑", *cancelEdit = @"取消编辑";
    if ([button.titleLabel.text isEqualToString:toEdit]) {
        [button setTitle:cancelEdit forState:UIControlStateNormal];
        [self.taskTable setEditing:YES animated:YES];
    } else {
        [button setTitle:toEdit forState:UIControlStateNormal];
        [self.taskTable setEditing:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.appDelegate.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [self.appDelegate.tasks objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

// 删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.appDelegate.tasks removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

// 设置可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 移动的操作
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    id object = [self.appDelegate.tasks objectAtIndex:sourceIndexPath.row];
    [self.appDelegate.tasks removeObjectAtIndex:sourceIndexPath.row];
    [self.appDelegate.tasks insertObject:object atIndex:destinationIndexPath.row];
}

// 确认删除的字符串
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"确定删除？";
}

// 点击后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", [self.appDelegate.tasks objectAtIndex:indexPath.row]);
}

@end
