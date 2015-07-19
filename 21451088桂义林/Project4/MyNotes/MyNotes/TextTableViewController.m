//
//  ViewController.m
//  MyNotes
//
//  Created by YilinGui on 14-11-22.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import "TextTableViewController.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Note.h"
#import "AddTextNoteViewController.h"
#import "EditTextNoteViewController.h"

@interface TextTableViewController ()

@end

@implementation TextTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 设置导航栏标题
    self.navigationItem.title = @"Text Notes";
    
    // 为导航栏添加一个右侧的Button Item
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTextNotes)];
    self.navigationItem.rightBarButtonItem = item;
    
    // 初始化TableView
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 360, self.view.frame.size.height - 44) style:UITableViewStylePlain];
    
    [self.view addSubview:myTableView];
    [myTableView setDataSource:self];    // 为UITableView设置数据源
    [myTableView setDelegate:self];
    
    // 从数据库中读取所有type属性为"text"的记录
    textNotes = [[NSMutableArray alloc] initWithArray:[Note MR_findByAttribute:@"type" withValue:@"text"]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 从数据库中读取所有type属性为"text"的记录
    textNotes = [[NSMutableArray alloc] initWithArray:[Note MR_findByAttribute:@"type" withValue:@"text"]];
    [myTableView reloadData];  // 重新加载TableView上的数据
}

// 设置TableView的section数量，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 设置TableView每个section的row数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [textNotes count];
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
    
    Note *note = textNotes[indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    // 设置cell上的文字
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = [dateFormatter stringFromDate: note.date];
    
    // 设置cell上的图片
    //cell.imageView.image = [UIImage imageNamed:@"batman_head1.jpg"];
    
    return cell;
}

// 选中TableView中的某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"section = %ld, row = %ld", indexPath.section, indexPath.row);
    EditTextNoteViewController *editTextNoteVC = [[EditTextNoteViewController alloc] init];
    Note *note = [textNotes objectAtIndex:[indexPath row]];
    [editTextNoteVC passNote:note];
    [self.navigationController pushViewController:editTextNoteVC animated:YES];
}

// 删除TableView中的一行
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *note = [textNotes objectAtIndex:indexPath.row];
        [note MR_deleteEntity];  // 从数据库中删除数据
        [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
        // 从数据库中读取所有type属性为"text"的记录
        textNotes = [[NSMutableArray alloc] initWithArray:[Note MR_findByAttribute:@"type" withValue:@"text"]];
        [myTableView reloadData];  // 重新加载TableView上的数据
    }
}

// 事件响应函数 -- 添加文本笔记
- (void)addTextNotes {
    AddTextNoteViewController *addTextNoteVC = [[AddTextNoteViewController alloc] init];
    [self.navigationController pushViewController:addTextNoteVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
