//
//  ViewController.m
//  project3
//
//  Created by xuyouyang on 14/11/9.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleInput;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITableView *taskTable;
@property (strong, nonatomic) NSMutableArray *tasks;
@end

@implementation ViewController
{
    int editRow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tasks = [[NSMutableArray alloc]init];
    [self readFile];
    [self.taskTable setDataSource:self];
    [self.taskTable setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 添加/修改
- (IBAction)click:(id)sender {
    if ([self.titleInput.text isEqualToString:@""]) {
        [[[UIAlertView alloc] initWithTitle:@"错误" message:@"输入不能为空" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
    } else {
        if ([((UIButton*)sender).titleLabel.text isEqualToString:@"添加"]) {
            // 添加操作
            [self.tasks addObject:self.titleInput.text];
            self.titleInput.text = @"";
        } else {
            // 保存修改
            [self.tasks setObject:self.titleInput.text atIndexedSubscript:editRow];
            self.button.titleLabel.text = @"添加";
            self.titleInput.text = @"";
        }
        [self writeToFile];
        [self.taskTable reloadData];
    }
}

// 设置行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"count:%lu", (unsigned long)self.tasks.count);
    return self.tasks.count;
}

// 点击单元格，进行编辑
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.button.titleLabel.text = @"保存";
    editRow = indexPath.row;
    self.titleInput.text = self.tasks[indexPath.row];
}

// 删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.taskTable deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationTop];
        NSLog(@"%@", self.tasks);
        [self.taskTable reloadData];
        [self writeToFile];
    }
}

// 表格元素
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = self.tasks[indexPath.row];
    return cell;
}

// 读plist文件
- (void)readFile {
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"data.plist"];
    NSLog(@"%@", filePath);
    self.tasks = [NSMutableArray arrayWithContentsOfFile:filePath];
}

// 写plist文件
- (void)writeToFile {
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"data.plist"];
    [self.tasks writeToFile:filePath atomically:YES];
}

@end
