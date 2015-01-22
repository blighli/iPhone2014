//
//  drawViewController.h
//  evernote
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface drawViewController : UIViewController


@property (strong, nonatomic) IBOutlet UISegmentedControl *colorSet;
@property (strong, nonatomic) IBOutlet UISlider *widthSet;

//传递图片的名称
@property (nonatomic, strong) NSString *sendPictureName;

//改变颜色
- (IBAction)colorChange:(id)sender;
//改变宽度
- (IBAction)widthChange:(id)sender;
//设置颜色
- (IBAction)colorToSet:(id)sender;
//设置宽度
- (IBAction)widthToSet:(id)sender;
//橡皮，宽度同样可以用于改变橡皮的宽度
- (IBAction)eraser:(id)sender;
//清屏
- (IBAction)clearScreen:(id)sender;
//保存
- (IBAction)savePicture:(id)sender;
-(void)savetodatabasewith:(NSString*)imgname;

@end
