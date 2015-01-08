//
//  ViewController.m
//  Homework3
//
//  Created by 李丛笑 on 14/11/9.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import "ViewController.h"
#import "Items.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    NSMutableArray *items;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    items = [NSMutableArray array];
    Items *item1 = [Items itemWithName:@"新建" desc:@""];
    [items addObjectsFromArray:@[item1]];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRows----");
    return items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  NSLog(@"cellForRow---%d", indexPath.row);
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    Items *item = items[indexPath.row];
    
    cell.textLabel.text = item.name;
   
    cell.detailTextLabel.text = item.desc;
    
    
   
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 70;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSLog(@"AAA");
        Items *itemnew = [Items itemWithName:@"新建事件" desc:@""];
        [items addObjectsFromArray:@[itemnew]];
        [_tableView reloadData];
    }
    else{
        Items *item = items[indexPath.row];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"事件编辑" message:nil delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"确定", nil];
        
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        [alert textFieldAtIndex:0].text = item.name;
        
        [alert show];
        
        alert.tag = indexPath.row;

    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"%d",alertView.tag);
        [items removeObjectAtIndex:alertView.tag];
        [_tableView reloadData];
        
    }
    if (buttonIndex == 1)
    {
    NSString *text = [alertView textFieldAtIndex:0].text;
   
    int row = alertView.tag;
    Items *item = items[row];
    item.name = text;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    NSArray *paths = @[indexPath];
    [_tableView reloadRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationLeft];
    }

    }




@end
