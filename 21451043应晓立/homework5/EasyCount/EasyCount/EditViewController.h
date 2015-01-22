//
//  EditViewController.h
//  EasyCount
//
//  Created by yingxl1992 on 15/1/6.
//  Copyright (c) 2015年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"
#import "CustomIOS7AlertView.h"
#import "DLRadioButton.h"
#import "CollectionCell.h"
#import "TableList.h"

@interface EditViewController: UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,CustomIOS7AlertViewDelegate>
{
    NSArray *types;
    NSArray *titles;
    
    UICollectionViewCell *preCell;
    UIColor *currentColor;
    
    Record *record;
    UIColor *color;
    
    NSString *username;
    
    UIAlertView *alertView1;
    UIAlertView *alertView2;
    
    NSInteger flag;
    
    NSMutableArray *tableData;
}
@property (weak, nonatomic) IBOutlet UICollectionView *myCollection;
@property (strong, nonatomic)NSMutableArray *dataMArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *buttomRadioButtons;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@property NSString *username;
@property Record *record;
@property NSInteger flag;

@end
