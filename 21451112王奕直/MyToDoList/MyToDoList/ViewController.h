//
//  ViewController.h
//  MyToDoList
//
//  Created by alwaysking on 14/11/8.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import <UIKit/UIKit.h>
NSMutableArray *tableData;
NSInteger tableDataRow;
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property IBOutlet UITextField *textFieldData;
@property IBOutlet UITableView *tableViewData;
@property IBOutlet UIBarButtonItem *barBtnItem;
@property (nonatomic,strong) NSDictionary *dictionary;

- (void) setExtraCellLineHidden: (UITableView *)tableView;
- (IBAction) EditBtn:(id)sender;

@end


