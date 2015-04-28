//
//  ShadeViewDelegate.h
//  NetMusic
//
//  Created by xsdlr on 14/12/4.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShadeViewDelegate <NSObject>
/**
 *  触摸结束
 *
 *  @param touches UITouch的集合
 *  @param event   事件
 */
- (void)qTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
@end
