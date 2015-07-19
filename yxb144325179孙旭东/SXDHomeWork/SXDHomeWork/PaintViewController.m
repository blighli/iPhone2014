//
//  PaintViewController.m
//  SXDHomeWork
//
//  Created by  sephiroth on 14/12/11.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import "PaintViewController.h"
#import "YYView.h"
#import "UIImage+YYcaptureView.h"
#import "Constants.h"

@interface PaintViewController ()
- (IBAction)saveButton:(id)sender;

- (IBAction)backButton:(id)sender;

- (IBAction)clearButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet YYView *paintView;


@end

@implementation PaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.paintView.backgroundColor=[UIColor clearColor];
    _paintView.backgroundColor=[UIColor clearColor];
    self.imageView.image=self.image;
    [self.paintView clearView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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


- (IBAction)changeColor:(id)sender {
    UISegmentedControl *control=sender;
    ColorTabIndex index=[control selectedSegmentIndex];
    YYView *funView=self.paintView;
    
    switch (index) {
        case kRedColorTab:
            funView.color=[UIColor redColor];
            break;
        case kBuleColorTab:
            funView.color=[UIColor blueColor];
            break;
        case kGreenColorTab:
            funView.color=[UIColor greenColor];
            break;
        default:
            funView.color=[UIColor blackColor];
            break;
    }
}
@end
