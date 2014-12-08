//
//  ShadeView.h
//  NetMusic
//
//  Created by xsdlr on 14/12/4.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShadeViewDelegate.h"

@interface ShadeView : UIView
@property (nonatomic, assign)   id <ShadeViewDelegate>   delegate;
@end
