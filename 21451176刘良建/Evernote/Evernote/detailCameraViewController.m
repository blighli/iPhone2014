//
//  detailCameraViewController.m
//  Evernote
//
//  Created by JANESTAR on 14-11-23.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//
#import "AppDelegate.h"
#import "detailCameraViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "Camera.h"

@interface detailCameraViewController (){
    AppDelegate* appDelegate;
    NSManagedObjectContext* appContext;

}

@end

@implementation detailCameraViewController
@synthesize contentimageview;
@synthesize contenttextview;
@synthesize lastChosenMediaType;
- (void)viewDidLoad {
    [super viewDidLoad];
    contentimageview=[[UIImageView alloc]initWithFrame:self.view.frame];
     [self.view addSubview:contentimageview];
    UIBarButtonItem * done=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(savepic)];
    self.navigationItem.rightBarButtonItem=done;

    if(!self.flag){

    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"请选择照片来源" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [alert show];
    }
    else{
        NSString* title=[self.camera title];
        //NSDate* data=[self.camera time];
        NSLog(@"title is%@",title);
        NSString* aPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),title];
        NSLog(@"the camera path is%@",aPath);
         UIImage* img= [UIImage imageWithContentsOfFile:aPath];
        //UIImageView* imgview=[NSKeyedUnarchiver unarchiveObjectWithFile:aPath];
       
        self.contentimageview.image=img;
        
        self.flag=NO;
    
    
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString*)dateToNSString:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-hh-mm-ss"];
    NSString* strDate=[dateFormatter stringFromDate:date];
    //NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
-(void)savepic{
    if(self.contentimageview.image!=nil){
    appDelegate=[[UIApplication sharedApplication]delegate];
    appContext=[appDelegate managedObjectContext];
    
    if(!self.mark){
    NSDate * today=[NSDate date];

    NSString* today2=[self dateToNSString:today];
    
    NSString* aPath=[NSString stringWithFormat:@"%@/Documents/%@.png",NSHomeDirectory(),today2];
    NSString* subPath=[NSString stringWithFormat:@"%@.png",today2];
   
    
    NSLog(@"the path2 is%@",aPath);
    
     [UIImagePNGRepresentation(self.contentimageview.image) writeToFile:aPath atomically:YES];
    NSManagedObject* locinfo=[NSEntityDescription insertNewObjectForEntityForName:@"Camera" inManagedObjectContext:appContext];
    // [locinfo setValue:aPath forKey:@"loc"];
    [locinfo setValue:subPath forKey:@"title"];
    [locinfo setValue:today forKey:@"time"];
    NSError* error;
    [appContext save:&error];
    if(error!=nil){
        NSLog(@"%@",error);
        printf("you get wrong\n");
    }
    }
    else{
    
        self.mark=NO;
    }}
    [self.navigationController popViewControllerAnimated:YES];



}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma 拍照选择模块
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1)
        [self shootPicturePrVideo];
    else if(buttonIndex==2)
        [self selectExistingPictureOrVideo];
}
#pragma  mark- 拍照模块
//从相机上选择
-(void)shootPicturePrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}
//从相册中选择
-(void)selectExistingPictureOrVideo{
    [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma 拍照模块
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
     self.lastChosenMediaType=[info objectForKey:UIImagePickerControllerMediaType];
     if([lastChosenMediaType isEqual:(NSString *) kUTTypeImage])
     {
     UIImage *chosenImage=[info objectForKey:UIImagePickerControllerEditedImage];
     contentimageview.image=chosenImage;
     }
     if([lastChosenMediaType isEqual:(NSString *) kUTTypeMovie])
     {
     UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持图片格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
     [alert show];
         [self.navigationController popViewControllerAnimated:YES];

     
     }
    // [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
   // [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediatypes count]>0){
        //NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.mediaTypes=mediatypes;
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        NSString *requiredmediatype=(NSString *)kUTTypeImage;
        NSArray *arrmediatypes=[NSArray arrayWithObject:requiredmediatype];
        [picker setMediaTypes:arrmediatypes];
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"错误信息!" message:@"当前设备不支持拍摄功能" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
/*
static UIImage *shrinkImage(UIImage *orignal,CGSize size)
{
    CGFloat scale=[UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(NULL, size.width *scale,size.height*scale, 8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width*scale, size.height*scale), orignal.CGImage);
    CGImageRef shrunken=CGBitmapContextCreateImage(context);
    UIImage *final=[UIImage imageWithCGImage:shrunken];
    CGContextRelease(context);
    CGImageRelease(shrunken);
    return  final;
}
*/
@end
