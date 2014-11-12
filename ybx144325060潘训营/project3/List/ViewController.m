//
//  ViewController.m
//  List
//
//  Created by CST on 14/11/10.
//  Copyright (c) 2014年 PengCheng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UITableView *output;

@end

@implementation ViewController

NSString *docPath() {
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        tasks = [plist mutableCopy];
    } else {
        tasks = [[NSMutableArray alloc] init];
    }

    [_output setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [_output setDataSource:self];
    [_output setDelegate:self];
    _output.allowsSelection = YES;
   
    [_input setBorderStyle:UITextBorderStyleRoundedRect];
    [_input setPlaceholder:@"Type a task, tap Insert"];
    _input.delegate =self;

}
- (IBAction)insert:(id)sender {
    NSString *text = [_input text];
    if ([text isEqualToString:@""])
    {
        return;
    }
    [tasks addObject: text];
    [_output reloadData];
    [_input setText:@""];
    [_input resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [_output dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    NSString *item = [tasks objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *text = [_input text];
    if ([text isEqualToString:@""])
    {
        [_input becomeFirstResponder];
        _input.text=tasks[indexPath.row];
        return;
    }
    [tasks replaceObjectAtIndex:indexPath.row withObject: text];
    [_output reloadData];
    [_input setText:@""];
    [_input resignFirstResponder];
    
    
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tasks removeObjectAtIndex: indexPath.row];
    [_output reloadData];
    
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView*)tableView moveRowAtIndexPath:(NSIndexPath*)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    
}


@end
