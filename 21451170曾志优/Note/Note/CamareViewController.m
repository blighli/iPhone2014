//
//  CamareViewController.m
//  Note
//
//  Created by Mac on 14-11-24.
//  Copyright (c) 2014年 Mac. All rights reserved.
//


#import "CamareViewController.h"

#import <MobileCoreServices/UTCoreTypes.h>
#import "DBHelper.h"

#import "Image.h"

@interface CamareViewController ()
<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *takePictureButton;
@property (weak, nonatomic) IBOutlet UITextField *topic;

@property (weak, nonatomic) UIImage *image;


@property (strong, nonatomic)  UIImageView *imageViewFromDetail;
@property (strong, nonatomic) UIImage *imageFromDetail;

@property (strong, nonatomic) NSURL *movieURL;
@property (copy, nonatomic) NSString *lastChosenMediaType;

@property (copy,nonatomic) NSString *paramTopic;
@property (copy,nonatomic) NSData *binImage;

@end

@implementation CamareViewController

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_topic isExclusiveTouch]) {
        [_topic resignFirstResponder];
    }
  
}

- (void)viewDidLoad
{
     NSLog(@"viewDidLoad");
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera])
    {
        self.takePictureButton.hidden = YES;
    }
    _topic.text=_paramTopic;
    if(_imageFromDetail!=nil){
        _imageViewFromDetail=[[UIImageView alloc ] initWithImage:_imageFromDetail];
        _imageViewFromDetail.frame =CGRectMake(0, 0,_imageView.frame.size.width, _imageView.frame.size.height);
        NSLog(@"%@",_imageViewFromDetail);
        [_imageView addSubview:_imageViewFromDetail];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    [super viewDidAppear:animated];
    [self updateDisplay];
}


- (void)setDetailItem:(id)imageRecord
{
    
    NSLog(@"setDetailItem");
    Image *noteImage =(Image *)imageRecord;
    self.paramTopic=noteImage.topicStr;
    self.binImage = noteImage.binImage;
    
    _imageFromDetail =[UIImage imageWithData:self.binImage];
   // NSLog(@"%@",self.binImage);
   
    
}

- (IBAction)shootPictureOrVideo:(id)sender
{
     NSLog(@"shootPictureOrVideo");
    [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)selectExistingPictureOrVideo:(id)sender
{
     NSLog(@"selectExistingPictureOrVideo");
    [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)updateDisplay
{
      NSLog(@"updateDisplay");
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage]) {
        self.imageView.image = self.image;
        self.imageView.hidden = NO;
        
    }
}

- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    
    NSLog(@"pickMediaFromSource");
    NSArray *mediaTypes = [UIImagePickerController
                           availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController
         isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0) {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"Error accessing media"
                                   message:@"Unsupported media source."
                                  delegate:nil
                         cancelButtonTitle:@"Drat!"
                         otherButtonTitles:nil];
        [alert show];
    }
}


- (UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size
{
    NSLog(@"shrinkImage");
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    CGFloat originalAspect = original.size.width / original.size.height;
    CGFloat targetAspect = size.width / size.height;
    CGRect targetRect;
    
    if (originalAspect > targetAspect) {
        // original is wider than target
        targetRect.size.width = size.width;
        targetRect.size.height = size.height * targetAspect / originalAspect;
        targetRect.origin.x = 0;
        targetRect.origin.y = (size.height - targetRect.size.height) * 0.5;
    } else if (originalAspect < targetAspect) {
        // original is narrower than target
        targetRect.size.width = size.width * originalAspect / targetAspect;
        targetRect.size.height = size.height;
        targetRect.origin.x = (size.width - targetRect.size.width) * 0.5;
        targetRect.origin.y = 0;
    } else {
        // original and target have same aspect ratio
        targetRect = CGRectMake(0, 0, size.width, size.height);
    }
    
    [original drawInRect:targetRect];
    UIImage *final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return final;
}

#pragma mark - Image Picker Controller delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"didFinishPickingMediaWithInfo");
    self.lastChosenMediaType = info[UIImagePickerControllerMediaType];
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage]) {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        self.image = [self shrinkImage:chosenImage
                                toSize:self.imageView.bounds.size];
    } else if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeMovie]) {
        self.movieURL = info[UIImagePickerControllerMediaURL];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)saveButtonPressed:(UIButton *)sender {
    NSString *topicStr=self.topic.text;
    NSData *imageData;
    if (UIImagePNGRepresentation(_image) == nil) {
        imageData = UIImageJPEGRepresentation(_image, 1);
    } else {
        imageData = UIImagePNGRepresentation(_image);
    }
    
    sqlite3 *database = [DBHelper getDatabase];
    
    NSString *insertSQL = @"insert into image(topic,binImage) values(?,?)";
    sqlite3_stmt *statement;
    char *errorMsg;
    
    if(sqlite3_prepare_v2(database, [insertSQL UTF8String], -1,&statement, nil)==SQLITE_OK){
        sqlite3_bind_text(statement,1,[topicStr UTF8String],-1,NULL);
        sqlite3_bind_blob(statement,2,[imageData bytes],[imageData length],NULL);
        
    }
    if(sqlite3_step(statement)!=SQLITE_DONE){
        NSAssert(0,@"Error inserting table : %s",errorMsg);
    }
    sqlite3_finalize(statement);
    [DBHelper closeDatabase:database];
    
}



@end
