//
//  PaintViewController.m
//  Project_3
//
//  Created by 王路尧 on 14/11/24.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
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
    [self.customView clearView];
}

- (IBAction)backOnClick:(UIButton *)sender {
    [self.customView backView];
}

- (IBAction)saveBtnOnClick:(UIButton *)sender {
    UIImage *newImage =    [UIImage YYcaptureImageWithView:self.customView];
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
}

@end
