//
//  DetailPhotoViewController.m
//  PictureFilter
//
//  Created by 陈晟豪 on 14/12/22.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import "DetailPhotoViewController.h"
#import "PhotoBeautify.h"

@interface DetailPhotoViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *detailPhotoNavigationBar;
@property (retain, nonatomic) IBOutlet UINavigationItem *detailPhotoNavigationItem;
@property (weak, nonatomic) IBOutlet UIImageView *detailPhotoImageView;

@end

@implementation DetailPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建一个导航栏集合
    self.detailPhotoNavigationItem = [[UINavigationItem alloc] initWithTitle:@"预览"];
    
    //创建一个左边按钮
    self.detailPhotoNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil
                                                                                        style:UIBarButtonItemStyleDone
                                                                                       target:self
                                                                                       action:@selector(clickCancelButton:)];
    
    [self.detailPhotoNavigationItem.leftBarButtonItem setImage:[UIImage imageNamed:@"BackButton"]];
    
    [self.detailPhotoNavigationBar pushNavigationItem:self.detailPhotoNavigationItem animated:NO];
    
    self.detailPhotoImageView.contentMode = UIViewContentModeScaleAspectFit;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    //修改状态栏文字颜色
    return UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateDisplay];
}

- (void)updateDisplay
{
    self.detailPhotoImageView.image = self.image;
}

- (IBAction)clickCancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
