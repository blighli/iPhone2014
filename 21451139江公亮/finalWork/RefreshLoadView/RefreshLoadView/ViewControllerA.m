

#import "ViewControllerA.h"

const int MaxCount = 5;
@interface ViewControllerA ()
{
    int loadCount;
}
@property (nonatomic,strong)CLLRefreshHeadController *refreshControll;
@end

@implementation ViewControllerA

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (CLLRefreshHeadController *)refreshControll {
    if (!_refreshControll) {
        _refreshControll = [[CLLRefreshHeadController alloc] initWithScrollView:self.tableView viewDelegate:self];
    }
    return _refreshControll;
}
#pragma mark-
#pragma mark- CLLRefreshHeadContorllerDelegate
- (CLLRefreshViewLayerType)refreshViewLayerType
{
    return CLLRefreshViewLayerTypeOnSuperView;
}
- (BOOL)keepiOS7NewApiCharacter {
    
    if (!self.navigationController)
        return NO;
    BOOL keeped = [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0;
    return keeped;
}

- (void)beginPullDownRefreshing {
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:3];
}
- (void)beginPullUpLoading
{
    [self performSelector:@selector(endLoadMore) withObject:nil afterDelay:3];
}

//是显示更多
- (BOOL)hasRefreshFooterView {
    if (self.arr.count > 0 && loadCount < MaxCount) {
        return YES;
    }
    return NO;
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.refreshControll startPullDownRefreshing];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"刷新样式一";
    self.arr= [NSMutableArray array];
    loadCount = 0;
    
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)endRefresh {
    loadCount = 0;
    NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:@"圣诞节撒的呢",@"那是你曾经开展农村",@"四川省你擦拭",@"删除MMC卡螺旋藻",@"飒飒大SD卡那是快乐的拉开",@"是你撒看见你的卡死你都看",@"萨达姆拉设计的",@"SD卡三季度",@"dsa9kdkfm",@"上次的事;分开拍151",@"上次的事sasa",@"上次的事sasa",@"上次的事sasa",@"上次的事sasa",@"上次的事sasa",@"上次的事sasa",@"上次的事sasa",@"上次的事sasa",@"上次的事sasa",@"上次的事sasa",@"上次的事sasa",@"上次的事sasa",@"上次的事sasa", nil];
    self.arr = data;
    [self.tableView reloadData];
    
    [self.refreshControll endPullDownRefreshing];
}
- (void)endLoadMore {
    loadCount ++;
    NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"第%d次就加载更多,共%d次",loadCount,MaxCount ],@"更多1",@"更多2",@"更多3", nil];
    [self.arr addObjectsFromArray:data];
    [self.tableView reloadData];
    
    [self.refreshControll endPullUpLoading];
    
}


#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identy = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    NSString *strText = [self.arr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"cell %ld -- %@",(long)indexPath.row,strText];
    return cell;
}

- (void)dealloc {
    self.arr = nil;
    self.tableView = nil;
    self.refreshControll = nil;
}

@end
