//
//  CanvasView.h
//  Project4-Note
//
//  Created by  ws on 11/20/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanvasView : UIView
@property (assign,nonatomic) CGFloat width;
@property (strong,nonatomic) UIColor *color;
//清除视图
- (BOOL) clearView;
//保存图片到文件
- (BOOL) saveToPNGFile:(NSString*) path;
@end
