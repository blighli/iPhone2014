//
//  NoteDetailViewController.h
//  EverNote
//
//  Created by lh on 14-11-26.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "passImageValueDelegate.h"
@interface NoteDetailViewController : UIViewController<UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,passImageValueDelegate>
@property (nonatomic,strong)UILabel *noteTitle;
@property (nonatomic,strong)UITextView *notetext;
@property (nonatomic,strong)NSArray *imageArray;
@property (nonatomic,strong)NSString *noteDate;
@end
