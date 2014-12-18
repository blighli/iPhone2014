//
//  SecondViewController.m
//  RSSReader
//
//  Created by Mz on 14-12-10.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "FavViewController.h"
#import "DAO.h"

@interface FavViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic) NSInteger currentIndex;
@end

@implementation FavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _items = [NSMutableArray arrayWithArray:[DAO fetchFavoriteItems]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    _items = [NSMutableArray arrayWithArray:[DAO fetchFavoriteItems]];
    [_tableView reloadData];
}

- (IBAction)edit:(id)sender {
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    NSString *toEdit = @"编辑", *cancelEdit = @"取消编辑";
    if ([button.title isEqualToString:toEdit]) {
        [button setTitle:cancelEdit];
        [self.tableView setEditing:YES animated:YES];
    } else {
        [button setTitle:toEdit];
        [self.tableView setEditing:NO];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *dest = segue.destinationViewController;
    
    if([segue.identifier isEqualToString:@"itemViewer"]) {
        [dest setValue:self forKey:@"parent"];
    }
}

#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    FeedItem *item = [_items objectAtIndex:indexPath.row];
    if (![item.isRead boolValue]) cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    else cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.summary;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

// 设置可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 移动的操作
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
}

// 删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[_items objectAtIndex:indexPath.row] MR_deleteEntity];
        [_items removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        [DAO save];
    }
}

// 确认删除的字符串
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"确定删除？";
}

// 点击后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _currentIndex = indexPath.row;
    [self performSegueWithIdentifier:@"itemViewer" sender:self];
}

#pragma mark - Select item

- (BOOL)hasNext {
    return _currentIndex < _items.count - 1;
}

- (BOOL)hasPrev {
    return _currentIndex > 0;
}

- (void)selectNext {
    if ([self hasNext]) _currentIndex++;
}

- (void)selectPrev {
    if ([self hasPrev]) _currentIndex--;
}

- (FeedItem *)currentItem {
    return [_items objectAtIndex:_currentIndex];
}

@end
