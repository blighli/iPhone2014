//
//  ViewController.m
//  homework3
//
//  Created by yingxl1992 on 14/11/7.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [_btn_insert addTarget:self action:@selector(insertTask) forControlEvents:1];
    [_text_insert setDelegate:self];
    [self getDict];
    [self getTasklist];
}

//获取整个plist
-(void)getDict {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tasklist" ofType:@"plist"];
    dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
}

//点击添加按钮触发的事件
-(void)insertTask {
    //设置并保存key-value
    NSString *text=[_text_insert text];
    if ([text compare:@""]!=NSOrderedSame) {
        NSDate *date=[NSDate date];
        NSInteger time=[date timeIntervalSince1970];
        NSString *key=[NSString stringWithFormat:@"%ld",time];
        [dict setValue:text forKey:key];
        
        //写入plist
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tasklist" ofType:@"plist"];
        [dict writeToFile: plistPath atomically:YES];
        
        //刷新数据
        [self refreshData];
        
        [_text_insert setText:@""];
    }    
}

//刷新数据
-(void)refreshData {
    taskdata=nil;
    [self getTasklist];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//设置cell的段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [taskdata count];
}

//设置段中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//设置每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"singlecell" forIndexPath:indexPath];
    cell.textLabel.text=[self getTitleAtIndex:indexPath.section];
    
    //为cell添加长按删除功能
    UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
    [cell addGestureRecognizer:longPressGesture];
    
    return cell;
}

//长按cell触发的事件
-(void)cellLongPress:(UIGestureRecognizer *)recognizer {
    if(recognizer.state==UIGestureRecognizerStateBegan) {
        CGPoint location=[recognizer locationInView:_tableView];
        UITableViewCell *cell=(UITableViewCell *)recognizer.view;
        [cell canBecomeFirstResponder];
        
        NSIndexPath *path=[_tableView indexPathForRowAtPoint:location];
        currentrow=[path section];
        
        UIMenuItem *itDelete=[[UIMenuItem alloc]initWithTitle:@"删除" action:@selector(deleteTask)];
        UIMenuController *menu=[UIMenuController sharedMenuController];
        
        [menu setMenuItems:[NSArray arrayWithObjects:itDelete, nil]];
        [menu setTargetRect:cell.frame inView:self.view];
        [menu setMenuVisible:YES animated:YES];
    }
}

//删除事项
-(void)deleteTask {
    NSString *key=[keylist objectAtIndex:currentrow];
    [dict removeObjectForKey:key];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tasklist" ofType:@"plist"];
    [dict writeToFile: plistPath atomically:YES];
    
    [self refreshData];
}

//获得第index行的数据
-(NSString *)getTitleAtIndex:(NSInteger)index {
        return [taskdata objectAtIndex:index];
}

//获取整个列表的数据
-(void)getTasklist {
    keylist=[dict allKeys];
    keylist = [keylist sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    if(taskdata==nil) {
        taskdata=[[NSMutableArray alloc]init];
    }
    for (NSString *key in keylist) {
        [taskdata addObject:[dict valueForKey:key]];
    }
}

//当点击>后发生
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *task=[self getTitleAtIndex:indexPath.section];
    currentrow=indexPath.section;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"编辑事项" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].text = task;
    [alert show];
    alert.tag = indexPath.row;
}

//设置alertview上按钮的点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==1){
        NSString *text=[[alertView textFieldAtIndex:0] text];
        NSString *key=[keylist objectAtIndex:currentrow];
        
        [dict setValue:text forKey:key];
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tasklist" ofType:@"plist"];
        [dict writeToFile: plistPath atomically:YES];
    }
    [self refreshData];
}

//处理键盘消失
- (BOOL)textFieldShouldReturn:(UITextField *)textField {    
    [textField resignFirstResponder];
    return YES;
}

@end
