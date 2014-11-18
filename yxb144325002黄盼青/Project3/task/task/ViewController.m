//
//  ViewController.m
//  task
//
//  Created by 黄盼青 on 14/11/5.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //    self.tasks=[[NSMutableArray alloc]init];
    //    [self.tasks addObject:@"你好"];
    //    [self.tasks addObject:@"我是任务"];
    [self readDataFromFile];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.taskTable reloadData];
    [super viewWillAppear:animated];
}

//从Plist文件中读取数据
-(void)readDataFromFile{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[path objectAtIndex:0];
    NSString *dataFilePath=[documentPath stringByAppendingPathComponent:@"taskData.plist"];
    NSMutableDictionary *dataFile=[[NSMutableDictionary alloc]initWithContentsOfFile:dataFilePath];
    
    
    if(!dataFile)
    {
        self.tasks=[[NSMutableArray alloc]init];
    }else
    {
        self.tasks=[dataFile objectForKey:@"tasks"];
    }
}

//写入数据到Plist文件中
-(void)writeDataToFile{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[path objectAtIndex:0];
    NSString *dataFilePath=[documentPath stringByAppendingPathComponent:@"taskData.plist"];
    NSMutableDictionary *dataFile=[[NSMutableDictionary alloc]initWithContentsOfFile:dataFilePath];
    
    if(!dataFile)
    {
        dataFile=[[NSMutableDictionary alloc]init];
    }
    
    [dataFile setObject:self.tasks forKey:@"tasks"];
    [dataFile writeToFile:dataFilePath atomically:YES];
    
}

//返回数据源个数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return [self.tasks count];
}


//绑定数据源
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CELL_INDETIFI=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CELL_INDETIFI];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_INDETIFI];
    }
    cell.textLabel.text=self.tasks[indexPath.row];
    return cell;
}


//通过Segue传递当前所选Cell
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"editTask" sender:indexPath];
}

//通过Segue传递对象
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender{
    UIViewController *destination=segue.destinationViewController;
    destination=[segue.destinationViewController topViewController];
    
    
    if([segue.identifier isEqualToString:@"editTask"])
    {
        [destination setValue:sender forKey:@"taskIndex"];
    }
    [destination setValue:self forKey:@"delegate"];
}

//滑动删除
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.taskTable reloadData];
    }
    [self writeDataToFile];//保存修改
}

//修改滑动删除提示文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
@end
