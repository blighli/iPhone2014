//
//  Cal.h
//  Project1
//
//  Created by Cocoa on 14-10-7.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject{
@private
    NSCalendar *gregorian;
}

- (void)printCalendar:(NSUInteger)year andMonth: (NSUInteger)month;
@end
