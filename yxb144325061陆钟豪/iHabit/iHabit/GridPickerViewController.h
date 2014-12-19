//
//  GridPicker.h
//  iHabit
//
//  Created by xsdlr on 14/12/17.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridPickerViewController : UIViewController

@property NSInteger numberOfCellInRow;
@property CGFloat horizontalSpace;
@property CGFloat verticalSpace;
@property (readonly) UIView *selectedCellView;
@property (readonly) NSInteger selectedCellViewIndex;

-(void)addCellView:(UIView *)view;
-(void)layoutCellViews;
-(void)selectCellView:(UIView*) cellView;
-(void)selectCellViewWithIndex:(NSInteger)index;

@end
