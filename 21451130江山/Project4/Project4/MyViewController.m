//
//  MyViewController.m
//  Project4
//
//  Created by 江山 on 1/8/15.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)setTextfield:(UITextField *)textfield
{
    if(!textfield) {
        _textfield = [[UITextField alloc] init];
    }
    else {
        _textfield = textfield;
    }
}

- (void)setTextview:(UITextView *)textview
{
    if(!textview) {
        _textview = [[UITextView alloc] init];
    }
    else {
        _textview = textview;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_textfield release];
    [_textview release];
    [super dealloc];
}

- (IBAction)takephoto:(id)sender {
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = sourceType;
    [self presentModalViewController:picker animated:YES];//进入照相界面
    [picker release];
}

- (IBAction)save:(id)sender {
    NSLog(@"save the new note");
}
@end
