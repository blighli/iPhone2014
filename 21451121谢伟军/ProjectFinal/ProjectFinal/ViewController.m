//
//  ViewController.m
//  ProjectFinal
//
//  Created by xvxvxxx on 12/18/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//
#import "ViewController.h"
#import <UIKit+AFNetworking.h>
@interface ViewController (){
    NSMutableString *captchaID;
    AFHTTPRequestOperationManager *manager;
    ChannelsTableViewController *channelsTableViewController;
    NetworkManager *networkManager;
    PlayerController *playerController;
    AppDelegate *appDelegate;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [AFHTTPRequestOperationManager manager];
    appDelegate = [[UIApplication sharedApplication]delegate];
    NSArray *imageList = @[[UIImage imageNamed:@"menuChat.png"], [UIImage imageNamed:@"menuUsers.png"], [UIImage imageNamed:@"menuMap.png"], [UIImage imageNamed:@"menuClose.png"]];
    sideBar = [[CDSideBarController alloc] initWithImages:imageList];
    sideBar.delegate = self;
    
    channelsTableViewController = [[ChannelsTableViewController alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
    networkManager = [[NetworkManager alloc]init];
    networkManager.CaptchaImageDelegate = self;

    [self loadCaptchaImage];
    [self loadPlaylist];
    //[_appDelegate.player setContentURL:(NSURL *)[[_appDelegate.playList objectAtIndex:0]valueForKey:@"url"]];
    //初始化图片点击事件
    self.imageview.userInteractionEnabled = YES;
    //UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadCaptchaImage)];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadCaptchaImage)];
    [singleTap setNumberOfTapsRequired:1];
    [self.imageview addGestureRecognizer:singleTap];
    playerController = [[PlayerController alloc]init];
    playerController.pictureDelegate = self;
    
}



-(void)viewDidAppear:(BOOL)animated{
    [sideBar insertMenuButtonOnView:[UIApplication sharedApplication].delegate.window atPosition:CGPointMake(self.view.frame.size.width - 50, 50)];
}



-(void)loadPlaylist{
    [networkManager loadPlaylistwithType:@"n" Sid:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)submitButton:(UIButton *)sender {
    NSString *username = _username.text;
    NSString *password = _password.text;
    NSString *captcha = _captcha.text;
    [networkManager LoginwithUsername:username Password:password CaptchaID:captchaID Captcha:captcha RememberOnorOff:@"off"];
}

- (IBAction)nextSongButton:(UIButton *)sender {
    [playerController skipSong];
}

-(void)menuButtonClicked:(int)index{
    NSLog(@"%i",index);
    switch (index) {
        case 0:
            //
            [self dismissViewControllerAnimated:YES completion:^{
                NSLog(@"Return");
            }];
            break;
        case 1:
            //
            [self presentViewController:channelsTableViewController animated:YES completion:^{
                NSLog(@"load channelsTableViewController successfull");
            }];
            break;
        case 2:
            
        default:
            break;
    }
}

-(void)setCaptchaImageWithURLInString:(NSString *)url{
    [self.imageview setImageWithURL:[NSURL URLWithString:url]];
}
-(void)setPictureWithURLInString:(NSString *)url{
    [self.picture setImageWithURL:[NSURL URLWithString:url]];
}
//验证码图片点击刷新验证码事件
-(void)loadCaptchaImage{
    [networkManager loadCaptchaImage];
}


@end

