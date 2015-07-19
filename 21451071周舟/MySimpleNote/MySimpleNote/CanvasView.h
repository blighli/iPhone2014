//
//  CanvasView.h
//  MySimpleNote
//
//  Created by 周舟 on 24/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//#######################################################

@interface CanvasView : UIView
@property (assign,nonatomic) CGFloat width;
@property (strong,nonatomic) UIColor *color;
//清除视图
- (BOOL) clearView;
//保存图片到文件
- (BOOL) saveToPNGFile:(NSString*) path;
@end
