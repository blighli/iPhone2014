//
//  todoListTableViewCell.h
//  toDoList
//
//  Created by LFR on 14/11/11.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface todoListTableViewCell : UITableViewCell <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView* textView;
@property (strong, nonatomic) NSIndexPath* indexPath;


@end
