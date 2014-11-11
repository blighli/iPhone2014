//
//  ViewController.m
//  todolist
//
//  Created by xufei on 14/11/9.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
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
    self.Moding = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonInsert:(id)sender {
    if ([self.taskField.text isEqualToString:@""]) return;
    if (self.Moding) {
        [self.appDelegate.tasks replaceObjectAtIndex:self.Row withObject:self.taskField.text];
        self.Moding = NO;
        [self.insert setTitle:@"Add" forState:UIControlStateNormal];
    } else {
        [self.appDelegate.tasks addObject:self.taskField.text];
    }
    [self.taskTable reloadData];self.taskField.text = @"";
	
    [self.taskField resignFirstResponder];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.appDelegate.tasks removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.taskField.text = [self.appDelegate.tasks objectAtIndex:indexPath.row];
    self.Moding = YES;
    self.Row = indexPath.row;
    [self.insert setTitle:@"modify" forState:UIControlStateNormal];
}

@end

