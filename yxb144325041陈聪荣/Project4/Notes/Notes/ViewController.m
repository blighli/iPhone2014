//
//  ViewController.m
//  Notes
//
//  Created by 陈聪荣 on 14/11/17.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //初始化note类型
    self.tabBarController.delegate = self;
    self.noteBiz = [[NoteBiz alloc]init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadView:)
                                                 name:@"reloadViewNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:nil userInfo:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"选中了%@",viewController.tabBarItem.title);
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.timeListData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString* key = [self.timeListData objectAtIndex:section];
    return [[self.timeDicData objectForKey:key]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"  forIndexPath:indexPath];
    NSString* key = [self.timeListData objectAtIndex:indexPath.section];
    Note* note = [[self.timeDicData objectForKey:key] objectAtIndex:indexPath.row];
    switch (note.type) {
        case 1:
            cell.textLabel.text = note.content;
            break;
        case 2:
            cell.textLabel.text = @"【照片】";
            break;
        case 3:
            cell.textLabel.text = @"【绘图】";
            break;
    }
    cell.detailTextLabel.text = [note.date description];
    return cell;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.timeListData objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString* key = [self.timeListData objectAtIndex:indexPath.section];
        Note* note = [[self.timeDicData objectForKey:key] objectAtIndex:indexPath.row];
        //删除绘图文件
//        if(note.type == 3){
//            NSString* drawFilePath = note.content;
//            NSFileManager* manager = [NSFileManager defaultManager];
//            NSError* error;
//            if([manager removeItemAtPath:drawFilePath error:&error]){
//                NSLog(@"%@",[error description]);
//            }
//        }
        [self.noteBiz remove: note];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadViewNotification" object:nil userInfo:nil];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"add"]) {
        
    }else if([[segue identifier] isEqualToString:@"edit"]){

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString* key = [self.timeListData objectAtIndex:indexPath.section];
        Note* note = [[self.timeDicData objectForKey:key] objectAtIndex:indexPath.row];
        [[segue destinationViewController] setDetailItem:note];
    }
}


-(void)reloadView:(NSNotification*)notification
{
    NSString* selectTypeString = self.parentViewController.tabBarItem.title;
    NSLog(@"%@",selectTypeString);
    self.dicData = [self.noteBiz findAll];
    self.navigationItem.title = selectTypeString;
    self.listData = [self.dicData objectForKey:selectTypeString];
    
    self.timeDicData = [[NSMutableDictionary alloc]init];
    self.timeListData = [[NSMutableArray alloc]init];
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    //将当前tab的note数组按照时间进行分类
    for(Note *note in self.listData){
        NSString* date = [df stringFromDate:note.date];
        if(![self.timeListData containsObject:date]){
            [self.timeListData addObject:date];
            NSMutableArray* tempArray = [[NSMutableArray alloc]init];
            [tempArray addObject:note];
            [self.timeDicData setObject:tempArray forKey:date];
        }else{
            NSMutableArray* tempArray = [self.timeDicData objectForKey:date];
            [tempArray addObject:note];
        }
    }
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

@end
