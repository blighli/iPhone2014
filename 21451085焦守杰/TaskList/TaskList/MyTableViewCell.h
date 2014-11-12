//
//  MyTableViewCell.h
//  TaskList
//
//  Created by 焦守杰 on 14/11/6.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "ViewController.h"

@interface MyTableViewCell : UITableViewCell<UIAlertViewDelegate>{
    int rowNum;         //当前cell所在的行数
}
- (IBAction)pressDel:(id)sender;
- (IBAction)pressModify:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *textField;
@property (weak) ViewController *tableViewController;
-(void)setRowNum:(int)_rowNum;
@end
