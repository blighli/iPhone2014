//
//  PicNoteViewController.h
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/16.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteEntity.h"

@interface PicNoteDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *noteImageView;
@property (strong, nonatomic) NoteEntity *noteEntity;

@end
