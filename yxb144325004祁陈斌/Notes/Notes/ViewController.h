//
//  ViewController.h
//  Notes
//
//  Created by xsdlr on 14/11/17.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray* notes;
- (IBAction)takePhoto:(UIBarButtonItem *)sender;

@end

