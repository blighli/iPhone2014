//
//  MDrawViewController.m
//  Mynotes
//
//  Created by lixu on 14/11/22.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import "MDrawViewController.h"
#import "MQuartzView.h"
#import <objc/runtime.h>

@interface MDrawViewController ()
@property (strong,nonatomic)  MQuartzView *quartzView;
@property NSString *latitudeString,*longitudeString;

@end

@implementation MDrawViewController

@synthesize colorSet,widthSet;
@synthesize quartzView;
@synthesize sendPictureName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect viewFrame=self.view.frame;
    colorSet.hidden = YES;
    widthSet.hidden = YES;
    
    self.quartzView=[[MQuartzView alloc]initWithFrame:viewFrame];
    if (sendPictureName) {
        NSString *aPathImage=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),sendPictureName];
        UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPathImage];
        UIColor *bgColor = [UIColor colorWithPatternImage: imgFromUrl3];
        [self.quartzView setBackgroundColor:bgColor];
    } else
        [self.quartzView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview: self.quartzView];
    [self.view sendSubviewToBack:self.quartzView];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    self.locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)colorChange:(id)sender {
    if (colorSet.hidden == YES) {
        colorSet.hidden = NO;
        widthSet.hidden = YES;
    } else {
        colorSet.hidden = YES;
    }
    [self colorToSet:colorSet];
}

- (IBAction)widthChange:(id)sender {
    if (widthSet.hidden == YES) {
        widthSet.hidden = NO;
        colorSet.hidden = YES;
    } else {
        widthSet.hidden = YES;
    }
}

- (IBAction)colorToSet:(id)sender {
    NSInteger index = [colorSet selectedSegmentIndex];
    [self.quartzView setLineColor:index];
}

- (IBAction)widthToSet:(id)sender {
    [self.quartzView setlineWidth:(int)round(widthSet.value)];
}

- (IBAction)eraser:(id)sender {
    colorSet.hidden = YES;
    widthSet.hidden = YES;
    [self.quartzView setLineColor:6];
}

- (IBAction)clearScreen:(id)sender {
    colorSet.hidden = YES;
    widthSet.hidden = YES;
    [self.quartzView clear];
}

- (IBAction)savePicture:(id)sender {
    colorSet.hidden = YES;
    widthSet.hidden = YES;
    
    if (sendPictureName) {
        UIGraphicsBeginImageContext(quartzView.bounds.size);
        [quartzView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        //获取document目录的文件名
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        //获取沙盒目录
        NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),sendPictureName];
        NSData *imgData = UIImageJPEGRepresentation(image,0);
        [imgData writeToFile:aPath atomically:YES];
        //获取缩略图目录
        NSString *thumbAPath = [NSString stringWithFormat:@"%@/Documents/thumbnail",NSHomeDirectory()];
        //如果未创建缩略图目录，创建
        if (![[NSFileManager defaultManager] fileExistsAtPath:thumbAPath]) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"thumbnail"];
            // 创建目录
            [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        }
        //获取缩略图目录
        NSString *thumbSaveAPath = [NSString stringWithFormat:@"%@/Documents/thumbnail/%@",NSHomeDirectory(),sendPictureName];
        CGSize size = CGSizeMake(40, 40);
        [self createThumbImage:image size:size percent:100 toPath:thumbSaveAPath];
        UIAlertView *alertErrorView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertErrorView show];
    } else {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"保存绘图" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView show];
    }
}

#pragma mark --UIAlertViewDelegate--
-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //得到输入框
    if (buttonIndex == 1) {
        //用于判断是否有重名文件夹
        BOOL isSameName = NO;
        //获取输入框
        UITextField *tf=[alertView textFieldAtIndex:0];
        //获取当前文件名
        NSString *pictureName = [[NSString alloc] initWithFormat:@"%@.jpg",tf.text];
        //获取document目录的文件名
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSFileManager *fileManage = [NSFileManager defaultManager];
        NSArray *file = [fileManage subpathsOfDirectoryAtPath: documentsDirectory error:nil];
        //判断是否已保存相同文件名的文件
        for (int i = 0; i<file.count; i++) {
            if ([pictureName isEqualToString:file[i]]) {
                isSameName = YES;
            }
        }
        if (isSameName) {   //如果是，取消保存，并提示
            UIAlertView *alertErrorView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"已有相同名称的文件，请重命名" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertErrorView show];
        } else {    //如果否，保存文件
            UIGraphicsBeginImageContext(quartzView.bounds.size);
            [quartzView.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            //获取沙盒目录
            NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),pictureName];
            NSData *imgData = UIImageJPEGRepresentation(image,0);
            [imgData writeToFile:aPath atomically:YES];
            _access=[[MDBAccess alloc] init];
            [_access initializeDatabase];
            [_access createTable];
            [_access saveDatas:aPath Type:3 NibName:[tf.text stringByAppendingString:@"----手绘"]];
            [_access closeDatabase];
            //获取缩略图目录
            NSString *thumbAPath = [NSString stringWithFormat:@"%@/Documents/thumbnail",NSHomeDirectory()];
            //如果未创建缩略图目录，创建
            if (![[NSFileManager defaultManager] fileExistsAtPath:thumbAPath]) {
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"thumbnail"];
                // 创建目录
                [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
            }
            //获取缩略图目录
            NSString *thumbSaveAPath = [NSString stringWithFormat:@"%@/Documents/thumbnail/%@",NSHomeDirectory(),pictureName];
            CGSize size = CGSizeMake(40, 40);
            [self createThumbImage:image size:size percent:100 toPath:thumbSaveAPath];
            UIAlertView *alertErrorView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertErrorView show];
        }
    }
}

//创建缩略图
-(void)createThumbImage:(UIImage *)image size:(CGSize)thumbSize percent:(float)percent toPath:(NSString *)thumbPath
{
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat scaleFactor = 0.0;
    CGPoint thumbPoint = CGPointMake(0.0,0.0);
    CGFloat widthFactor = thumbSize.width / width;
    CGFloat heightFactor = thumbSize.height / height;
    if (widthFactor > heightFactor)  {
        scaleFactor = widthFactor;
    } else {
        scaleFactor = heightFactor;
    }
    
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    if (widthFactor > heightFactor)
    {
        thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;
    } else if (widthFactor < heightFactor)
    {
        thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;
    }
    
    UIGraphicsBeginImageContext(thumbSize);
    CGRect thumbRect = CGRectZero;
    thumbRect.origin = thumbPoint;
    thumbRect.size.width  = scaledWidth;
    thumbRect.size.height = scaledHeight;
    [image drawInRect:thumbRect];
    
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *thumbImageData = UIImageJPEGRepresentation(thumbImage, percent);
    [thumbImageData writeToFile:thumbPath atomically:NO];
}

#pragma mark --CLLocationManagerDelegate--
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *newLocation = [locations lastObject];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"/Locations.plist"];
    _latitudeString = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.latitude];
    //NSLog(@"%@",_latitudeString);
    _longitudeString = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.longitude];
    //NSLog(@"%@",_longitudeString);
    if (_latitudeString&&_longitudeString) {
        [_locationManager stopUpdatingLocation];
    }
    //创建定位数组
    NSArray *location = [[NSArray alloc] initWithObjects:_latitudeString,_longitudeString, nil];
    //写入plist文件
    [location writeToFile:path atomically:YES];
}
@end
