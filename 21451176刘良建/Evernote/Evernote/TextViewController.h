//
//  TextViewController.h
//  Evernote
//
//  Created by JANESTAR on 14-11-15.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,NSFetchedResultsControllerDelegate>

@property(nonatomic,retain)UITableView* myTableView;

@end
