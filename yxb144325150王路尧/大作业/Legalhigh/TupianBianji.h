//
//  TupianBianji.h
//  Legalhigh
//
//  Created by 王路尧 on 14/12/10.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"

@interface TupianBianji : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet View *paintView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;


- (IBAction)saveButton:(id)sender;
- (IBAction)backButton:(id)sender;
- (IBAction)clearButton:(id)sender;
- (IBAction)inputButton:(id)sender;

@end
