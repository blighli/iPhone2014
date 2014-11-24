//
//  DrawView.h
//  MyNotes
//
//  Created by cstlab on 14/11/12.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView

-(void)addPoint:(CGPoint) Point;
-(void)addLine;
-(void)cleartheScreenWithErase;
-(void)SetColorForLine:(NSInteger)color;
-(void)SetWidthForLine:(NSInteger)width;
-(void)BackToTheLast;
-(void)clearAll;
-(void)deleteTheLast;
@end
