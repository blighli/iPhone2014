//
//  Util.m
//  AverNote
//
//  Created by Mz on 14-11-23.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import "Util.h"

@implementation Util
+ (NSString *)generateNewImagePath {
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"docpath = %@", docPath);
    NSString *imagePath = [docPath stringByAppendingPathComponent:@"images"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:imagePath withIntermediateDirectories:YES attributes:nil error:nil];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy_MM_dd_HH_mm_ss_SSSS"];
    NSString* nowDate = [dateFormatter stringFromDate:[NSDate date]];
    NSString *imageFilePath = [imagePath stringByAppendingFormat:@"/%@.%@", nowDate, @"jpg"];
    return imageFilePath;
}

+ (void)writeImageToFile:(UIImage *)image withCompletion:(CompletionHandler)completion {
    NSString *imageFilePath = [self generateNewImagePath];
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    if([imageData writeToFile:imageFilePath atomically:YES]) {
        NSLog(@"image %@ has been written.", imageFilePath);
        completion(YES, imageFilePath);
    } else {
        NSLog(@"image %@ failed to write.", imageFilePath);
        completion(NO, nil);
    }
}
@end