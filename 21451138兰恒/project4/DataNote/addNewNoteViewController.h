//
//  addNewNoteViewController.h
//  DataNote
//
//  Created by lh on 14-11-27.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "passImageValueDelegate.h"
@interface addNewNoteViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,passImageValueDelegate>

@property(nonatomic,retain)NSMutableArray *ImageArray;
@property(nonatomic,strong)UITableView *imageTable;
@property(nonatomic,strong)UITextField *noteTitle;
@property(nonatomic,strong)UITextView *notetext;
@end

