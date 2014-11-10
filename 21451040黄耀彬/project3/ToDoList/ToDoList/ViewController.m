//
//  ViewController.m
//  ToDoList
//
//  Created by 黄耀彬 on 14-11-10.
//  Copyright (c) 2014年 黄耀彬. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *fnButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UITextField *edit;
@property (weak, nonatomic) IBOutlet UITableView *taskTable;
@property (strong, nonatomic) NSMutableArray *toDoItems;
@end

NSInteger curEdit;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_taskTable setDataSource:self];
    [_taskTable setDelegate:self];
    self.toDoItems=[[NSMutableArray alloc] init];
    [self loadInitialData];
    [_deleteButton setHidden:TRUE];
    curEdit=0;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)insertAndUpdate:(id)sender {
    UIButton * button= (UIButton *)sender;
    if([button.titleLabel.text isEqualToString:@"添加"])
    {
        [self.toDoItems addObject:_edit.text];
        [_taskTable reloadData];
        [self savePlist];
    }
    else if([button.titleLabel.text isEqualToString:@"修改"])
    {
        [self.toDoItems replaceObjectAtIndex:curEdit withObject:_edit.text];
        [_taskTable reloadData];
        [_fnButton setTitle:@"添加" forState:UIControlStateNormal];
        [self savePlist];
    }
    else if([button.titleLabel.text isEqualToString:@"删除"])
    {
        [self.toDoItems removeObjectAtIndex:curEdit];
        [_taskTable reloadData];
        [_fnButton setTitle:@"添加" forState:UIControlStateNormal];
        [button setHidden:TRUE];
        [self savePlist];
    }
    _edit.text=@"";
}

- (void) loadInitialData
{
    [self readPlist];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.toDoItems count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier=@"ToDoListPrototypeCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text=[self.toDoItems objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString *tappedItem = [self.toDoItems objectAtIndex:indexPath.row];
    _edit.text=tappedItem;
    [_fnButton setTitle:@"修改" forState:UIControlStateNormal];
    [_deleteButton setHidden:FALSE];
    curEdit=indexPath.row;
}

- (void)readPlist
{
    
    NSString *path = [self dataPath];
    self.toDoItems = [NSMutableArray arrayWithContentsOfFile:path];
    
}

- (NSString *) dataPath
{
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)
                             objectAtIndex:0];
    return [documentDir stringByAppendingPathComponent:@"ToDoListSave.plist"];
}

- (void)savePlist
{
    NSString *path = [self dataPath];
    [self.toDoItems writeToFile:path atomically:YES];
}

@end
