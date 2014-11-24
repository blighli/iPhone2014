//
//  PhotoViewController.h
//  Project4
//
//  Created by xvxvxxx on 14/11/23.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Note.h"
@interface PhotoViewController : UIViewController <UIImagePickerControllerDelegate>

@property Note *note;
@property NSURL *photoURL;
@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property UIImage *image;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *shootPhotoButton;
@property NSString *lastChosenMediaType;


-(instancetype)initWithNote:(Note *)note;
- (IBAction)shootPhoto:(UIBarButtonItem *)sender;
- (IBAction)selectPhoto:(UIBarButtonItem *)sender;
-(void)updateDisplay;

@end
