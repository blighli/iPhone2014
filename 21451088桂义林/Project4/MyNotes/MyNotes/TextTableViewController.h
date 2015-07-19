//
//  ViewController.h
//  MyNotes
//
//  Created by YilinGui on 14-11-22.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *myTableView;
    NSMutableArray* textNotes;
}

@end

