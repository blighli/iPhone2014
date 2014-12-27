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
    AppDelegate *appDelegate;
    
    ChannelsTableViewController *channelsTableViewController;
    LoginViewController *loginViewController;
    
    AFHTTPRequestOperationManager *manager;
    NetworkManager *networkManager;
    PlayerController *playerController;
    
    BOOL isPlaying;
    NSTimer *timer;
    int currentTimeMinutes;
    int currentTimeSeconds;
    NSMutableString *currentTimeString;
    int TotalTimeMinutes;
    int TotalTimeSeconds;
    NSMutableString *totalTimeString;
    NSMutableString *timerLabelString;
    
    enum page{
        playerPage,playlistPage,loginPage
    } currentPage;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    manager = [AFHTTPRequestOperationManager manager];
    appDelegate = [[UIApplication sharedApplication]delegate];

    
    channelsTableViewController = [[ChannelsTableViewController alloc]init];
    loginViewController = [[LoginViewController alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
    networkManager = [[NetworkManager alloc]init];
    networkManager.CaptchaImageDelegate = self;
    isPlaying = YES;
    currentPage = playerPage;
    //self.picture.layer.masksToBounds = YES;
    //self.picture.layer.cornerRadius = 150;    
    
    [self loadCaptchaImage];
    [self loadPlaylist];
    //[_appDelegate.player setContentURL:(NSURL *)[[_appDelegate.playList objectAtIndex:0]valueForKey:@"url"]];
    //初始化图片点击事件
    self.imageview.userInteractionEnabled = YES;
    //UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadCaptchaImage)];
    
    //刷新验证码图片
//    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadCaptchaImage)];
//    [singleTap setNumberOfTapsRequired:1];
//    [self.imageview addGestureRecognizer:singleTap];
    self.picture.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pauseButton:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.picture addGestureRecognizer:singleTap];
    playerController = [[PlayerController alloc]init];
    playerController.songInfoDelegate = self;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
}

-(void)updateProgress{
    currentTimeMinutes = (unsigned)appDelegate.player.currentPlaybackTime/60;
    currentTimeSeconds = (unsigned)appDelegate.player.currentPlaybackTime%60;
    if (currentTimeSeconds < 10) {
        currentTimeString = [NSMutableString stringWithFormat:@"%d:0%d",currentTimeMinutes,currentTimeSeconds];
    }
    else{
        currentTimeString = [NSMutableString stringWithFormat:@"%d:%d",currentTimeMinutes,currentTimeSeconds];
    }
    timerLabelString = [NSMutableString stringWithFormat:@"%@/%@",currentTimeString,totalTimeString];
    self.timerLabel.text = timerLabelString;
    self.timerProgressBar.progress = appDelegate.player.currentPlaybackTime/[appDelegate.currentSong.length intValue];
}

-(void)viewDidAppear:(BOOL)animated{
//    [sideBar insertMenuButtonOnView:appDelegate.window atPosition:CGPointMake(self.view.frame.size.width - 50, 40)];
}

-(void)viewWillAppear:(BOOL)animated{
    [self initSongInfomation];
}

-(void)loadPlaylist{
    [networkManager loadPlaylistwithType:@"n"];
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

- (IBAction)pauseButton:(UIButton *)sender {
    if (isPlaying) {
        isPlaying = NO;
        self.picture.alpha = 0.2f;
        self.pictureBlock.image = [UIImage imageNamed:@"albumBlock2"];
        [playerController pauseSong];
        [self.pauseButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
    else{
        isPlaying = YES;
        self.picture.alpha = 1.0f;
        self.pictureBlock.image = [UIImage imageNamed:@"albumBlock"];
        [playerController restartSong];
        [self.pauseButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}

- (IBAction)skipButton:(UIButton *)sender{
    if(isPlaying == NO){
        isPlaying = YES;
        self.picture.alpha = 1.0f;
        self.pictureBlock.image = [UIImage imageNamed:@"albumBlock"];
        [playerController restartSong];
        [self.pauseButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
    [playerController skipSong];
}

- (IBAction)likeButton:(UIButton *)sender {
    if (![appDelegate.currentSong.like intValue]) {
        appDelegate.currentSong.like = @"1";
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
        [playerController likeSong];
    }
    else{
        appDelegate.currentSong.like = @"0";
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
    }
}

- (IBAction)deleteButton:(UIButton *)sender {
}



-(void)menuButtonClicked:(int)index{
    NSLog(@"%i",index);
    switch (index) {
        case 0:
            //
        {
            [self dismissViewControllerAnimated:YES completion:nil];
             currentPage = index;
        }
            break;
        case 1:
            //
            if (currentPage != playlistPage) {
                [self presentViewController:channelsTableViewController animated:YES completion:nil];
            }
            currentPage = index;
            break;
        case 2:
            if (currentPage != loginPage) {
                [self presentViewController:loginViewController animated:YES completion:nil];
            }
        default:
            break;
    }
}

-(void)setCaptchaImageWithURLInString:(NSString *)url{
    [self.imageview setImageWithURL:[NSURL URLWithString:url]];
}
-(void)initSongInfomation{
    [self.picture setImageWithURL:[NSURL URLWithString:appDelegate.currentSong.picture]];
    self.songArtist.text = appDelegate.currentSong.artist;
    self.songTitle.text = appDelegate.currentSong.title;
    self.ChannelTitle.text = [NSString stringWithFormat:@"♪%@♪",appDelegate.currentChannel.name];
    
    //初始化timeLabel的总时间
    TotalTimeSeconds = [appDelegate.currentSong.length intValue]%60;
    TotalTimeMinutes = [appDelegate.currentSong.length intValue]/60;
    if (TotalTimeSeconds < 10) {
        totalTimeString = [NSMutableString stringWithFormat:@"%d:0%d",TotalTimeMinutes,TotalTimeSeconds];
    }
    else{
        totalTimeString = [NSMutableString stringWithFormat:@"%d:%d",TotalTimeMinutes,TotalTimeSeconds];
    }
    
    //初始化likeButon的图像
    if (![appDelegate.currentSong.like intValue]) {
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"heart1"] forState:UIControlStateNormal];
    }
    else{
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"heart2"] forState:UIControlStateNormal];
    }
}

//验证码图片点击刷新验证码事件
-(void)loadCaptchaImage{
    [networkManager loadCaptchaImage];
}


@end

