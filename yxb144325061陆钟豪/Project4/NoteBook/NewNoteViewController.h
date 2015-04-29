//
//  NewNoteViewController.h
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/15.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewNoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *noteContentTextView;

- (IBAction)saveNote:(id)sender;

@end
