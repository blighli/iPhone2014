//
//  ItemViewController.h
//  listdemo
//
//  Created by rth on 14/11/9.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemViewController;
@class ListItem;

@protocol ItemViewControllerDelegate <NSObject>
-(void)ItemViewControllerDidCancel:(ItemViewController*)controller;

-(void)ItemViewController:(ItemViewController *)controller didFinishAddingItem:(ListItem *)item;  //增加元素

-(void)ItemViewcontroller:(ItemViewController*)controller
           didFinishEditingItem:(ListItem*)item;  //修改元素

@end

@interface ItemViewController : UITableViewController<UITextFieldDelegate>

@property(nonatomic,weak) id <ItemViewControllerDelegate> delegate;

- (IBAction)Done:(id)sender;


- (IBAction)Cancel:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property(nonatomic,strong) ListItem *itemToEdit;

@end
