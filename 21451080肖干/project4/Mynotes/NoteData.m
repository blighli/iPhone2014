//
//  NoteData.m
//  Notes
//
//  Created by xiaoo_gan on 11/25/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "NoteData.h"

#define kTitle @"Title"
#define kLabels @"Labels"
#define kContent @"Content"
#define kDate @"Date"

@implementation NoteData
@synthesize title = _title;
@synthesize labels = _labels;
@synthesize content = _content;
@synthesize date = _date;

- (NoteData *)init
{
    if (self = [super init]) {
    }
    
    return self;
}

- (NSString *)labelsString
{
    return [self.labels componentsJoinedByString:@","];
}

- (NSString *)dateString
{
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"MM月dd日 HH:mm"];
    return [date_formatter stringFromDate:self.date];
}

#pragma mark - archive
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.date forKey:kDate];
    [aCoder encodeObject:self.title forKey:kTitle];
    [aCoder encodeObject:[self labelsString] forKey:kLabels];
    [aCoder encodeObject:self.content forKey:kContent];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NoteData *decode_note = [self init];
    decode_note.title = [aDecoder decodeObjectForKey:kTitle];
    decode_note.date = [aDecoder decodeObjectForKey:kDate];
    decode_note.labels = [[aDecoder decodeObjectForKey:kLabels] componentsSeparatedByString:@","];
    decode_note.content = [aDecoder decodeObjectForKey:kContent];
    return decode_note;
}

@end
