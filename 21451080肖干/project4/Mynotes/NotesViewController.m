//
//  NotesMasterViewController.m
//  Notes
//
//  Created by xiaoo_gan on 11/25/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "NotesViewController.h"

#import "NotesDetailViewController.h"
#import "NoteDataSource.h"
#import "NoteData.h"

@interface NotesViewController ()

@end

@implementation NotesViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //编辑列表按钮
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
//    [self.navigationItem.leftBarButtonItem setTitle:@"编辑"];
//    
//    if ([self.navigationItem.leftBarButtonItem.title isEqualToString:@"Edit"]) {
//        [self.navigationItem.leftBarButtonItem setTitle:@"编辑"];
//    } else if([self.navigationItem.leftBarButtonItem.title isEqualToString:@"Done"]){
//        [self.navigationItem.leftBarButtonItem setTitle:@"完成"];
//    }
    
    //根据表格单元个数设置背景色
    if ([[NoteDataSource sharedInstance] noteCount]%2 == 1) {
        self.tableView.backgroundColor = [UIColor colorWithRed:243.0/255 green:243.0/255 blue:243.0/255 alpha:1];
    } else {
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated]; 
}
// 自动旋转屏幕
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIDeviceOrientationPortrait);
}

#pragma mark - Table View
//  表格列数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//表格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[NoteDataSource sharedInstance] noteCount];
}

//单元格内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell"];
    NoteData *note = [[NoteDataSource sharedInstance] getNoteAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", [note title], [note labelsString]];
    cell.detailTextLabel.text = [note dateString];
    cell.imageView.image = [UIImage imageNamed:@"star.png"];
    return cell;
}

//设置表格单元灰白相间
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:243.0/255 green:243.0/255 blue:243.0/255 alpha:1];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer_view = [[UIView alloc] init];
    return footer_view;    
}

//去除表格线
- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
//列表可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//编辑列表
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //删除选中列
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[NoteDataSource sharedInstance] removeNoteAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//segue处理
#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //查看选中记事
    if ([[segue identifier] isEqualToString:@"showNoteDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NoteData *note = [[NoteDataSource sharedInstance] getNoteAtIndex:indexPath.row];
        [[segue destinationViewController] setNote:note];
    }
}
@end
