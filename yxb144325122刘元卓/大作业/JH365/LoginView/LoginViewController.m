#import "LoginViewController.h"
#import "Md5Coder.h"     // MD5加密
#import "SVStatusHUD.h"  // 指示器
#import "MainViewController.h"// 主界面
#import "MacroDefine.h"  // 宏定义
#import "SetViewController.h"
@implementation LoginViewController

@synthesize btnLogin,textName,textPassword;
@synthesize mainViewController;
@synthesize imageView;
// 使用手势,退出文本域
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textName resignFirstResponder];
    [textPassword resignFirstResponder];
}
// 按return隐藏键盘
-(IBAction)touchesBegan:(id)sender
{
    [sender resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    textName.text = [defaults objectForKey:Username];
    textPassword.text =[defaults objectForKey:Pasword];
    imageView.image =[UIImage imageNamed:[defaults objectForKey:Image]];
}
-(void)setLoginImage:(UIImage *)Loginimage
{
    imageView.image = Loginimage;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [mainViewController release],mainViewController = nil;
    [btnLogin release],btnLogin = nil;
    [textName release],textName = nil;
    [textPassword release],textPassword = nil;
}

-(void)dealloc
{
    [mainViewController release],mainViewController = nil;
    [btnLogin release],btnLogin = nil;
    [textName release],textName = nil;
    [textPassword release],textPassword = nil;
    [super dealloc];
}

-(IBAction)btnLogin:(id)sender
{
    [textName resignFirstResponder];
    [textPassword resignFirstResponder];
    
    NSString *userName = textName.text;
    NSString *passWord = textPassword.text;
    if(userName == nil || userName.length <= 0)
    {
        // 自定义消息框
        [SVStatusHUD showErrorWithStatus:@"请输入有效的用户名!"];
    }
    else if(passWord == nil || passWord.length <= 0)
    {
        [SVStatusHUD showErrorWithStatus:@"请输入有效的密码!"];
    }
    else
    {
        // 调用MD5加密 密码
        passWord = [[Md5Coder md5Encode:passWord] lowercaseString];
        
        // 开始访问远程服务器
        if(techDAL == nil)
            techDAL = [[TechDAL alloc] initWithDelegate:self];
        
        if([techDAL login:userName :passWord] == false)
        {
            [SVStatusHUD showErrorWithStatus:@"消息发送失败!"];
        }
    }
}

#pragma mark - TechInfoDelegate
// 回调
-(void)loginCallBack:(TechInfoModel *)item
{
    if(item == nil || item.djLsh <= 0)
    {
        textPassword.text = @"";
        [SVStatusHUD showErrorWithStatus:@"登录失败!"];
    }
    else
    {
        // 清空输入框
        textName.text = @"";
        textPassword.text = @"";
        // 弹出消息
        [SVStatusHUD showSuccessWithStatus:@"登录成功!"];
        // 进入主界面
        if(mainViewController == nil)
        {
            mainViewController = [[MainViewController alloc] initWithNibName:(iPhone5?@"MainView-5":@"MainView") bundle:nil];
        }
        [self.view.superview addSubview:mainViewController.view];
        [self.view removeFromSuperview];
    }

}

@end
