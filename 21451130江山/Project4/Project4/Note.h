//
//  Note.h
//  Project4
//
//  Created by 江山 on 1/7/15.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pictures;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) Pictures *have;

@end
