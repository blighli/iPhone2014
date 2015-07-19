//
//  PictureView.h
//  Project4
//
//  Created by xvxvxxx on 14/11/24.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureView : UIView
@property CGPoint firstTouchLocation;
@property CGPoint lastTouchLocation;
@property UIColor *currentColor;
@property NSMutableArray *pointArray;
@property NSMutableArray *lineArray;
//@property UIImage *drawPicture;

-(void)addLine;
-(BOOL)writeToFile:(NSString*)filePath;
-(void)readFromFile:(NSString*) filePath;
@end