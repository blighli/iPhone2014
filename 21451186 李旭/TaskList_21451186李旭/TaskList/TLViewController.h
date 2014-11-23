//
//  ViewController.h
//  TaskList
//
//  Created by lixu on 14/11/8.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLViewController : UIViewController
{
    NSMutableArray *tasks;
}

@property (weak, nonatomic) IBOutlet UITableView *taskTable;
@property (weak, nonatomic) IBOutlet UITextField *taskField;
- (IBAction)addTask:(id)sender;

@end

