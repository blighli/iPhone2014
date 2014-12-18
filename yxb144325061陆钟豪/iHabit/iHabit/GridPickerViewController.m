//
//  GridPicker.m
//  iHabit
//
//  Created by xsdlr on 14/12/17.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "GridPickerViewController.h"

@implementation GridPickerViewController
{
    NSMutableArray* _cellViews;
    UIView *_selectedView;
}

-(void)viewDidLoad {
    _selectedView = [[UIView alloc] init];
    _selectedView.backgroundColor = UIColor.grayColor;
    [_selectedView.layer setCornerRadius:8];
    [self.view addSubview:_selectedView];
}

-(void)addCellView:(UIView *)view {
    if(_cellViews == nil){
        _cellViews = [[NSMutableArray alloc] init];
    }
    [_cellViews addObject:view];
    [self.view addSubview:view];
}

-(void)layoutCellViews{
    NSInteger i = 0;
    UIView* preView = nil;
    UIView* preRowFirstView = nil;
    for(UIView* view in _cellViews) {
        NSInteger numInRow = i % self.numberOfCellInRow;
        NSInteger row = i / self.numberOfCellInRow;
        if(row > 1 && numInRow == 0) preRowFirstView = preView;
        CGFloat preCellRightX = numInRow == 0 ? 0 : preView.frame.origin.x + preView.frame.size.width;
        CGFloat preRowBottomY = row == 0 ? 0 : preRowFirstView.frame.origin.y + preRowFirstView.frame.size.height;
        CGRect frame = view.frame;
        frame.origin.x = preCellRightX + self.horizontalSpace;
        frame.origin.y = preRowBottomY + self.verticalSpace;
        view.frame = frame;
        preView = view;
        ++i;
    }
}

-(void)selectCellView:(UIView*) cellView{
    // TODO 加动画
    _selectedView.frame = cellView.frame;
}

-(void)selectCellViewWithIndex:(NSInteger)index{
    [self selectCellView:[_cellViews objectAtIndex:index]];
}

@end
