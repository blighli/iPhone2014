//
//  AppDelegate.h
//  Tasklist
//
//  Created by C.C.R on 14/11/6.
//  Copyright (c) 2014年 TOM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <Foundation/Foundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    UIButton *editButton;
    NSMutableArray *tasks;
    NSIndexPath* selected;
    BOOL flag;
    BOOL isEdit;
    BOOL isFocus;
}


-(void)reloadcellbackground:(NSIndexPath *)indexPath;
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
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;


@property (strong, nonatomic) UIWindow *window;


@end

