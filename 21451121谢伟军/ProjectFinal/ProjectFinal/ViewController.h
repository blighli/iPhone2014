//
//  ViewController.h
//  ProjectFinal
//
//  Created by xvxvxxx on 12/18/14.
//  Copyright (c) 2014 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "CDSideBarController.h"
#import "ChannelsTableViewController.h"
#import "AppDelegate.h"
#import "SongInfo.h"
#import "PlayerController.h"
@interface ViewController : UIViewController <CDSideBarControllerDelegate, NetworManagerDelegate, PlayerControllerDelegate>{
    CDSideBarController *sideBar;
}



@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) IBOutlet UITextField *captcha;
@property (strong, nonatomic) IBOutlet UIImageView *picture;

- (IBAction)submitButton:(UIButton *)sender;
- (IBAction)nextSongButton:(UIButton *)sender;
-(void)loadCaptchaImage;
-(void)loadPlaylist;
@end

