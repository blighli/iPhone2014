//
//  CameraViewController.m
//  MyNotes
//
//  Created by hu on 14/11/14.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * imagepicker  = [[UIImagePickerController alloc] init];
        imagepicker.delegate = self;
        imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagepicker animated:YES completion:nil];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage * originalimage = info[UIImagePickerControllerOriginalImage];
    self.cameraimageview.image = originalimage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
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
