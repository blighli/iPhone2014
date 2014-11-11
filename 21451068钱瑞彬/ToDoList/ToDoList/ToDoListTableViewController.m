//
//  ToDoListTableViewController.m
//  ToDoList
//
//  Created by apple on 14-11-8.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import "ToDoListTableViewController.h"

#import "AddToDoItemViewController.h"



@interface ToDoListTableViewController ()

@end

@implementation ToDoListTableViewController


// 目标窗体
AddToDoItemViewController* dest = nil;


- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadListData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.toDoItems count];
}

// 设置每一行的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellIdentifier = @"TableViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // 配置每一行
    NSString* toDoItem = [self.toDoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = toDoItem;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

// 选中某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"todolist: didSelectRowAtIndexPath");
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 选中了哪一行, 进行修改
    self.selectedItem = (int)indexPath.row;
    if (dest != nil) {
        dest.text.text = [self.toDoItems objectAtIndex:self.selectedItem];
        dest.barTitle.title = @"Edit To Do Item";
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

// 设置可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 删除一项
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.toDoItems removeObjectAtIndex:indexPath.row];
        [self.toDoItems writeToFile:docPath() atomically:YES];
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}


//获取应用程序沙盒的Documents目录
NSString* docPath() {
    NSArray* pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* path = [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
    return path;
}



// 加载 todolist 的数据
- (void)loadListData {
    NSArray* plist = [NSArray arrayWithContentsOfFile:docPath()];
    
    if(plist) {
        //NSLog(@"hehe");
        self.toDoItems = [plist mutableCopy];
    }
    else {
        self.toDoItems = [[NSMutableArray alloc] init];
    }
    
    if ([self.toDoItems count] == 0) {
        [self.toDoItems addObject:@"添加: 点击右上角 \"+\""];
        [self.toDoItems addObject:@"编辑: 点击我"];
        [self.toDoItems addObject:@"删除: 往左滑动"];
    }
    
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //NSLog(@"todolist: prepareforsegue");
    dest = segue.destinationViewController;
    dest.isNewItem = (sender==self.addItem)? YES: NO; // 添加 or 编辑
}


- (IBAction)unwindSegue:(UIStoryboardSegue *)segue {
    AddToDoItemViewController *source = [segue sourceViewController];
    
    NSString *item = source.toDoItem;
    
    if (item != nil) {
        if (source.isNewItem == YES) { // 添加
            [self.toDoItems addObject:item];
        }
        else { // 编辑
            [self.toDoItems replaceObjectAtIndex:self.selectedItem withObject: item];
        }
        
        // 保存数据, 并重新加载
        [self.toDoItems writeToFile:docPath() atomically:YES];
        [self.tableView reloadData];
    }
}



@end



