//
//  EditImageViewController.m
//  homework4
//
//  Created by yingxl1992 on 14/11/27.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "EditImageViewController.h"

@interface EditImageViewController ()

@end

@implementation EditImageViewController
@synthesize noteList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *viewController=segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"editPicSegue"]==YES) {
        PicViewController *picViewController=(PicViewController *)viewController;
        picViewController.noteList=noteList;
    }
    else if ([segue.identifier isEqualToString:@"editPhotoSegue"]==YES) {
        PhotoViewController *photoViewController=(PhotoViewController *)viewController;
        photoViewController.noteList=noteList;
    }
}


@end
