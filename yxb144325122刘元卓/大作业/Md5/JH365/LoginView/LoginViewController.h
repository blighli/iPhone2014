#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "TechDAL.h"
// 登录界面
@interface LoginViewController : UIViewController
{
    MainViewController *mainViewController;
    UITabBarController *tabBarController;
    TechDAL *techDAL;
}

@property (nonatomic, retain) IBOutlet UIButton *btnLogin;
@property (nonatomic, retain) IBOutlet UITextField *textName;
@property (nonatomic, retain) IBOutlet UITextField *textPassword;
@property (nonatomic, strong) MainViewController *mainViewController; // 主界面

// 点击按钮
-(IBAction)btnLogin:(id)sender;
// 隐藏键盘
-(IBAction)touchesBegan:(id)sender;

@end
