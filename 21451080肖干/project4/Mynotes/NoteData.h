//
//  NoteData.h
//  Notes
//
//  Created by xiaoo_gan on 11/25/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NoteData : NSObject <NSCoding>

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *labels;
@property (copy, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate *date;

- (NSString *)labelsString;
- (NSString *)dateString;

@end
