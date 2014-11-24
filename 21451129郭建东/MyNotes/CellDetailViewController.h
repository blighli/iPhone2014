//
//  CellDetailViewController.h
//  MyNotes
//
//  Created by cstlab on 14/11/21.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Modeldata.h"
@interface CellDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *titel;
@property (strong, nonatomic) IBOutlet UITextView *contentview;
@property(nonatomic,assign)Modeldata *data;
@end
