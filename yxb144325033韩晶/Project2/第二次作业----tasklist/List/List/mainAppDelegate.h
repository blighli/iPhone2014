//
//  mainAppDelegate.h
//  List
//
//  Created by hanxue on 14-11-7.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface mainAppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    UIButton *editButton;
    NSMutableArray *tasks;
    NSInteger *selected;
    BOOL flag;
    BOOL isEdit;
}

-(void)addTask:(id) sender;
-(void)editTask:(id) sender;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


@property (strong, nonatomic) UIWindow *window;


@end

