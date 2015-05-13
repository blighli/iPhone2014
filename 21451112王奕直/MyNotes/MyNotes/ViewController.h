//
//  ViewController.h
//  MyNotes
//
//  Created by alwaysking on 14/11/18.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
NSMutableArray * textNoteArray;
NSMutableArray * picNoteArray;
NSMutableArray * drawNoteArray;
NSInteger tableDataRow;
BOOL tableItemClick;
int selectNote;
@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic,strong) NSFetchRequest *textFetchRequest;
@property (nonatomic,strong) NSFetchRequest *picFetchRequest;
@property (nonatomic,strong) NSFetchRequest *drawFetchRequest;

@property IBOutlet UITableView * tableViewInfo;


- (IBAction)btnTextNote:(id)sender;
- (IBAction)btnPicNote:(id)sender;
- (IBAction)btnDrawNote:(id)sender;
- (NSString *)documentsPathForFileName:(NSString *)name;
@end

