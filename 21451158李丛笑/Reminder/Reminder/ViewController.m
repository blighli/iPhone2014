//
//  ViewController.m
//  Reminder
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
    // 创建数组
    items = [NSMutableArray array];
    
    // 创建数据
    Items *item1 = [Items itemWithName:@"新建" desc:@""];
    Items *item2 = [Items itemWithName:@"first" desc:@"111"];
    
    
    //[items addObjectsFromArray:@[item1,item2]];
    [items addObjectsFromArray:@[item1]];
    [items addObjectsFromArray:@[item2]];

}



#pragma mark 这一组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRows----");
    return items.count;
}

#pragma mark 返回第indexPath这行对应的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRow---%d", indexPath.row);
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    
    // 取出这行对应的产品
    Items *item = items[indexPath.row];
    
    // 产品名称
    cell.textLabel.text = item.name;
    NSLog(@"ddddddd");
    // 产品描述
    cell.detailTextLabel.text = item.desc;
    
    
    // 右边的箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - 代理方法
#pragma mark 返回indexPath这行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    return 70 + indexPath.row * 20;
    return 70;
}

#pragma mark 选中了某一行的cell就会调用
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

#pragma mark - alertview的代理方法
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


//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
