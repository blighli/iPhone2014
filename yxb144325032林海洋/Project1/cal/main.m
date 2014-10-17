//
//  main.m
//  sunny
//
//  Created by sunny on 14-10-17.
//  Copyright (c) 2014年 sunny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray *args = [NSMutableArray arrayWithCapacity:argc];
        for(int i = 1;i < argc; i++)
            [args addObject:[NSString stringWithCString:argv[i]
                                               encoding:NSASCIIStringEncoding]];
        
        Calendar *cal = nil;
        switch (args.count) {
            case 0:
                cal = [[Calendar alloc] init];
                [cal printMonth];
                break;
            case 1:
                if ([@"-y" compare:args[0]] == NSOrderedSame) {
                    cal = [[Calendar alloc] init];
                } else {
                    if ([args[0] intValue] < 1 || [args[0] intValue] > 9999	) {
                        printf("the year is wrong\n"); return 1;
                    }
                    cal = [[Calendar alloc] initWithYear:[args[0] intValue]];
                }
                [cal printYear];
                break;
            case 2:
                if ([@"-m" compare:args[0]] == NSOrderedSame) {
                    if ([args[1] intValue] < 1 || [args[1] intValue] > 12) {
                        printf("the month is wrong\n"); return 1;
                    }
                    cal = [[Calendar alloc] initWithMonth:[args[1] intValue]];
                    [cal printMonth];
                } else if ([@"-y" compare:args[0]] == NSOrderedSame){
                    if ([args[1] intValue] < 1 || [args[1] intValue] > 9999	) {
                        printf("the year is wrong\n"); return 1;
                    }
                    cal = [[Calendar alloc] initWithYear:[args[1] intValue]];
                    [cal printYear];
                } else {
                    if ([args[1] intValue] < 1 || [args[1] intValue] > 9999 || [args[0] intValue] < 1 || [args[0] intValue] > 12) {
                        printf("month or year is wrong\n"); return 1;
                    }
                    
                    cal = [[Calendar alloc] initWithYear:[args[1] intValue]
                                                  andMonth:[args[0] intValue]];
                    [cal printMonth];
                }
                break;
            default:
                printf("argument is wrong\n");
                break;
        }
    }
    return 0;
}
