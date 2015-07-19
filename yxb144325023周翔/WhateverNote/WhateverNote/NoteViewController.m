//
//  NoteViewController.m
//  WhateverNote
//
//  Created by 周翔 on 14/11/26.
//  Copyright (c) 2014年 周翔. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()
@property (weak, nonatomic) IBOutlet UITextField *noteInsert;
@property (weak, nonatomic) IBOutlet UITableView *noteText;
- (IBAction)insertNote:(id)sender;

@end

@implementation NoteViewController{
    NSMutableArray *noteTasks;
    NSIndexPath *cnt;
    
}

NSString *docPath(){
    NSArray *pathlist = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [[pathlist objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        noteTasks = [plist mutableCopy];
    }
    else{
        noteTasks = [[NSMutableArray alloc] init];
    }
    
    noteTasks = [[NSMutableArray alloc] init];
    [self.noteText setDataSource:self];
    [self.noteText setDelegate:self];
    
    if([noteTasks count]==0){
        [noteTasks addObject:nil];
        
    }
    
    UITextField *noteInsert = [[UITextField alloc] init];
    [self.noteInsert setBorderStyle:UITextBorderStyleRoundedRect];
    [self.noteInsert setPlaceholder:@"Insert Note"];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [noteTasks count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.noteText dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [noteTasks objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:item];
    return cell;
    
}


-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [noteTasks removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    cnt = indexPath;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"修改Note" message:@"确认修改？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

-(IBAction) insertNote:(id)sender{
    NSString *text = [self.noteInsert text];
    if([text isEqualToString:@""]){
        return;
    }
    [noteTasks addObject:text];
    [self.noteText reloadData];
    [self.noteInsert setText:@""];
    [self.noteInsert resignFirstResponder];
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
