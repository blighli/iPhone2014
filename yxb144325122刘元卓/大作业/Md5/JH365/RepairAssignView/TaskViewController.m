#import "TaskViewController.h"

@implementation TaskViewController

@synthesize unFinishViewController,finishViewController,allViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // 创建一个导航栏
    UINavigationBar *navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    // 改变显示风格
    navigationBar.barStyle = UIBarStyleBlackTranslucent;
    // 创建一个导航栏集合
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"任务"];
    // 添加右侧 刷新功能 按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(clickRightButton)];
    // 把按钮添加到导航栏集合中
    [navigationItem setRightBarButtonItem:rightButton];
    // 把导航栏集合添加到导航栏中
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    // 显示导航栏
    [self.view addSubview:navigationBar];
    
    // 添加导航栏图标和标题
    UIImage* image = [UIImage imageNamed:@"tab1.png"];
    UITabBarItem* tabBarItem1 = [[[UITabBarItem alloc] initWithTitle:@"任务" image:image tag:0] autorelease];
    self.tabBarItem = tabBarItem1;
    
    [navigationItem release],navigationItem = nil;
    [navigationBar release],navigationBar = nil;

    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.unFinishViewController = nil;
}
- (void)dealloc
{
    self.unFinishViewController = nil;
    [super dealloc];
}

#pragma mark - IBAction
- (IBAction)btnUnFinishClicked:(id)sender
{
    // 加载unFinishViewController窗口
    [unFinishViewController release];
    unFinishViewController = [[UnFinishViewController alloc] init];
    // 使生成的每一个行数据都能点击进入
    [self.navigationController pushViewController:unFinishViewController animated:YES];
}
- (IBAction)btnFinishClicked:(id)sender
{
    // 加载FinishViewController窗口
    [finishViewController release];
    finishViewController = [[FinishViewController alloc] init];
    // 使生成的每一个行数据都能点击进入
    [self.navigationController pushViewController:finishViewController animated:YES];
}
- (IBAction)btnAllClicked:(id)sender
{
    // 加载AllViewController窗口
    [allViewController release];
    allViewController = [[AllViewController alloc] init];
    // 使生成的每一个行数据都能点击进入
    [self.navigationController pushViewController:allViewController animated:YES];
}

@end
