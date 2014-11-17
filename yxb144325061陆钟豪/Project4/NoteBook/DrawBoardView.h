//
//  DrawBoardView.h
//  NoteBook
//
//  Created by 陆钟豪 on 14/11/17.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawBoardView : UIView

@property (strong, nonatomic) UIColor *drawColor;

-(BOOL)writeToFile:(NSString*) filePath;
-(void)readFromFile:(NSString*) filePath;

@end

@interface DrawPoint : NSObject<NSCoding>
@property (nonatomic) CGPoint point;
-(instancetype) initWithCGPoint:(CGPoint)point;
@end


@interface DrawStroke : NSObject<NSCoding>
@property (nonatomic)CGMutablePathRef pathRef;
@property (strong, nonatomic)NSMutableArray* drawPoints;
-(instancetype)initWithStartCGPoint:(CGPoint)point;
-(void)addCGPoint:(CGPoint)point;
-(void)drawContext:(CGContextRef)context;
@end
