//
//  CreateDrawViewController.h
//  MyNotes
//
//  Created by liug on 14-11-16.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"
@interface CreateDrawViewController : UIViewController{
    sqlite3 *db;
}

@end
