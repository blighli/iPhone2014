//
//  PickViewController.h
//  SXDHomeWork
//
//  Created by  sephiroth on 14/12/11.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) UIImage *image;

- (IBAction)shootPicture:(id)sender;

- (IBAction)slecetExistingPicture:(id)sender;

@end
