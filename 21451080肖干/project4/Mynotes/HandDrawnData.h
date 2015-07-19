//
//  HandDrawnData.h
//  Mynotes
//
//  Created by xiaoo_gan on 11/28/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HandDrawnData : NSObject <NSCoding>
@property (strong, nonatomic) NSDate *date;
@property (copy,nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *image;

- (NSString *) dateString;

@end
