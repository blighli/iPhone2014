//
//  PhotoViewController.m
//  homework4
//
//  Created by yingxl1992 on 14/11/26.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "PhotoViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface PhotoViewController ()

@end

@implementation PhotoViewController
@synthesize noteList;
@synthesize contentimageview;
@synthesize lastChosenMediaType;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftBarButton=[[UIBarButtonItem alloc]init];
    leftBarButton.title=@"保存";
    leftBarButton.target=self;
    leftBarButton.action=@selector(savePhoto);
    self.navigationItem.leftBarButtonItem=leftBarButton;
}

- (void)savePhoto {
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"保存图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    alert1=alertView;
    [alertView show];
}

#pragma mark --UIAlertViewDelegate--
-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==alert1) {
        if (buttonIndex == 0) {
            UIImage *image=contentimageview.image;
            if (noteList==nil) {
                noteList=[[NoteList alloc]init];
            }
            noteList.image=UIImageJPEGRepresentation(image, 100);
            AddListViewController *addListViewController=[[AddListViewController alloc]init];
            addListViewController.noteList=noteList;
            EditImageViewController *editImageViewController=[[EditImageViewController alloc]init];
            editImageViewController.noteList=noteList;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (alertView==alert2) {
        //拍照选择模块
        if(buttonIndex==1)
            [self shootPiicturePrVideo];
        else if(buttonIndex==2)
            [self selectExistingPictureOrVideo];
    }
}

-(IBAction)buttonclick:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"请选择图片来源" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    alert2=alert;
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark- 拍照模块
//从相机上选择
-(void)shootPiicturePrVideo{
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
        UIImage *chosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
        contentimageview.image=chosenImage;
        
    }
    if([lastChosenMediaType isEqual:(NSString *) kUTTypeMovie])
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息!" message:@"系统只支持图片格式" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alert show];
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] &&[mediatypes count]>0){
        NSArray *mediatypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
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
    }
}
@end
