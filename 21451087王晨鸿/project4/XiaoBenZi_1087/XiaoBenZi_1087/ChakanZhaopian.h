//
//  ChakanZhaopian.h
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-22.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//


#import<UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

#import <MobileCoreServices/UTCoreTypes.h>

@interface ChakanZhaopian : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    IBOutlet UIButton* takePictureButton;
    IBOutlet UIButton* saveButton;
    IBOutlet UIButton* deleteButton;
    IBOutlet UIImageView * imageView;
    IBOutlet UITextField * titleField;
    UIImage * image;
}
@property (strong, nonatomic) MPMoviePlayerController *moviePlayerController;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *movieURL;
@property (copy, nonatomic) NSString *lastChosenMediaType;
@end