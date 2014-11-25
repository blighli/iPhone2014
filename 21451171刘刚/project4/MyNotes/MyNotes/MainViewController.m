//
//  MainViewController.m
//  MyNotes
//
//  Created by liug on 14-11-15.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import "MainViewController.h"
#import "CreateViewController.h"
#import "EditViewController.h"
NSIndexPath * indexpath;
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tasktable;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    tasklist = [[NSMutableArray alloc] init];
    tasklist2 = [[NSMutableArray alloc] init];
    CreateViewController *cvc=[[CreateViewController alloc]init];
    [cvc openDB];
    [cvc getAllRowsFromTable:@"MyNotes" and:tasklist second:tasklist2];
    [tasktable reloadData]; //表格视图重新载入数据
}
- (void)viewDidLoad
{
    UIBarButtonItem *newNotes=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem=newNotes;
    [super viewDidLoad];
    [tasktable setDataSource:self];
    [tasktable setDelegate:self];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)add{
    CreateViewController *newview=[[CreateViewController alloc]init];
    newview.title=@"CreateNewNotes";
    [self.navigationController pushViewController:newview animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasklist  count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tasktable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasklist objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}
//section显示的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"All Notes";
}
/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        CreateViewController *cvc=[[CreateViewController alloc]init];
        [cvc openDB];
        [cvc deleteRecordfromTableNamed:@"MyNotes" withField1:@"title" field1Value:tasklist[indexPath.row]];
        [tasklist removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        [tasktable deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
    }
}

//设置可编辑的行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexpath=indexPath;
    EditViewController *newview=[[EditViewController alloc]init];
    newview.title=@"EditNotes";
    newview .ttile=tasklist[indexPath.row];
    newview.tnotes=tasklist2[indexPath.row];
    [self.navigationController pushViewController:newview animated:YES];

}
@end
