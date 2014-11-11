 //
//  ViewController.h
//  TaskList
//
//  Created by 焦守杰 on 14/11/6.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
NSString *docPath(void);
@interface ViewController : UIViewController<UITableViewDataSource,UIApplicationDelegate>{
    NSMutableArray *task;
    NSString *finalPath;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
-(IBAction)pressButton:(id)sender;

-(void) deleteObjectAt:(int) _index;
-(void) modifyObject:(NSString*)s At:(int)index;


@end

