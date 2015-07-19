//
//  ViewController.h
//  project4
//
//  Created by zack on 14-11-22.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Note.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *notesTableView;
- (IBAction)takePhoto:(id)sender;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSMutableArray *notesArray;

@end
