//
//  ViewController.m
//  SimpleTasklist
//
//  Created by lzx on 14/11/7.
//  Copyright (c) 2014年 lzx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
NSMutableArray * tasks;
NSIndexPath * location;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tasks = [[NSMutableArray alloc] initWithObjects:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)insertAction:(UIButton *)sender {
    NSString * string = [[NSString alloc] initWithString:self.textfield.text];
    [tasks addObject:string];
    self.textfield.text = @"";
    [self.textfield resignFirstResponder];
    [self.mytableview reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indefinder = @"indefinder";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indefinder];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indefinder];
    }
    cell.textLabel.text = tasks[indexPath.row];
    
    return  cell;
    
}

-(NSString *)docPath
{
    NSArray * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    location = indexPath;
    UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"修改选中的行内容" message:@" " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改", nil];
    alertview.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertview show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        UITextField * tmpfield = [alertView textFieldAtIndex:0];
        tasks[location.row] = tmpfield.text;
        [self.mytableview reloadData];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tasks removeObjectAtIndex:indexPath.row];
    [self.mytableview reloadData];
}
@end
