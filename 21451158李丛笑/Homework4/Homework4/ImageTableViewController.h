//
//  ImageTableViewController.h
//  Homework4
//
//  Created by 李丛笑 on 15/1/9.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *imagetableView;
- (IBAction)newImage:(id)sender;

@end
