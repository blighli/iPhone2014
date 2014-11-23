//
//  PaintViewController.m
//  Project3
//
//  Created by  sephiroth on 14/11/19.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import "PaintViewController.h"
#import "YYView.h"
#import "UIImage+YYcaptureView.h"


@interface PaintViewController ()
- (IBAction)clearOnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet YYView *customView;
-(IBAction)backOnClick:(UIButton *)sender;
- (IBAction)saveBtnOnClick:(UIButton *)sender;@end

@implementation PaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearOnClick:(UIButton *)sender {
//调用清理方法
    [self.customView clearView];
    }

- (IBAction)backOnClick:(UIButton *)sender {
   //调用回退方法
    [self.customView backView];
 }

- (IBAction)saveBtnOnClick:(UIButton *)sender {
  //调用分类中的方法，获取图片
   UIImage *newImage =    [UIImage YYcaptureImageWithView:self.customView];
     //将图片保存到手机的相册中去
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
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
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
