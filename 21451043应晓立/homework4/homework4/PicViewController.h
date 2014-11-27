//
//  PicViewController.h
//  homework4
//
//  Created by yingxl1992 on 14/11/26.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PicView.h"
#import "AddListViewController.h"
#import "EditImageViewController.h"
#import "NoteDB.h"
#import "NoteList.h"

@interface PicViewController : UIViewController<UIAlertViewDelegate,CLLocationManagerDelegate>
{
    NSData *pic;
}

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *startPoint;
@property (assign, nonatomic) CLLocationDistance distanceFromStart;
@property (nonatomic,weak) NoteList *noteList;

//传递图片的名称
@property (nonatomic, strong) NSString *sendPictureName;

//清屏
- (IBAction)clearScreen:(id)sender;
//保存
- (void)savePicture;

@end
