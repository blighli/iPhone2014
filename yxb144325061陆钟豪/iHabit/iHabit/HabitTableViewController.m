//
//  HabitTableViewController.m
//  iHabit
//
//  Created by 陆钟豪 on 14/12/3.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "HabitTableViewController.h"
#import "Habit.h"
#import "HabitTableViewCell.h"
#import "HabitTableCellViewController.h"
#import "CellActionView.h"
#import "HabitBiz.h"
#import "AddHabitViewController.h"
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "HabitBaseViewController.h"

@interface HabitTableViewController ()

@end

@implementation HabitTableViewController{
    HabitBiz* _habitBiz;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if(self.tableView.contentOffset.y <= -150) {
//        CATransition *animation = [CATransition animation];
//        animation.delegate = self;
//        animation.duration = 0.7;
//        animation.timingFunction = UIViewAnimationCurveEaseInOut;
//        animation.type = @"cube";
//        animation.subtype = kCATransitionFromBottom;
//        [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
//        [self.navigationController pushViewController:[[AddHabitViewController alloc] initWithNibName:@"AddHabitViewController" bundle:nil] animated:NO];
//    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(self.tableView.contentOffset.y <= -150) {
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.7;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"cube";
        animation.subtype = kCATransitionFromBottom;
        [[self.navigationController.view layer] addAnimation:animation forKey:@"animation"];
        [self.navigationController pushViewController:[[HabitBaseViewController alloc] initWithViewController:[[AddHabitViewController alloc] initWithNibName:@"AddHabitViewController" bundle:nil]] animated:NO];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 隐藏分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //这个标准默认为YES，如果设置为NO，这消息一旦传递给subView，这scroll事件不会再发生。
    self.tableView.canCancelContentTouches = NO;
    //这个标志默认是YES，使用上面的150ms的timer，如果设置为NO，touch事件立即传递给subView，不会有150ms的等待。
    self.tableView.delaysContentTouches = NO;
    UIView* tableHeader = [[CellActionView alloc] initWithFrame:CGRectMake(0, -200, 320, 200)];
    
    tableHeader.backgroundColor = UIColor.blueColor;
    
    self.tableView.delegate = self;
    
    _habitBiz = [HabitBiz getInstance];
    [self.tableView addSubview:tableHeader];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_habitBiz.habitArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"HabitCell";
    HabitTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[HabitTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        HabitTableCellViewController *habitTableCellViewController = [[HabitTableCellViewController alloc] init];
        habitTableCellViewController.view = cell;
        [habitTableCellViewController viewDidLoad];
        [self addChildViewController:habitTableCellViewController];
    }
    NSInteger index = [indexPath row];
    Habit *habit = [_habitBiz.habitArray objectAtIndex:index];
    cell.habit = habit;//刷新
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 设置单元格高度
    return 80;
}

@end
