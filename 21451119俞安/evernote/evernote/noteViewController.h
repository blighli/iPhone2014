//
//  noteViewController.h
//  evernote
//
//  Created by apple on 14/11/23.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
NSArray *fetchedObjects ;
NSMutableArray *contentList;
int x;
@interface noteViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *table;
- (IBAction)edit:(id)sender;
 
@end

////@protocol PassValueDelegate <NSObject>
//
//-(void)passValue:(int)value;
