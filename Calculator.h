//
//  Calculator.h
//  Project1
//
//  Created by 江山 on 10/10/14.
//  Copyright (c) 2014 江山. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Calculator: NSObject{
    
}
-(int) yearCal: (int)year;

-(int) monthCal: (int)year :(int)month;

-(BOOL) isLeap: (int)year;

@end
