//
//  drawViewController.m
//  evernote
//
//  Created by apple on 14/11/28.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "drawViewController.h"
#import "quartzView.h"
#import "AppDelegate.h"


@interface drawViewController()
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *context;
}
@property (strong,nonatomic)  quartzView *quartzView1;
@property NSString *latitudeString,*longitudeString;
@end

@implementation drawViewController

@synthesize colorSet,widthSet;
@synthesize quartzView1;
@synthesize sendPictureName;



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context=[appDelegate managedObjectContext];
    
    
    CGRect viewFrame=self.view.frame;
    colorSet.hidden = YES;
    widthSet.hidden = YES;
    
    self.quartzView1=[[quartzView alloc]initWithFrame:viewFrame];
    if (sendPictureName) {
        NSString *aPathImage=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),sendPictureName];
        UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPathImage];
        UIColor *bgColor = [UIColor colorWithPatternImage: imgFromUrl3];
        [self.quartzView1 setBackgroundColor:bgColor];
    } else
        [self.quartzView1 setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview: self.quartzView1];
    [self.view sendSubviewToBack:self.quartzView1];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
//    self.locationManager = [[CLLocationManager alloc] init];
//    _locationManager.delegate = self;
//    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//    [_locationManager startUpdatingLocation];
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
    [self.quartzView1 setLineColor:index];
}

- (IBAction)widthToSet:(id)sender {
    [self.quartzView1 setlineWidth:(int)round(widthSet.value)];
}

- (IBAction)eraser:(id)sender {
    colorSet.hidden = YES;
    widthSet.hidden = YES;
    [self.quartzView1 setLineColor:6];
}

- (IBAction)clearScreen:(id)sender {
    colorSet.hidden = YES;
    widthSet.hidden = YES;
    [self.quartzView1 clear];
}

- (IBAction)savePicture:(id)sender {
    colorSet.hidden = YES;
    widthSet.hidden = YES;
    
    if (sendPictureName) {
        UIGraphicsBeginImageContext(quartzView1.bounds.size);
        [quartzView1.layer renderInContext:UIGraphicsGetCurrentContext()];
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
        [self createThumbImage:image size:size percent:100 toPath:thumbSaveAPath with:sendPictureName];
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
            UIGraphicsBeginImageContext(quartzView1.bounds.size);
            [quartzView1.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            //获取沙盒目录
            NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),pictureName];
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
            NSString *thumbSaveAPath = [NSString stringWithFormat:@"%@/Documents/thumbnail",NSHomeDirectory()];
            CGSize size = CGSizeMake(40, 40);
            [self createThumbImage:image size:size percent:100 toPath:thumbSaveAPath with:pictureName];
            UIAlertView *alertErrorView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertErrorView show];
        }
    }
}

//创建缩略图
-(void)createThumbImage:(UIImage *)image size:(CGSize)thumbSize percent:(float)percent toPath:(NSString *)thumbPath with:(NSString*)imgname
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
    NSString *pathforimg = [NSString stringWithFormat:@"%@/Documents/thumbnail/%@",NSHomeDirectory(),imgname];
    if (!sendPictureName) {
       [self savetodatabasewith:imgname];
    }
    
    [thumbImageData writeToFile:pathforimg atomically:NO];
    
}
-(void)savetodatabasewith:(NSString*)imgname
{
    NSManagedObject *object=[NSEntityDescription insertNewObjectForEntityForName:@"Drawing" inManagedObjectContext:context];
    [object setValue:imgname forKey:@"imgfile"];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    NSLog(@" save img to database");

}
@end

