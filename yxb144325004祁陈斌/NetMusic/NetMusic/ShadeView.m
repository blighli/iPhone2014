//
//  ShadeView.m
//  NetMusic
//
//  Created by xsdlr on 14/12/4.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "ShadeView.h"

@implementation ShadeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded ShadeView");
    [super touchesEnded:touches withEvent:event];
    [self.delegate qTouchesEnded:touches withEvent:event];
}
@end
