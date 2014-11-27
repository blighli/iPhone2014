//
//  BoardView.h
//  MyNotes
//
//  Created by 焦守杰 on 14/11/23.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"
@interface BoardView : UIView{
    NSMutableArray  *_lineArray;
    Line *l;
    NSString *_name;
}
-(void)clear;
@property   int size;
@property   int color;
@end
