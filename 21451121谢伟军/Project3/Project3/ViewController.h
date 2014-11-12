//
//  ViewController.h
//  Project3
//
//  Created by xvxvxxx on 14/11/9.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *taskTable;

@property (strong, nonatomic) IBOutlet UITextField *taskField;
//
@property (strong, nonatomic) IBOutlet UIButton *insertButton;
@property (nonatomic) NSMutableArray* tasks;

- (IBAction)addTask:(UIButton *)sender;

-(NSString *)docPath;
-(void) readFile;
@end

