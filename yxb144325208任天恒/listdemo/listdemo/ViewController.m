//
//  ViewController.m
//  listdemo
//
//  Created by rth on 14/11/9.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "ViewController.h"
#import "ListItem.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSMutableArray *_items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _items = [[NSMutableArray alloc]initWithCapacity:20];
    
    ListItem *item;
    
    //初始化6个数据
    item = [[ListItem alloc]init];
    item.text =@"测试1";
    item.checked = NO;
    [_items addObject:item];
    
    item = [[ListItem alloc]init];
    item.text =@"测试2";
    item.checked = NO;
    [_items addObject:item];
    
    item = [[ListItem alloc]init];
    item.text =@"测试3";
    item.checked = NO;
    [_items addObject:item];
    
    item = [[ListItem alloc]init];
    item.text =@"测试4";
    item.checked = NO;
    [_items addObject:item];
    
    item = [[ListItem alloc]init];
    item.text =@"测试5";
    item.checked = NO;
    [_items addObject:item];
    
    item = [[ListItem alloc]init];
    item.text =@"测试6";
    item.checked = NO;
    [_items addObject:item];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count];
}


-(void)configureCheckmarkForCell:(UITableViewCell *)cell withListItem:(ListItem *)item{
    
    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    if(item.checked){
        //cell.accessoryType = UITableViewCellAccessoryCheckmark;
        label.text = @"√"; //选择了就标记
        //label.text = @"";
    }else{
        //cell.accessoryType = UITableViewCellAccessoryNone;
        label.text = @"";
    }
    
}

-(void)configureTextForCell:(UITableViewCell *)cell withListItem:(ListItem *)item{
    
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];  //根据label的tag来引用对象
    label.text = item.text;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ListItem"];
    
    
    ListItem *item = _items[indexPath.row];
    
    [self configureTextForCell:cell withListItem:item];
    [self configureCheckmarkForCell:cell withListItem:item];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    ListItem *item = _items[indexPath.row];
    [item toggleChecked];
    
    
    [self configureCheckmarkForCell:cell withListItem:item];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_items removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = @[indexPath];
    
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


//delegate相关方法

-(void)ItemViewControllerDidCancel:(ItemViewController *)controller{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)ItemViewController:(ItemViewController *)controller didFinishAddingItem:(ListItem *)item{
    
    NSInteger newRowIndex = [_items count];
    [_items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)ItemViewcontroller:(ItemViewController *)controller didFinishEditingItem:(ListItem *)item{
    
    NSInteger index = [_items indexOfObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configureTextForCell:cell withListItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"Add"]){
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        ItemViewController *controller = (ItemViewController*) navigationController.topViewController;
        
        controller.delegate = self;
    } else if([segue.identifier isEqualToString:@"Edit"]){
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        ItemViewController *controller = (ItemViewController*) navigationController.topViewController;
        
        controller.delegate = self;
        
        NSIndexPath * indexPath = [self.tableView indexPathForCell:sender];
        
        controller.itemToEdit = _items[indexPath.row];
        
    }

}


@end
