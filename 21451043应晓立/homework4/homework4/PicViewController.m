//
//  PicViewController.m
//  homework4
//
//  Created by yingxl1992 on 14/11/26.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "PicViewController.h"

@interface PicViewController ()
@property (strong,nonatomic)  PicView *picView;
@property NSString *latitudeString,*longitudeString;
@end

@implementation PicViewController
@synthesize picView;
@synthesize sendPictureName;
@synthesize noteList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect viewFrame=self.view.frame;
    
    self.picView=[[PicView alloc]initWithFrame:viewFrame];

    [self.picView setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview: self.picView];
    [self.view sendSubviewToBack:self.picView];
    
    UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] init];
    saveBarButtonItem.title = @"保存";
    saveBarButtonItem.target = self;
    saveBarButtonItem.action = @selector(savePicture);
    self.navigationItem.leftBarButtonItem=saveBarButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clearScreen:(id)sender {
    [self.picView clear];
}

- (void)savePicture{
    
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"保存手绘" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark --UIAlertViewDelegate--
-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //得到输入框
    if (buttonIndex == 0) {
        UIGraphicsBeginImageContext(picView.bounds.size);
        [picView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        noteList.image=UIImageJPEGRepresentation(image, 100);
        
        AddListViewController *addListViewController=[[AddListViewController alloc]init];
        EditImageViewController *editImageViewController=[[EditImageViewController alloc]init];
        addListViewController.noteList=noteList;
        editImageViewController.noteList=noteList;
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
