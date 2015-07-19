//
//  PictureViewController.h
//  NoteBook
//
//  Created by 陈晟豪 on 14/11/26.
//  Copyright (c) 2014年 Cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *pictureNavigationBar;
@property (weak, nonatomic) IBOutlet UITextView *pictureTextView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UITextField *pictureTitle;

- (IBAction)clickCancelButton:(id)sender;
@end
