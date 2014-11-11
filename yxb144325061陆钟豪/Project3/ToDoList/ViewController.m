//
//  ViewController.m
//  ToDoList
//
//  Created by 陆钟豪 on 14/11/8.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.tasks = [[NSMutableArray alloc] init];// 注：属性可做左值
    [self loadTaskList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
          cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) // 回收双端队列中没有元素，新建元素
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    cell.textLabel.text = self.tasks[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"taskSegue" sender:self.tasks[indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController *destination = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"taskSegue"])
        [destination setValue:sender forKeyPath:@"task"];
    else
        destination = [segue.destinationViewController
                       topViewController];
    [destination setValue:self forKeyPath:@"delegate"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        [self saveTaskList];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}

- (void)saveTaskList {
    NSString* taskListFileName = [self getTaskListFileName];
    [self.tasks writeToFile:taskListFileName atomically:YES];
}

- (void)loadTaskList {
    NSString* taskListFileName = [self getTaskListFileName];
    self.tasks = [[NSMutableArray alloc] initWithContentsOfFile:taskListFileName];
    if(self.tasks == nil) {
        self.tasks = [NSMutableArray new];
        [self.tasks addObject:@"have a meeting"];
        [self.tasks addObject:@"walk the dog"];
        [self.tasks addObject:@"dinner"];
    }
}

- (NSString*)getTaskListFileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"task_list.plist"];
}

@end
