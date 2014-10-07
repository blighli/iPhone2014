//
//  main.m
//  Project1
//
//  Created by Mz on 14-10-7.
//  Copyright (c) 2014年 Zorro M. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCalendar.h"

// Add exctention to NSArray
@interface NSArray (ArgumentConvenience)
+ (NSArray *) arrayWithArguments:(const char *[]) argv
                           count:(int) argc;
@end

@implementation NSArray (ArgumentConvenience)
+ (NSArray *)arrayWithArguments:(const char *[])argv count:(int)argc {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:argc];
    for (int i = 1; i < argc; i++) {
        [array addObject:[NSString stringWithCString:argv[i]
                                            encoding:NSASCIIStringEncoding]];
    }
    return array;
}
@end

void systemcal(NSArray *args) {
    NSMutableString *cmd = [NSMutableString stringWithString: @"cal"];
    for (NSString *arg in args) {
        [cmd appendFormat:@" %@", arg];
    }
    NSLog(@"%@", cmd);
    system([cmd cStringUsingEncoding:NSASCIIStringEncoding]);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *args = [NSArray arrayWithArguments:argv count:argc];
        MyCalendar *cal = nil;
        switch (args.count) {
            case 0:
                cal = [[MyCalendar alloc] init];
                [cal printMonth];
                break;
            case 1:
                cal = [[MyCalendar alloc] initWithYear:[args[0] intValue]];
                [cal printYear];
                break;
            case 2:
                if ([@"-m" compare:args[0]] == NSOrderedSame) {
                    cal = [[MyCalendar alloc] initWithMonth:[args[1] intValue]];
                } else {
                    cal = [[MyCalendar alloc] initWithYear:[args[1] intValue]
                                                  andMonth:[args[0] intValue]];
                }
                [cal printMonth];
                break;
            default:
                systemcal(args);
                break;
        }
        printf("\n");
    }
    return 0;
}
