//
//  imageViewController.m
//  MyNote
//
//  Created by yjq on 14/11/15.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import "imageViewController.h"

@interface imageViewController ()
{
    BOOL isFullScreen;
}
-(IBAction)dismissKeyboard:(id)sender;
-(IBAction)chooseImage:(id)sender;

@end


@implementation imageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]   initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    self.textField.text=self.textString;
    NSLog(@"image:%@",self.image);
    self.imageView.image=self.image;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//保存图片至沙盒
-(void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData=UIImageJPEGRepresentation(currentImage, 0.5);
    //获取沙盒目录
    
    NSString *fullPath=[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
        stringByAppendingPathComponent:imageName];
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark -image picker delegate
//用户选中图片后的回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self saveImage:image withName:@"currentImage.png"];
   
    [self.imageView setImage:image];
    
    self.imageView.tag=100;
}
//点击图像选取器中的cancel按钮时做的事情
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isFullScreen=!isFullScreen;
    UITouch *touch=[touches anyObject];
    CGPoint touchPoint=[touch locationInView:self.view];
    //touchPoint.x,touchPoint.y 就是触点的坐标
    CGPoint imagePoint=self.imageView.frame.origin;
    
    //触点在imageView内，点击imageView时放大，再次点击时缩小
    if (imagePoint.x<=touchPoint.x&&imagePoint.x+self.imageView.frame.size.width>=touchPoint.x&&imagePoint.y<=touchPoint.y&&imagePoint.y+self.imageView.frame.size.height>=touchPoint.y)
    {
        //设置图片放大动画
        [UIView beginAnimations:nil context:nil];
        //动画时间
        [UIView setAnimationDuration:1];
        if (isFullScreen) {
            //放大尺寸
            self.imageView.frame=CGRectMake(0, 0, 400, 400);
        }
        else{
            //缩小尺寸
            self.imageView.frame=CGRectMake(50, 50, 350, 300);
        }
        
        //commit动画
        [UIView commitAnimations];
    }
}

#pragma mark -actionsheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==255) {
        NSInteger souceType=0;
        
        //判断是否支持相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    //取消
                    return;
                case 1:
                    //相机
                    souceType=UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    //相册
                    souceType=UIImagePickerControllerSourceTypePhotoLibrary;//表示显示所有图片
                    break;
            }
        }
        else{
            if (buttonIndex==0) {
                return;
            }
            else{
                souceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;//表示仅仅从相册中选取图片
            }
        }
        //跳转到相机或相册页面
        UIImagePickerController *imagePickerController=[[UIImagePickerController alloc]init];
        imagePickerController.delegate=self;
        imagePickerController.allowsEditing=YES;
        imagePickerController.sourceType=souceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        
    }
}


-(IBAction)chooseImage:(id)sender
{
    UIActionSheet *sheet;
    
    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
        sheet=[[UIActionSheet alloc]
               initWithTitle:@"选择"
               delegate:self
               cancelButtonTitle:nil
               destructiveButtonTitle:@"取消"
               otherButtonTitles:@"拍照",@"从相册选择", nil];
        }
    else{
        sheet=[[UIActionSheet alloc]
               initWithTitle:@"选择"
               delegate:self
               cancelButtonTitle:nil
               destructiveButtonTitle:@"取消"
               otherButtonTitles:@"从相册选择", nil];
    }
    sheet.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    sheet.tag=255;
    [sheet showInView:self.view];
}

-(NSString *) imageDocPath
{
    
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    //return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"image.png"];
    NSLog(@" 我文件的路径是：%@",[pathList objectAtIndex:0]);
    return [pathList objectAtIndex:0];
    
}

//整个地址存放地址
-(NSString *) textDocPath
{
    NSArray *pathList = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    return [[pathList objectAtIndex:0] stringByAppendingPathComponent:@"data.txt"];
}

-(IBAction)dismissKeyboard:(id)sender
{
    [self.textField resignFirstResponder];
}

-(void)dismissKeyboard
{
    [self.textField resignFirstResponder];
}

@end
