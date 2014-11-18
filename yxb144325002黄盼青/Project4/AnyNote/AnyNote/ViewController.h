//
//  ViewController.h
//  AnyNote
//
//  Created by 黄盼青 on 14/11/17.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "NoteData.h"
#import "NoteTableViewCell.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic) NSMutableArray *noteData;//Note数据
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)pickPhotos:(UIBarButtonItem *)sender;

@end

