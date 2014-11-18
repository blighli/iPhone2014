//
//  DrawView.h
//  Notes
//
//  Created by xsdlr on 14/11/18.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawView : UIView
@property (assign,nonatomic) CGFloat width;
@property (strong,nonatomic) UIColor *color;
//清除视图
- (BOOL) clearView;
//保存图片到文件
- (BOOL) saveToPNGFile:(NSString*) path;
@end
