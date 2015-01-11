//
//  NoteDetailViewController.h
//  NoteBook
//
//  Created by hyb on 14/12/20.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteEntity.h"

@interface NoteDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *noteContentTextView;
@property (strong, nonatomic) NoteEntity *noteEntity;
- (IBAction)modifyNote:(id)sender;

@end
