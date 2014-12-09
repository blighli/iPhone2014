#import "RootViewController.h"
#import "MacroDefine.h"  // 宏定义类

@implementation RootViewController

@synthesize loginViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// 加载登录界面
    if (self)
    {
        if (self.loginViewController == nil)
        {
            loginViewController = [[LoginViewController alloc] initWithNibName:(iPhone5?@"LoginView-5":@"LoginView") bundle:nil];
            // 加载登录界面
            [self.view addSubview:loginViewController.view];
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.loginViewController = nil;
}
- (void)dealloc
{
    self.loginViewController = nil;
    [super dealloc];
}

@end
