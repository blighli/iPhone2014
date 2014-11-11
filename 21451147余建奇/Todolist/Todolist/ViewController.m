//
//  ViewController.m
//  Todolist
//
//  Created by yjq on 14/11/8.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import "ViewController.h"
#import "ChangeDate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //改变返回键
    UIBarButtonItem *backButton=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem=backButton;
    //定义标题
    UIButton *button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    [button setTitle: @"事物表" forState: UIControlStateNormal];
    [button sizeToFit];
    self.navigationItem.titleView = button;
    //    //定义添加新事件按键
    //    UIBarButtonItem *addDateButton = [[UIBarButtonItem   alloc]initWithTitle:@"添加事件"style:UIBarButtonItemStyleDone target:nil  action:@selector(pushAction)];
    //    self.navigationItem.rightBarButtonItem =addDateButton;
    //将沙盒中的数据文件存入_list中
    NSArray *plist= [NSArray arrayWithContentsOfFile:docPath()];
    if (plist) {
        _list=[plist mutableCopy];
    } else {
        _list=[[NSMutableArray alloc]init];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_list count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier=@"MyCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.text=[_list objectAtIndex:[indexPath indexAtPosition:1]];
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_list removeObjectAtIndex:indexPath.row];
    [_list writeToFile:docPath() atomically:YES];
    [_tableView reloadData];
}

-(void)addtoList:(id)sender
{
    if ([_textfiled.text length]==0) {
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"list不能为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
    }
    else{
        [_list addObject:_textfiled.text];
        [_tableView reloadData];
        [_list writeToFile:docPath() atomically:YES];
        _textfiled.text=@"";
        //NSLog(@"%@",_list);
        //NSLog(@"%@",_textfiled.text);
    }
    //NSLog(@"%@",_list);
}

//界面返回时的操作
-(void)viewDidAppear:(BOOL)animated
{
    [_tableView reloadData];
}

NSString *docPath()
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
    NSString *content=[_list objectAtIndex:[indexPath row]];
    id destination=segue.destinationViewController;
    [destination setValue:content forKey:@"_changeDate"];
    [destination setValue:indexPath forKey:@"indexPath"];
    //[super prepareForSegue:segue sender:sender];
}


-(void)pushAction
{
    if ([_textfiled.text length]==0) {
        UIAlertView *alter=[[UIAlertView alloc]initWithTitle:@"提示" message:@"list不能为空" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alter show];
    }
    else{
        [_list addObject:_textfiled.text];
        [_tableView reloadData];
        _textfiled.text=@"";
        //NSLog(@"%@",_list);
        //NSLog(@"%@",_textfiled.text);
    }
    ChangeDate *push = [[ChangeDate alloc]init];
    [self.navigationController pushViewController:push animated:YES ];
    self.navigationController.delegate=self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textfiled resignFirstResponder];
    return YES;
}


-(IBAction)Cancel:(UIStoryboardSegue *)segue;
{
    
}


@end
