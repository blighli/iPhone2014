//
//  ImageListTableViewController.h
//  Notes
//
//  Created by apple on 14-11-24.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageListTableViewController : UITableViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

// todolist 每一项
@property NSMutableArray* imageItems;

// 选中了哪一行
@property int selectedItem;

// 导入数据
- (void)loadListData;

@end
