#import "AppDelegate.h"
#import "MacroDefine.h" // 宏定义
#import "RootViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    self.viewController = [[[RootViewController alloc] initWithNibName:(iPhone5?@"RootView-5":@"RootView") bundle:nil] autorelease];
    self.window.rootViewController = self.viewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

// 将要进入后台
- (void)applicationWillResignActive:(UIApplication *)application
{
}
// 已经进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
}
// 将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application
{
}
// 已经进入前台
- (void)applicationDidBecomeActive:(UIApplication *)application
{
}
// 程序将要结束
- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
