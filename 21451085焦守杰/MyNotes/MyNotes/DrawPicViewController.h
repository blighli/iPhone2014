//
//  DrawPicViewController.h
//  MyNotes
//
//  Created by 焦守杰 on 14/11/23.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseUtil.h"
#import "BoardViewController.h"
@interface DrawPicViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
    DatabaseUtil *_dbu;
    NSMutableArray *showData;
    NSString *thumbPath;
    NSString *picPath;
    
}

@end
