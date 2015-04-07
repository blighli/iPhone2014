//
//  Task.m
//  TODOListHW
//
//  Created by StarJade on 14-11-10.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import "Task.h"

@implementation Task

@dynamic taskName;
@dynamic created;
@dynamic completed;
//@dynamic string;
//@dynamic attributedString;
//@synthesize attributedString = _attributedString; 
@synthesize string = _string;

- (void)awakeFromInsert
{
    self.created = [NSDate date];
    self.completed = [NSNumber numberWithBool:NO];
    self.taskName = @"新笔记";
//	self.attributedString = [[FastTextStorage alloc] initWithString:@""];
	
	self.string = [[NSMutableAttributedString alloc]initWithString:@""];
	
//	_attributedString = [[FastTextStorage alloc]initWithString:@""];
//	printf("\n\n\n\n------------------------------enter awakeFromInsert\n\n\n\n");
}
- (void)setAttributedString:(NSMutableAttributedString *)string {
	
}


@end
