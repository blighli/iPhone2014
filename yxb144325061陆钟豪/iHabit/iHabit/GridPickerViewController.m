//
//  GridPicker.m
//  iHabit
//
//  Created by xsdlr on 14/12/17.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import "GridPickerViewController.h"
#import <objc/runtime.h>

@implementation GridPickerViewController
{
    NSMutableArray* _cellViews;
    UIView *_selectedView;
    UIView *_selectedCellView;
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
        if(row >= 1 && numInRow == 0)
            preRowFirstView = preView;
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
    UIView *selectedView = objc_getAssociatedObject(self, "selectedViewFrame");
    [UIView animateWithDuration:0.2f animations:^{
        if(selectedView == nil){
            _selectedView.frame = cellView.frame;
        }
        else {
            _selectedView.frame = [cellView convertRect:selectedView.frame toView:self.view];
            NSLog(@"_selectedView.frame %f,%f,%f,%f", _selectedView.frame.origin.x, _selectedView.frame.origin.y, _selectedView.frame.size.width, _selectedView.frame.size.height);
        }
    }];
    _selectedCellView = cellView;
}

-(void)selectCellViewWithIndex:(NSInteger)index {
    [self selectCellView:[_cellViews objectAtIndex:index]];
}

-(UIView *)selectedCellView {
    return _selectedCellView;
}

-(NSInteger)selectedCellViewIndex {
    return [_cellViews indexOfObject:_selectedCellView];
}

@end
