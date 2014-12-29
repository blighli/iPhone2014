//
//  RightViewController.m
//  HVeBo
//
//  Created by HJ on 14/12/18.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "RightViewController.h"
#import "SendViewController.h"
#import "WBNavigationController.h"
#import "UIViewController+MMDrawerController.h"
#import "NearByViewController.h"
#import "LeftViewController.h"

@interface RightViewController ()<BaseViewDelegate,BaseTableViewDelegate>

@end

@implementation RightViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)disappear
{
    [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
}
- (IBAction)newBarBtn:(UIButton *)sender
{
    SendViewController *send = [[SendViewController alloc]init];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:send];
    send.delegate = self;
    //到时候再写枚举
    if(sender.tag == 103){
        send.openTag = 3;
        send.sorceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:nav animated:YES completion:nil];
    }else if(sender.tag == 104){
        send.openTag = 4;
        [self presentViewController:nav animated:YES completion:nil];
    }else if(sender.tag == 105){
        send.openTag = 5;
        [self presentViewController:nav animated:YES completion:nil];
    }else if(sender.tag == 101){
        send.openTag = 1;
        [self presentViewController:nav animated:YES completion:nil];
    }
    
    if (sender.tag == 102) {
        BOOL isCamera =  [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"此设备没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }else{
            send.openTag = 2;
            send.sorceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
    
    
}
@end
