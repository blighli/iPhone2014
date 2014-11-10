//
//  AppDelegate.h
//  A3_WCH21451087
//
//  Created by qtsh on 14-11-8.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString* docpath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    UIButton *queryButton;
    UIButton *deleteButton;
    UIButton *changeButton;
    NSMutableArray *tasks;
    int deleteState;
    int changeState;
    NSMutableString * preText;
    int currentSearchPosition;
}
- (void)addTask: (id)sender;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic)UITableView *taskTable;


@end

