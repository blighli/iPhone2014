#import "MainViewController.h"
#import "MacroDefine.h"

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 任务 界面
    taskViewController = [[TaskViewController alloc] initWithNibName:(iPhone5?@"TaskView-5":@"TaskView") bundle:nil];
    UIImage *image1 = [UIImage imageNamed:@"tab1.png"];
    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"任务" image:image1 tag:0];
    taskViewController.tabBarItem = tabBarItem1;
    navc1 = [[UINavigationController alloc] initWithRootViewController:taskViewController];
    navc1.navigationBarHidden = true;
    
    // 材料 界面
    materialListViewController = [[MaterialListViewController alloc] initWithNibName:(iPhone5?@"MaterialListView-5":@"MaterialListView") bundle:nil];
    UIImage *image2 = [UIImage imageNamed:@"tab2.png"];
    UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"材料" image:image2 tag:0];
    materialListViewController.tabBarItem = tabBarItem2;
    navc2 = [[UINavigationController alloc] initWithRootViewController:materialListViewController];
    navc2.navigationBarHidden = true;
    
    // 客户 界面
    customListViewController = [[CustomListViewController alloc] initWithNibName:(iPhone5?@"CustomListView-5":@"CustomListView") bundle:nil];
    UIImage *image3 = [UIImage imageNamed:@"tab3.png"];
    UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"客户" image:image3 tag:0];
    customListViewController.tabBarItem = tabBarItem3;
    navc3 = [[UINavigationController alloc] initWithRootViewController:customListViewController];
    navc3.navigationBarHidden = true;
    
    // 设置 界面
    setViewController = [[SetViewController alloc] initWithNibName:(iPhone5?@"SetView-5":@"SetView") bundle:nil];
    UIImage *image4 = [UIImage imageNamed:@"tab4.png"];
    UITabBarItem *tabBarItem4 = [[UITabBarItem alloc] initWithTitle:@"设置" image:image4 tag:0];
    setViewController.tabBarItem = tabBarItem4;
    navc4 = [[UINavigationController alloc] initWithRootViewController:setViewController];
    navc4.navigationBarHidden = true;
    
    // Tab
    NSArray *arrView = [NSArray arrayWithObjects:navc1,navc2,navc3,navc4,nil];
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = arrView;
    [self.view addSubview:tabBarController.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [tabBarController release],tabBarController = nil;
    [navc1 release],navc1 = nil;
    [navc2 release],navc2 = nil;
    [navc3 release],navc3 = nil;
    [navc4 release],navc4 = nil;
    [taskViewController release],taskViewController = nil;
    [materialListViewController release],materialListViewController = nil;
    [customListViewController release],customListViewController = nil;
    [setViewController release],setViewController = nil;
}
- (void)dealloc
{
    [tabBarController release],tabBarController = nil;
    [navc1 release],navc1 = nil;
    [navc2 release],navc2 = nil;
    [navc3 release],navc3 = nil;
    [navc4 release],navc4 = nil;
    [taskViewController release],taskViewController = nil;
    [materialListViewController release],materialListViewController = nil;
    [customListViewController release],customListViewController = nil;
    [setViewController release],setViewController = nil;
    [super dealloc];
}

@end
