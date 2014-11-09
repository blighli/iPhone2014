//
//  Stack.h
//  Express
//
//  Created by Mac on 14-11-6.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
{
  
    int top;
}
@property(nonatomic,strong) NSMutableArray* base;
-(id) init;
-(BOOL) empty;
-(void) push:(id) element;
-(void) pop;
-(id) top;
-(int) size;
@end
