//
//  DXSemiTableViewController.h
//  MyMusicPlayer
//
//  Created by 张榕明 on 15/01/01.
//  Copyright (c) 2015年 张榕明. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DXSemiViewController.h"

@interface DXSemiTableViewController : DXSemiViewController<UITableViewDataSource, UITableViewDelegate>
{
    CGFloat _currentMaxDisplayedSection;
    CGFloat _currentMaxDisplayedCell;
}

@property (nonatomic, strong) UITableView *semiTableView;
@property (nonatomic, strong) UILabel *semiTitleLabel;
@property (nonatomic, strong) NSMutableArray *dateSourceArray;

@property (nonatomic, assign) CGFloat titleLabelHeight;
@property (nonatomic, assign) CGFloat cellAnimationDuration;
@property (nonatomic, assign) CGFloat tableViewRowHeight;

@end
