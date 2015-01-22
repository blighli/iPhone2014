//
//  AddViewController.h
//  EasyCount
//
//  Created by yingxl1992 on 14/12/26.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionCell.h"
#import "Record.h"
#import "CustomIOS7AlertView.h"
#import "DLRadioButton.h"
#import "TableList.h"

@interface AddViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,CustomIOS7AlertViewDelegate>
{
    NSArray *types;
    NSArray *titles;

    UICollectionViewCell *preCell;
    UIColor *currentColor;
    
    Record *record;
    UIColor *color;
    
    NSString *username;
    NSString *currentDate;
    
    NSInteger flag;
    
    NSMutableArray *tableData;
}
@property (weak, nonatomic) IBOutlet UICollectionView *myCollection;
@property (strong, nonatomic)NSMutableArray *dataMArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *buttomRadioButtons;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@property NSString *username;
@property NSString *currentDate;
@property NSInteger flag;

@end
