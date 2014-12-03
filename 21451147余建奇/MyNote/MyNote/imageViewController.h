//
//  imageViewController.h
//  MyNote
//
//  Created by yjq on 14/11/15.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(weak,nonatomic)IBOutlet UIImageView *imageView;
@property(weak,nonatomic)IBOutlet UITextField *textField;
@property(copy,nonatomic)NSString *textString;//存放tabelview中是图片文本cell传来的标题
@property(strong,nonatomic)UIImage *image;//存放tabelview中是图片文本cell传来的图片
-(NSString *) imageDocPath;
-(NSString *) textDocPath;
@end
