//
//  PickViewController.m
//  SXDHomeWork
//
//  Created by  sephiroth on 14/12/11.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import "PickViewController.h"

@interface PickViewController ()

@end

@implementation PickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.imageView.image=self.image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shootPicture:(id)sender
{
    [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)slecetExistingPicture:(id)sender
{
    [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
