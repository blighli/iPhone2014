//
//  AddListViewController.h
//  homework4
//
//  Created by yingxl1992 on 14/11/20.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "NoteDB.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "PicViewController.h"
#import "PhotoViewController.h"
#import "NoteList.h"

@interface AddListViewController : UIViewController<UINavigationBarDelegate,UIAlertViewDelegate,UIImagePickerControllerDelegate>
{
    sqlite3 *database;
    UIImage *pic;
    NoteList *noteList;
}
@property NoteList *noteList;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *tf_title;
@property (weak, nonatomic) IBOutlet UITextView *tv_content;
@property UIImage *pic;

@end
