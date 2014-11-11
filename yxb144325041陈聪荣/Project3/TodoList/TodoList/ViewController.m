//
//  ViewController.m
//  TodoList
//
//  Created by 陈聪荣 on 14/11/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navgationItem.rightBarButtonItem = self.editButtonItem;
    self.navgationItem.title = @"备忘录";
    
    self.txtField.hidden = YES;
    self.txtField.delegate = self;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.sharedManager = [TodoDao sharedManager];
    self.list = [self.sharedManager findAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    if(editing){
        self.txtField.hidden = NO;
    }else{
        self.txtField.hidden = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"cellIdentifier";
    BOOL b_addCell = (indexPath.row == self.list.count);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    if(!b_addCell){
        //self.txtField.frame = CGRectMake(10, 8, 300, 35);
        //self.txtField.text = [self.list objectAtIndex:indexPath.row];
        //[cell.contentView addSubview:self.txtField];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [self.list objectAtIndex:indexPath.row];
    }else{
        self.txtField.frame = CGRectMake(10, 8, 300, 35);
        self.txtField.text = @"";
        [cell.contentView addSubview:self.txtField];
    }
    return cell;
}

//单元格编辑图标的指定
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == [self.list count]){
        return UITableViewCellEditingStyleInsert;
    }else{
        return UITableViewCellEditingStyleDelete;
    }
}
//实现删除、插入和编辑处理
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [self.list removeObjectAtIndex:indexPath.row];
        [self.sharedManager saveAll:self.list];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
        [self.list insertObject: self.txtField.text atIndex:[self.list count]];
        [self.sharedManager saveAll:self.list];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }
}
//选中高亮
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == [self.list count]){
        return NO;
    }else{
        return YES;
    }
}
//设置每行单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
//放弃第一响应者，以便于关闭键盘
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//避免遮挡文本框
- (void) textFieldDidBeginEditing:(UITextField *)textField{
    UITableViewCell * cell = (UITableViewCell*)[[textField superview]superview];
    [self.tableView setContentOffset:CGPointMake(0.0, cell.frame.origin.y) animated:YES];
}
@end
