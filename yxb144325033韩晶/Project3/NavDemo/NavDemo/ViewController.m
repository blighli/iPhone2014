//
//  ViewController.m
//  NavDemo
//
//  Created by hanxue on 14/11/17.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#import "ViewController.h"
#import "detail.h"
#import "PaintView.h"
#import "AddViewController.h"

@interface ViewController ()
{
    UITableView *tableView;
    BOOL isEdit;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSArray *list = [NSArray arrayWithObjects:@"武汉",@"上海",@"北京",@"深圳",@"广州",@"重庆",@"香港",@"台海",@"天津", nil];
    NSMutableArray *list=[[NSMutableArray alloc] init];
    [list addObject:@"first"];
    [list addObject:@"secound"];
    [list addObject:@"third"];
    self.dataList=list;
    
    tableView=[[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource=self;
    tableView.delegate=self;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    tableView.allowsSelection=YES;
    tableView.allowsSelectionDuringEditing=YES;
    
    
    self.myTableView=tableView;
    [self.view addSubview:self.myTableView];
    
    UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editItem:)];
    self.navigationItem.leftBarButtonItem=leftButton;
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItem=rightButton;
    
    isEdit=YES;
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void) editItem:(id)sender{
    if (isEdit) {
        [self.myTableView setEditing:YES animated:YES];
        UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editItem:)];
        self.navigationItem.leftBarButtonItem=leftButton;
        isEdit=NO;
    }else{
        [self.myTableView setEditing:NO animated:YES];
        UIBarButtonItem *leftButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editItem:)];
        self.navigationItem.leftBarButtonItem=leftButton;
        isEdit=YES;
    }
}

-(void) addItem:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add New"
                                                    message:@""
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"文字",@"手写",nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self pushAddWrite];
            break;
        case 2:
            [self pushHandWrite];
            break;
        default:
            break;
    }
}

-(void)pushAddWrite{
    AddViewController *add=[[AddViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}

-(void)pushHandWrite{
    PaintViewController *paint=[[PaintViewController alloc] init];
    [self.navigationController pushViewController:paint animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cellid=@"cell";
    UITableViewCell *cell=[self.myTableView dequeueReusableCellWithIdentifier:Cellid];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellid];
    }
    NSUInteger row=[indexPath row];
    cell.textLabel.text=[self.dataList objectAtIndex:row];
    cell.selectedBackgroundView=[[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=[UIColor colorWithRed:0/255.0 green:122/255.0 blue:255/255.0 alpha:0.5];
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataList count];
}
//点击操作
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
    Detailview *detail=[[Detailview alloc] init];
    detail.identify=indexPath.row;
    [self.navigationController pushViewController:detail animated:YES];
}

//实现滑动删除数据;
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.dataList removeObjectAtIndex:[indexPath row]];
        [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        //[taskTable reloadData];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete!";
}

//实现tableView调整


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
//这个方法用来告诉表格 这一行是否可以移动
-(BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//执行移动操作

-(BOOL) tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSUInteger fromRow=[sourceIndexPath row];
    NSUInteger toRow=[destinationIndexPath row];
    
    id object=[self.dataList objectAtIndex:fromRow];
    [self.dataList removeObjectAtIndex:fromRow];
    [self.dataList insertObject:object atIndex:toRow];
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
