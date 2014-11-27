//
//  ModifyTextNoteViewController.h
//  MyNotes
//
//  Created by 焦守杰 on 14/11/16.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteData.h"
#import "DatabaseUtil.h"
@interface ModifyTextNoteViewController : UIViewController{
    DatabaseUtil *_dbu;
    UITextView *_textView;
}

- (IBAction)clickCancelButton:(id)sender;
- (IBAction)clickModifyButton:(id)sender;

//-(id)initWithTextViewContent:(NSString*)s;
//@property (strong,nonatomic) NSString* textViewContent;
@property  (strong,nonatomic) NoteData *textNoteData;

@end
