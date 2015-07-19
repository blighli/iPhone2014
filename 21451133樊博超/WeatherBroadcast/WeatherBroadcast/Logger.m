//
//  Logger.m
//  WeatherBroadcast
//
//  Created by 樊博超 on 14-12-24.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import "Logger.h"

@implementation Logger

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    NSLog(@"received %lu bytes", [data length]);
    if (!incomingData) {
        incomingData = [[NSMutableData alloc] init]; }
    [incomingData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Got it all!");
    NSString *string
    = [[NSString alloc] initWithData:incomingData
                            encoding:NSUTF8StringEncoding]; NSLog(@"The whole string is %@", string);
    incomingData = nil;
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    NSLog(@"connection failed: %@", [error localizedDescription]);
    incomingData = nil; }

@end
