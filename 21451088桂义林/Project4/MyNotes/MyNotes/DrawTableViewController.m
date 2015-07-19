//
//  DrawNotesViewController.m
//  MyNotes
//
//  Created by YilinGui on 14-11-22.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import "DrawTableViewController.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Note.h"
#import "AddDrawViewController.h"
#import "EditDrawViewController.h"

@interface DrawTableViewController ()

@end

@implementation DrawTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor redColor];
    // 设置导航栏标题
    self.navigationItem.title = @"Draw Notes";
    
    // 为导航栏添加一个右侧的Button Item
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(AddDrawNotes)];
    self.navigationItem.rightBarButtonItem = item;
    
    // 初始化TableView
    drawTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 360, self.view.frame.size.height - 44) style:UITableViewStylePlain];
    
    [self.view addSubview:drawTableView];
    [drawTableView setDataSource:self];    // 为UITableView设置数据源
    [drawTableView setDelegate:self];
    
    // 从数据库中读取所有type属性为"draw"的记录
    drawNotes = [[NSMutableArray alloc] initWithArray:[Note MR_findByAttribute:@"type" withValue:@"draw"]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 从数据库中读取所有type属性为"draw"的记录
    drawNotes = [[NSMutableArray alloc] initWithArray:[Note MR_findByAttribute:@"type" withValue:@"draw"]];
    [drawTableView reloadData];  // 重新加载TableView上的数据
}

// 设置TableView的section数量，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 设置TableView每个section的row数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [drawNotes count];
}

// 设置TableView上每个row上的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";  // cell的重用标识
    
    // 从队列中取出对应重用标识的cell对象
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    // 如果没有对应的cell对象，初始化
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    Note *note = drawNotes[indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    // 设置cell上的文字
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = [dateFormatter stringFromDate: note.date];
    
    // 设置cell上的图片
    NSString* imageDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *imageFilePath = [imageDirPath stringByAppendingString:note.message];
    cell.imageView.image = [UIImage imageWithContentsOfFile:imageFilePath];
    
    return cell;
}

// 选中TableView中的某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"section = %ld, row = %ld", indexPath.section, indexPath.row);
    EditDrawViewController *editDrawVC = [[EditDrawViewController alloc] init];
    Note *note = [drawNotes objectAtIndex:[indexPath row]];
    [editDrawVC passNote:note];
    [self.navigationController pushViewController:editDrawVC animated:YES];
}

// 删除TableView中的一行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *note = [drawNotes objectAtIndex:indexPath.row];
        
        // 删除对应的图片文件
        NSString* imageDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *imageFilePath = [imageDirPath stringByAppendingString:note.message];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSError *err;
        [fileMgr removeItemAtPath:imageFilePath error:&err];
        
        [note MR_deleteEntity];  // 从数据库中删除记录
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        // 从数据库中读取所有type属性为"draw"的记录
        drawNotes = [[NSMutableArray alloc] initWithArray:[Note MR_findByAttribute:@"type" withValue:@"draw"]];
        [drawTableView reloadData];  // 重新加载TableView上的数据
    }
}

// 事件响应函数 -- 添加手绘笔记
- (void)AddDrawNotes {
    AddDrawViewController *addDrawVC = [[AddDrawViewController alloc] init];
    [self.navigationController pushViewController:addDrawVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
