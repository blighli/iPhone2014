//
//  Util.h
//  AverNote
//
//  Created by Mz on 14-11-23.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^CompletionHandler)(BOOL didSuccess, NSString* imagePath);
@interface Util : NSObject
+ (void)writeImageToFile:(UIImage*) image withCompletion:(CompletionHandler) completion;
@end
