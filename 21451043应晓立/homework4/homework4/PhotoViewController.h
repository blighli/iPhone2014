//
//  PhotoViewController.h
//  homework4
//
//  Created by yingxl1992 on 14/11/26.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteList.h"
#import "AddListViewController.h"
#import "EditImageViewController.h"

@interface PhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    NoteList *noteList;
    UIImageView *contentimageview;
    NSString *lastChosenMediaType;
    
    UIAlertView *alert1;
    UIAlertView *alert2;
}
@property NoteList *noteList;
@property(nonatomic,retain) IBOutlet UIImageView *contentimageview;
@property(nonatomic,copy) NSString *lastChosenMediaType;
-(IBAction)buttonclick:(id)sender;
@end
