//
//  ViewController.m
//  TodoList
//
//  Created by Devon on 6/11/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import "ViewController.h"
#import "NewTaskViewController.h"
#import "DetailViewController.h"

#define HomePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface ViewController ()

@property(nonatomic, strong) NSMutableArray *tasksArray;

@end

@implementation ViewController

- (NSMutableArray *)tasksArray
{
    if (!_tasksArray) {
        _tasksArray = [NSMutableArray array];
    }
    return _tasksArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    [self.tableView reloadData];
}

- (void)loadData
{
    [self.tasksArray removeAllObjects];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileList = [fm contentsOfDirectoryAtPath:HomePath error:&error];
    
    for (NSString *fileName in fileList) {
        if ([fileName containsString:@".txt"]) {
            int len = (int)fileName.length - 4;
            NSRange range = NSMakeRange(0, len);
            NSString *taskName = [fileName substringWithRange:range];
            
            [self.tasksArray addObject:taskName];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark TableView 方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasksArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = self.tasksArray[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *fileName = [HomePath stringByAppendingPathComponent:[self.tasksArray[indexPath.row] stringByAppendingPathExtension:@"txt"]];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    [fm removeItemAtPath:fileName error:&error];
    
    [self.tasksArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"taskDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSString *name = self.tasksArray[indexPath.row];
        [segue.destinationViewController setTaskName:name];
    }
}

@end
