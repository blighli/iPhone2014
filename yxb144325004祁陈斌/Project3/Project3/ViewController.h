//
//  ViewController.h
//  Project3
//
//  Created by xsdlr on 14/11/6.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tasks;

- (void) saveFile:(NSString*) name;

@end

