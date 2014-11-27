//
//  TextNoteController.h
//  MyNotes
//
//  Created by 焦守杰 on 14/11/14.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseUtil.h"

@interface TextNoteController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    DatabaseUtil *_dbu;
    NSMutableArray *showData;
    UITableView *tv;
}

@end
