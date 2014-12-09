#import <UIKit/UIKit.h>

// 4个子视图控制器
#import "TaskViewController.h"
#import "MaterialListViewController.h"
#import "CustomListViewController.h"
#import "SetViewController.h"

// 主界面
@interface MainViewController : UIViewController
{
    // 一个TabBar内嵌4个Navigation
    UITabBarController *tabBarController;
    UINavigationController *navc1;
    UINavigationController *navc2;
    UINavigationController *navc3;
    UINavigationController *navc4;
    
    // 四个视图控制器
    TaskViewController *taskViewController;
    MaterialListViewController *materialListViewController;
    CustomListViewController *customListViewController;
    SetViewController *setViewController;
}

@end
