//
//  NoteDetailViewController.h
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/16.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteEntity.h"

@interface NoteDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *noteContentTextView;
@property (strong, nonatomic) NoteEntity *noteEntity;
- (IBAction)modifyNote:(id)sender;

@end
