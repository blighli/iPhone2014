//
//  TCamera.m
//  Tour
//
//  Created by LFR on 14-7-2.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "Camera.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AppDelegate.h"
#import <ImageIO/ImageIO.h>
#import "Note.h"
#import "ImageUtils.h"

@implementation Camera
UIImagePickerController* picker;

- (void)viewDidLoad
{
	[super viewDidLoad];
}

- (void)takePhoto:(UIViewController*)currentView
{
	// 如果拍摄的摄像头可用
	if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
	{
		// 将sourceType设为UIImagePickerControllerSourceTypeCamera代表拍照或拍视频
		self.sourceType = UIImagePickerControllerSourceTypeCamera;
		// 设置拍摄照片
		self.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
		// 设置使用手机的后置摄像头（默认使用后置摄像头）
		self.cameraDevice = UIImagePickerControllerCameraDeviceRear;
		// 设置使用手机的前置摄像头。
        //		picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
		// 设置拍摄的照片是否允许编辑
		self.allowsEditing = YES;
        // 显示picker视图控制器
        [currentView presentViewController:self animated: YES completion:nil];

	}
	else
	{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"模拟器无法打开摄像头" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alertView show];
	}
}

- (void)loadPhoto:(UIViewController*)currentView
{
	// 设置选择载相册的图片或视频
    NSLog(@"打开相册");
	self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	self.allowsEditing = YES;
	[currentView presentViewController:self animated: YES completion:nil];
}

// 当得到照片或者视频后，调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//	NSLog(@"成功：%@", info);
    NSLog(@"打开相册");
	// 获取用户拍摄的是照片还是视频
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	// 判断获取类型：图片，并且是刚拍摄的照片
	if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
	{
		_theImage = nil;
		// 判断，图片是否允许修改
		if ([picker allowsEditing])
		{
			// 获取用户编辑之后的图像
			_theImage = [info objectForKey:UIImagePickerControllerEditedImage];
		}
		else
		{
			// 获取原始的照片
			_theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
		}
		// 如果是拍摄的那么保存图片到相册中
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(_theImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
	}
	// 隐藏UIImagePickerController
	[self dismissViewControllerAnimated:YES completion:nil];

}
// 当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	NSLog(@"用户取消的拍摄！");
	// 隐藏UIImagePickerController
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    if (error != NULL){
        //失败
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Save Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alertView show];
    }
    else{
        //成功
        NSString *imageName = [NSString stringWithFormat:@"%d.png", (int)[[NSDate date] timeIntervalSince1970]];
        NSString *imagePath = [ImageUtils saveImage:image WithName:imageName];
        NSLog(@"imagePath : %@", imagePath);
        Note *newNote = [[Note alloc]init];
        newNote.title = @"拍照";
        newNote.content = @"";
        newNote.type = @"text";
        newNote.imagePath = imagePath;
        [newNote add];
    }
}

@end
