//
//  TupianBianji.m
//  Legalhigh
//
//  Created by 王路尧 on 14/12/10.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import "TupianBianji.h"
#import "UIImage+YYcaptureView.h"
#import "View.h"

@implementation TupianBianji

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.paintView.backgroundColor=[UIColor clearColor];
    self.imageView.image=self.image;
}

- (IBAction)saveButton:(id)sender {
    UIImage *newImage =    [UIImage YYcaptureImageWithView:self.paintView AndImageView:self.imageView];
    //将图片保存到手机的相册中去
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);}

- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否保存图片"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)backButton:(id)sender {
    //[self.paintView backView];
    [self.view removeFromSuperview];
}

- (IBAction)clearButton:(id)sender {
    [self.paintView backView];
}

- (IBAction)inputButton:(id)sender {
    [self.paintView inputView];
}

@end
