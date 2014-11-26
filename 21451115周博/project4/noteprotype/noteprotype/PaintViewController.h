//
//  PaintViewController.h
//  ;
//
//  Created by zhou on 14/11/24.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "Paint.h"

@interface PaintViewController : UIViewController

// =====
// these properties is init in the segue when linking to this viewController.
// =====

@property Note* note;

//used only in update mode
@property  Paint* paint; // the paint to update
@property BOOL isUpdate; // to judge whether in update mode
@end
