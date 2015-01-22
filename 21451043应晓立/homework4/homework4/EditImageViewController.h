//
//  EditImageViewController.h
//  homework4
//
//  Created by yingxl1992 on 14/11/27.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteList.h"
#import "PicViewController.h"
#import "PhotoViewController.h"
#import "DetailEditViewController.h"

@interface EditImageViewController : UIViewController<UINavigationBarDelegate>
{
    NoteList *noteList;
}
@property NoteList *noteList;

@end
