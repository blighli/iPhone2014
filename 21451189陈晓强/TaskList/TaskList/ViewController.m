//
//  ViewController.m
//  TaskList
//
//  Created by 陈晓强 on 14/11/9.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskField;
@property (strong, nonatomic) NSMutableArray *taskList;
@property (nonatomic) NSUInteger row;
@property (strong, nonatomic) NSString *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *plist = [NSArray arrayWithContentsOfFile:[self docPath]];
    if (plist) {
        _taskList = [plist mutableCopy];
    } else {
        _taskList = [[NSMutableArray alloc] init];
    }
//    [_tableView reloadData];
}

- (IBAction)insertControl:(id)sender {
    
    NSString *textFieldVaule = _taskField.text;
    if ([textFieldVaule length]) {
        NSLog(@"sss");
        [_taskList addObject:textFieldVaule];
        _taskField.text = @"";
        [_tableView reloadData];
        [_taskList writeToFile:[self docPath] atomically:YES];
    }
}

-(NSString *)docPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"data1.txt"];
}

#pragma  mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_taskList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    NSString *taskCell = [_taskList objectAtIndex:indexPath.row];
    cell.textLabel.text = taskCell;
    return cell;
}
#pragma mark - Delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_taskList removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:
     UITableViewRowAnimationAutomatic];
    [_taskList writeToFile:[self docPath] atomically:YES];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _row = indexPath.row;
    _textField = [_taskList objectAtIndex:indexPath.row];
 
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"任务修改" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert textFieldAtIndex:0].text = [_taskList objectAtIndex:indexPath.row];
    _row = indexPath.row;
    [alert show];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _row = indexPath.row;
    _textField = [_taskList objectAtIndex:indexPath.row];
}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
            [_taskList replaceObjectAtIndex:_row withObject:[alertView textFieldAtIndex:0].text];
        [_taskList writeToFile:[self docPath] atomically:YES];

            [_tableView reloadData];
    }
}
@end
