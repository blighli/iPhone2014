//
//  NoteDetailViewController.h
//  homework4
//
//  Created by yingxl1992 on 14/11/16.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteList.h"
#import "DetailEditViewController.h"

@interface NoteDetailViewController : UIViewController<UINavigationBarDelegate>
{
    NoteList *currentNotelist;
}
@property (weak, nonatomic) IBOutlet UITextField *tf_title;
@property (weak, nonatomic) IBOutlet UITextView *tv_content;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property NoteList *currentNotelist;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btn_edit;

@end
