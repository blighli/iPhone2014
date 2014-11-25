//
//  DrawViewController.m
//  MyNotes
//
//  Created by liug on 14-11-15.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import "DrawViewController.h"
#import "CreateDrawViewController.h"
#import "CreateViewController.h"
#import "EditDrawController.h"
NSIndexPath * indexpath;
@interface DrawViewController ()

@end

@implementation DrawViewController
@synthesize drawtable;
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
    CreateViewController *cvc=[[CreateViewController alloc]init];
    [cvc openDB];
    [cvc createDrawTableNamed:@"MyDraws" withField1:@"path"];
    [cvc getAllRowsFromDraw:@"MyDraws" and:tasklist];
    [drawtable reloadData]; //表格视图重新载入数据
}
- (void)viewDidLoad
{
    UIBarButtonItem *newdraw=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem=newdraw;
    
    [super viewDidLoad];
    [drawtable setDataSource:self];
    [drawtable setDelegate:self];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)add{
    CreateDrawViewController *newview=[[CreateDrawViewController alloc]init];
    newview.title=@"CreateNewDraws";
    [self.navigationController pushViewController:newview animated:YES];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasklist count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [drawtable dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *item = [tasklist objectAtIndex: [indexPath row]];
    [[cell textLabel] setText:item];
    return cell ;
}
//section显示的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"All draws";
}
/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        CreateViewController *cvc=[[CreateViewController alloc]init];
        [cvc openDB];
        [cvc deleteDrawfromTableNamed:@"MyDraws" withField1:@"path" field1Value:tasklist[indexPath.row]];
        [tasklist removeObjectAtIndex:[indexPath row]];  //删除数组里的数据
        [drawtable deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
    }
}

//设置可编辑的行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    indexpath=indexPath;
    EditDrawController *newview=[[EditDrawController alloc]init];
    newview .path=tasklist[indexPath.row];
    [self.navigationController pushViewController:newview animated:YES];
}

@end
