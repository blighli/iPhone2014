//
//  DrawView.h
//  MyNotes
//
//  Created by liug on 14-11-23.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
@property (nonatomic,retain) NSMutableArray *lineArray;
- (BOOL)getImageFromView:(NSString *)path;
@end
