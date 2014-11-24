//
//  Camera1ViewController.m
//  MyNotes
//
//  Created by cstlab on 14/11/14.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "Camera1ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>



@interface Camera1ViewController ()
@property(strong,nonatomic) MPMoviePlayerController *moviePlayerController;
@property(strong,nonatomic)UIImage *image;
@property(strong,nonatomic)NSURL *movieURL;
@property(strong,nonatomic)NSString *lastChosenMediaType;

@end

@implementation Camera1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
       // self.TakePhoto.hidden = YES;
        
    }
    // Do any additional setup after loading the view from its nib.
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateDisplay];
}
- (IBAction)GetCameraPhoto:(id)sender {
    [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)SelectExistingPhoto:(id)sender {
    [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}


-(void)updateDisplay
{
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage]) {
        self.imageView.image = self.image;
        self.imageView.hidden = NO;
        self.moviePlayerController.view.hidden = YES;
    }else if ([self.lastChosenMediaType isEqual:(NSString*)kUTTypeMovie])
    {
        [self.moviePlayerController.view removeFromSuperview];
        self.moviePlayerController = [[MPMoviePlayerController alloc]initWithContentURL:self.movieURL];
        [self.moviePlayerController play];
        UIView *movieView = self.moviePlayerController.view;
        movieView.frame = self.imageView.frame;
        movieView.clipsToBounds = YES;
        [self.view addSubview:movieView];
        self.imageView.hidden = YES;
    }
}

-(void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]&&[mediaTypes count]>0) {
        NSArray *mediaTypes =[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
        
    }else {
        /*
        UIAlertView *Alert = [[[UIAlertView alloc]initWithTitle:@"Cann't Access The Media" message:@"Your Device Doesn't support that Media Source" delegate:nil cancelButtonTitle:@"Cancle" otherButtonTitles:nil];
        [Alert show];
         */
        UIAlertView *Alert = [[UIAlertView alloc]initWithTitle:@"Error Accessing media" message:@"Unsupport media source" delegate:nil cancelButtonTitle:@"Cancle" otherButtonTitles:nil];
        [Alert show];
    }
}

-(UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [original drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *Image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  Image;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.lastChosenMediaType = info[UIImagePickerControllerMediaType];
    if ([self.lastChosenMediaType isEqual:(NSString*)kUTTypeImage]) {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        UIImage *shrinkImage = [self shrinkImage:chosenImage toSize:self.imageView.bounds.size];
        self.image = shrinkImage;
    }else if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeMovie])
    {
        self.movieURL = info[UIImagePickerControllerMediaURL];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES  completion:NULL];
}



@end
