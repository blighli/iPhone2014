//
//  MainTableViewController.h
//  mynote
//
//  Created by Van on 14/11/18.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Notes.h"
@interface MainTableViewController : UITableViewController<UIWebViewDelegate>
@property (strong,nonatomic) AppDelegate *myDelegate;
@property NSManagedObjectContext *managedObjectContext;
+ (NSMutableArray *) getResult:(NSManagedObjectContext *)managedObjectContext;
+(void) deleteCell:(Notes *)note :(NSManagedObjectContext *)managedObjectContext;
@end
