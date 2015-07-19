//
//  ViewController.m
//  HFYHomeWork
//
//  Created by  Mac on 14/12/6.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "View.h"
#import "UIImage+YYcaptureView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet View *paintView;
@property(nonatomic,strong)NSMutableArray *paths;
@end

@implementation ViewController


- (IBAction)shootPicture:(id)sender
{
    [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)slectExistingPicture:(id)sender
{
    [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)saveButton:(id)sender {
    UIImage *newImage =    [UIImage YYcaptureImageWithView:self.paintView AndImageView:self.imageView];
    //将图片保存到手机的相册中去
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);}



- (void)viewDidLoad {
    [super viewDidLoad];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        _takePictureButton.hidden=YES;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _paintView.backgroundColor=[UIColor clearColor];
    self.imageView.image=self.image;
    UIGraphicsBeginImageContext(self.view.frame.size);
    [self.paintView clearView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)backButton:(id)sender {
    [self.paintView backView];
}

- (IBAction)clearButton:(id)sender {
    [self.paintView clearView];
}


- (UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    CGFloat originalAspect=original.size.width/original.size.height;
    CGFloat targetAspect=size.width/size.height;
    CGRect targetRect;
    
    if (originalAspect>targetAspect) {
        targetRect.size.width=size.width;
        targetRect.size.height=size.height*targetAspect/originalAspect;
        targetRect.origin.x=0;
        targetRect.origin.y=(size.height-targetRect.size.height)*0.5;
    }
    else if (originalAspect<targetAspect)
    {
        targetRect.size.width=size.width*originalAspect/targetAspect;
        targetRect.size.height=size.height;
        targetRect.origin.x=(size.width-targetRect.size.width)*0.5;
        targetRect.origin.y=0;
    }
    else
    {
        targetRect=CGRectMake(0, 0, size.width, size.height);
    }
    
    [original drawInRect:targetRect];
    UIImage *final=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return final;
}


- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]&&[mediaTypes count]>0) {
        NSArray *mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.mediaTypes=mediaTypes;
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error accessing media" message:@"Unsupported media source." delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage=info[UIImagePickerControllerEditedImage];
    self.image=[self shrinkImage:chosenImage toSize:self.imageView.bounds.size];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}



@end
