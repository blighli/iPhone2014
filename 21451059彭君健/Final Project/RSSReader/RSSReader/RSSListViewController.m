//
//  RSSListViewController.m
//  RSSReader
//
//  Created by Mz on 14-12-13.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "RSSListViewController.h"
#import "FeedParserWrapper.h"
#import "SCLAlertView.h"
#import "ActivityIndicator.h"
#import "DAO.h"
#import "EGORefreshTableHeaderView.h"
@interface RSSListViewController ()<UITableViewDataSource, UITableViewDelegate, EGORefreshTableDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) FeedSource *source;
@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeader;
@property (nonatomic) BOOL reloading;
@property (nonatomic) NSInteger currentIndex;
@end

@implementation RSSListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_refreshHeader == nil) {
        CGRect frame = CGRectMake(0.0f, 0.0f - _tableView.bounds.size.height, _tableView.bounds.size.width, _tableView.bounds.size.height);
        _refreshHeader = [[EGORefreshTableHeaderView alloc] initWithFrame:frame];
        _refreshHeader.delegate = self;
        [_tableView addSubview:_refreshHeader];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.title = _source.title;
    _items = [DAO fetchItemsForSource:_source];
}

- (void)viewWillAppear:(BOOL)animated {
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
 
- (IBAction)setAllToRead:(id)sender {
    for (FeedItem *item in _items) {
        item.isRead = @YES;
    }
    [DAO save];
    [_tableView reloadData];
}

- (void)refresh:(void(^)())completion {
    FeedParserWrapper *parser = [[FeedParserWrapper alloc] init];
    [parser parseUrl:[NSURL URLWithString:_source.url]
             timeout:10
          completion:^(int retCode, MWFeedInfo *info, NSArray *items) {
              if (retCode == FeedParseSuccess) {
                  [DAO addItems:items toSource:_source];
                  _items = [DAO fetchItemsForSource:_source];
                  [_tableView reloadData];
              }
              completion();
          }];
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
    [DAO setItemRead:[_items objectAtIndex:_currentIndex]];
    return [_items objectAtIndex:_currentIndex];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    
    _reloading = YES;
    [self refresh:^{
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
