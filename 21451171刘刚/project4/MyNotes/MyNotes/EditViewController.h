//
//  EditViewController.h
//  MyNotes
//
//  Created by liug on 14-11-22.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *notetitle;
@property (weak, nonatomic) IBOutlet UITextView *notes;
@property (weak,nonatomic) NSString  *ttile,*tnotes;
@end
