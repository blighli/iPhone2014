//
//  ViewController.h
//  Project4-Note
//
//  Created by  ws on 11/20/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* mynotes;

@end

