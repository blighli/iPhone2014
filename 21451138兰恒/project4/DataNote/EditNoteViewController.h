//
//  EditNoteViewController.h
//  EverNote
//
//  Created by lh on 14-11-26.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "passImageValueDelegate.h"
@interface EditNoteViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>
@property(nonatomic,strong)UITextField *noteTitle;
@property(nonatomic,strong)UITextView *noteContent;
@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)NSString *noteDate;
@property(nonatomic,strong)UITableView *myTable;
@property(nonatomic,assign)NSObject<passImageValueDelegate> *delegate;
@end
