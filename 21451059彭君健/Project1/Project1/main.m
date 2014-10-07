//
//  main.m
//  Project1
//
//  Created by Mz on 14-10-7.
//  Copyright (c) 2014年 Zorro M. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableString *arg = [NSMutableString stringWithString: @"cal"];
        for (int i = 1; i < argc; i++) {
            [arg appendFormat:@" %@",
             [NSString stringWithCString:argv[i]
                                encoding:NSASCIIStringEncoding]];
        }
        NSLog(@"%@", arg);
        system([arg cStringUsingEncoding:NSASCIIStringEncoding]);
    }
    return 0;
}
