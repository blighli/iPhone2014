//
//  ViewController.m
//  TaskList
//
//  Created by 周翔 on 14/11/10.
//  Copyright (c) 2014年 周翔. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    
 NSMutableArray *tasks;
    
 NSIndexPath *cnt;
    
}


NSString *docPath(){
    NSArray *pathlist = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[pathlist objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks = [plist mutableCopy];
    }
    else{
        tasks = [[NSMutableArray alloc] init];
    }
    
    tasks = [[NSMutableArray alloc] init];
    [self.taskTable setDataSource:self];
    [self.taskTable setDelegate:self];
    
    if([tasks count]==0){
        [tasks addObject:@"Walk"];
        [tasks addObject:@"Run"];
        [tasks addObject:@"Back"];
        
    }
    
    UITextField *taskField = [[UITextField alloc] init];
    [self.taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.taskField setPlaceholder:@"Type a task,tap Insert"];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [tasks count];
    
}

-(UITableView *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.taskTable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return cell;
    
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tasks removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    cnt = indexPath;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改" message:@"确认修改？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

-(IBAction) insertButton:(id)sender{
    NSString *text = [self.taskField text];
    if([text isEqualToString:@""]){
        return;
    }
    [tasks addObject:text];
    [self.taskTable reloadData];
    [self.taskField setText:@""];
    [self.taskField resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
