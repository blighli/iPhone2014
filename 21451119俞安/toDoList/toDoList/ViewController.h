//
//  ViewController.h
//  toDoList
//
//  Created by apple on 14/11/8.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
- (IBAction)addContent:(id)sender;
- (IBAction)updatecontent:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonChange;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UITextField *addText;

@end

