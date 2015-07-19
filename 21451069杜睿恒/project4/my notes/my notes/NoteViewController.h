//
//  NoteViewController.h
//  my notes
//
//  Created by shazhouyouren on 14/11/15.
//  Copyright (c) 2014年 shazhouyouren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteDB.h"
@interface NoteViewController : UIViewController<UIAlertViewDelegate>
{
    bool isModify;
}
-(void)initNewNote;
-(void)initViewNote;
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void)showAlert;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property NSString* tvText;
@property bool editable;
@property NoteDB* noteDB;
@property NSNumber* noteid;

@end

