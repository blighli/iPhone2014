//
//  FirstViewController.m
//  RSSReader
//
//  Created by Mz on 14-12-10.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "HomeViewController.h"
#import "SCLAlertView/SCLAlertView.h"
#import "ActivityIndicator.h"
#import "FeedParserWrapper.h"
#import "DAO.h"
#import "EGORefreshTableHeaderView.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, EGORefreshTableDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeader;
@property (nonatomic, strong) NSMutableArray *sources;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic) BOOL isEditing;
@property (nonatomic) BOOL reloading;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (_refreshHeader == nil) {
        CGRect frame = CGRectMake(0.0f, 0.0f - _tableView.bounds.size.height, _tableView.bounds.size.width, _tableView.bounds.size.height);
        _refreshHeader = [[EGORefreshTableHeaderView alloc] initWithFrame:frame];
        _refreshHeader.delegate = self;
        [_tableView addSubview:_refreshHeader];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _sources = [NSMutableArray arrayWithArray:[DAO fetchSources]];
    if (!_sources) _sources = [NSMutableArray array];
    [[ActivityIndicator sharedInstance] start:self];
    [self refresh:^{
        [[ActivityIndicator sharedInstance] stop];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Button Actions
- (IBAction)add:(id)sender {
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    UITextField *textTitle = [alert addTextField:@"标题（可选）"];
    UITextField *textURL = [alert addTextField:@"URL（网址或feed）"];
    [alert addButton:@"确定" actionBlock:^{
        NSLog(@"title: %@, url: %@", textTitle.text, textURL.text);
        NSString *urlstring = textURL.text;
        if (![urlstring hasPrefix:@"http://"] && ![urlstring hasPrefix:@"feed://"]) {
            urlstring = [NSString stringWithFormat:@"http://%@", urlstring];
        }
        NSURL *feedURL = [NSURL URLWithString:urlstring];
        FeedParserWrapper *parser = [[FeedParserWrapper alloc] init];
        [parser parseUrl:feedURL
                 timeout:10
              completion:^(int retCode, MWFeedInfo *info, NSArray *items) {
                  if (retCode == FeedParseSuccess) {
                      NSString *title = [textTitle.text isEqualToString:@""] ? info.title : textTitle.text;
                      FeedSource *source = [DAO addSourceWithTitle:title andUrl:info.url];
                      if (source == nil) [self showError:@"该数据源已经存在！"];
                      else {
                          [self showSuccess:info.title];
                          [DAO addItems:items toSource:source];
                          [_sources addObject:source];
                          [_tableView reloadData];
                      }
                  } else if (retCode == FeedParseFailed) {
                      [self showError:@"网络异常或地址无法解析"];
                  } else if (retCode == FeedParseTimeout) {
                      [self showError:@"解析超时"];
                  }
                  [[ActivityIndicator sharedInstance] stop];
              }];
        [[ActivityIndicator sharedInstance] start:self.tabBarController];
    }];
    [alert showEdit:self.tabBarController
              title:@"添加RSS源"
           subTitle:@"请输入网址或feed"
   closeButtonTitle:@"取消"
           duration:0.0f];
}

- (IBAction)edit:(id)sender {
    UIBarButtonItem *button = (UIBarButtonItem*)sender;
    NSString *toEdit = @"编辑", *cancelEdit = @"取消编辑";
    if ([button.title isEqualToString:toEdit]) {
        [button setTitle:cancelEdit];
        [self.tableView setEditing:YES animated:YES];
        [_addButton setEnabled:NO];
    } else {
        [button setTitle:toEdit];
        [self.tableView setEditing:NO];
        [_addButton setEnabled:YES];
    }
}

- (void)refresh:(void(^)())completion {
    if (_sources == nil || _sources.count == 0) {
        completion();
        return;
    }
    int __block count = 0;
    for (FeedSource *source in _sources) {
        FeedParserWrapper *parser = [[FeedParserWrapper alloc] init];
        FeedSource *tmp_source = source;
        [parser parseUrl:[NSURL URLWithString:source.url]
                 timeout:10
              completion:^(int retCode, MWFeedInfo *info, NSArray *items) {
                  if (retCode == FeedParseSuccess) {
                      [DAO addItems:items toSource:tmp_source];
                      [_tableView reloadData];
                  }
                  if (++count == _sources.count) {
                      completion();
                  }
              }];
    }
}

#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    FeedSource *source = [_sources objectAtIndex:indexPath.row];
    NSInteger unreadCount = [DAO countUnreadItemsForSource:source];
    if (unreadCount > 0) cell.textLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    else cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%ld 未读)", source.title, unreadCount];
    cell.detailTextLabel.text = source.url;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

// 设置可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 移动的操作
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    FeedSource *source = [_sources objectAtIndex:sourceIndexPath.row];
    FeedSource *dest = [_sources objectAtIndex:destinationIndexPath.row];
    [_sources removeObjectAtIndex:sourceIndexPath.row];
    [_sources insertObject:source atIndex:destinationIndexPath.row];
    id tmp = source.addTime;
    source.addTime = dest.addTime;
    dest.addTime = tmp;
    [DAO save];
}

// 删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[_sources objectAtIndex:indexPath.row] MR_deleteEntity];
        [_sources removeObjectAtIndex:indexPath.row];
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
    [self performSegueWithIdentifier:@"RSSList" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *dest = segue.destinationViewController;
    
    if([segue.identifier isEqualToString:@"RSSList"]) {
        [dest setValue:[_sources objectAtIndex:_currentIndex] forKey:@"source"];
    }
}

#pragma mark - Notice

- (void)showError:(NSString *)message {
    SCLAlertView *notice = [[SCLAlertView alloc] init];
    [notice showError:self.tabBarController
                title:@"错误"
             subTitle:message
     closeButtonTitle:@"确定"
             duration:0.0f];
}

- (void)showSuccess:(NSString *)message {
    SCLAlertView *notice = [[SCLAlertView alloc] init];
    [notice showSuccess:self.tabBarController
                  title:@"添加成功"
               subTitle:message
       closeButtonTitle:@"确定"
               duration:0.0f];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    _reloading = YES;
    [self refresh:^(){
        [self doneLoadingTableViewData];
    }];
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeader egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [_refreshHeader egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [_refreshHeader egoRefreshScrollViewDidEndDragging:scrollView];
    
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos {
    [self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView *)view {
    return _reloading; // should return if data source model is reloading
}

-(NSDate *)egoRefreshTableDataSourceLastUpdated:(UIView *)view {
    return [NSDate date]; // should return date data source was last changed
}

@end