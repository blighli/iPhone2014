//
//  UserInfoViewController.m
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/4.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *otherName;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *age;
@property (weak, nonatomic) IBOutlet UILabel *fllowerNum;
@property (weak, nonatomic) IBOutlet UILabel *weiboCount;
@property (weak, nonatomic) IBOutlet UILabel *buildTime;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *blogAddress;
@property (weak, nonatomic) IBOutlet UILabel *weiboAddress;
@property (weak, nonatomic) IBOutlet UILabel *personDescription;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activitorIndictor;
- (IBAction)clickLogoutButton:(id)sender;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _weibo=[Weibo getInstance];
    NSThread *t=[[NSThread alloc]initWithTarget:self selector:@selector(setLabel) object:nil];
    [t start];
    NSLog(@"%@",_userInfo);
    // Do any additional setup after loading the view.
}
-(void)setHidden:(BOOL)b{
 
    self.nickName.hidden=b;
    self.otherName.hidden=b;
    self.sex.hidden=b;
    self.fllowerNum.hidden=b;
    self.weiboAddress.hidden=b;
    self.weiboCount.hidden=b;
    self.buildTime.hidden=b;
    self.location.hidden=b;
    self.blogAddress.hidden=b;
    self.personDescription.hidden=b;
    self.headImage.hidden=b;
    self.activitorIndictor.hidden=!b;
}
-(void)setLabel{
    [self.activitorIndictor startAnimating];
    [self setHidden:YES];
    _userInfo=[_weibo getUserInfo];
    [self.activitorIndictor stopAnimating];
    [self setHidden:NO];
    self.nickName.text=[_userInfo objectForKey:@"name"];
    self.otherName.text=[_userInfo objectForKey:@"screen_name"];
 //   self.age.text=[_userInfo objectForKey:@"gender"];
    NSString *gender=[_userInfo objectForKey:@"gender"];
    if([gender compare:@" m"])
        self.sex.text=@"男";
    else if([gender compare:@" f"])
        self.sex.text=@"女";
    else
        self.sex.text=@"未知";
    NSInteger fc=[_userInfo objectForKey:@"followers_count"];
    self.fllowerNum.text=[NSString stringWithFormat:@"%@",fc];
    self.weiboCount.text=[NSString stringWithFormat:@"%@",[_userInfo objectForKey:@"statuses_count"]];
    self.buildTime.text=[_userInfo objectForKey:@"created_at"];
    self.location.text=[_userInfo objectForKey:@"location"];
    self.blogAddress.text=[_userInfo objectForKey:@"url"];
    self.weiboAddress.text=[_userInfo objectForKey:@"profile_url"];
    self.personDescription.text=[_userInfo objectForKey:@"description"];
    self.headImage.image=[_weibo loadUIImage:[_userInfo objectForKey:@"avatar_large"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    NSThread *t=[[NSThread alloc]initWithTarget:self selector:@selector(setLabel) object:nil];
    [t start];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        NSFileManager *fm=[NSFileManager defaultManager];
        [fm removeItemAtPath:_weibo.finalPath error:nil];
        [self.navigationController performSegueWithIdentifier:@"registerSegue" sender:self];
        OAuthViewController *oauth=[self.storyboard instantiateViewControllerWithIdentifier:@"oauthController"];
        [self presentViewController:oauth animated:YES completion:nil];
    }
    
}

- (IBAction)clickLogoutButton:(id)sender {
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"注销" message:@"确定注销？" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
    alertView.show;
}
@end
