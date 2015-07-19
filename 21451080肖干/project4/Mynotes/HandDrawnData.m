//
//  HandDrawnData.m
//  Mynotes
//
//  Created by xiaoo_gan on 11/28/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "HandDrawnData.h"

#define kTitle  @"Title"
#define kDate   @"Date"
#define kImage  @"Image"


@implementation HandDrawnData

@synthesize title = _title;
@synthesize date = _date;
@synthesize image = _image;

- (HandDrawnData *) init
{
    if (self = [super init]) {
        
    }
    return self;
}

- (NSString *) dateString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM月dd日 HH:mm"];
    return [df stringFromDate:self.date];
}


#pragma mark - archive

- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.date forKey:kDate];
    [aCoder encodeObject:self.title forKey:kTitle];
    [aCoder encodeObject:self.image forKey:kImage];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    HandDrawnData *decode_note = [self init];
    decode_note.title = [aDecoder decodeObjectForKey:kTitle];
    decode_note.date = [aDecoder decodeObjectForKey:kDate];
    decode_note.image = [aDecoder decodeObjectForKey:kImage];
    return decode_note;
}

@end
