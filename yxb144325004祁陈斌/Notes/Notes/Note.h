//
//  Note.h
//  Notes
//
//  Created by xsdlr on 14/11/17.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * type;

+ (NSString*) TEXT_TYPE;
+ (NSString*) IMAGE_TYPE;
+ (NSString*) DRAW_TYPE;
@end
