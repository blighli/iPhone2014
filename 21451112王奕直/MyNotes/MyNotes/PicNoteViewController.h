//
//  PicNoteViewController.h
//  MyNotes
//
//  Created by alwaysking on 14/11/24.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface PicNoteViewController : UIViewController


@property (strong, nonatomic)NSString *imageNameStr;
@property (strong, nonatomic)UIImagePickerController *picker;

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,strong) NSFetchRequest *picFetchRequest;
@property (strong, nonatomic) IBOutlet UITextField* textField;

@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) IBOutlet UIButton *btnSoot;
;

- (IBAction)btnCancle:(id)sender;
- (IBAction)btnOk:(id)sender;
- (NSString *)documentsPathForFileName:(NSString *)name;
- (IBAction)reShoot:(id)sender;

@end
