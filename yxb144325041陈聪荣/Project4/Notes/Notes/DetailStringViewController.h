//
//  DetailController.h
//  Notes
//
//  Created by 陈聪荣 on 14/11/18.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Note.h"
#import "NoteDao.h"
#import "NoteBiz.h"

@interface DetailStringViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UITextView *txtView;
- (IBAction)returnClick:(id)sender;
- (IBAction)saveOnclick:(id)sender;

@end
