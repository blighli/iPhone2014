//
//  TextNoteViewController.h
//  MyNotes
//
//  Created by alwaysking on 14/11/23.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TextNoteViewController : UIViewController

@property IBOutlet UITextView *textView;
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,strong) NSFetchRequest *textFetchRequest;

- (IBAction) cancelBtn:(id)sender;
- (IBAction) okBtn:(id)sender;


@end
