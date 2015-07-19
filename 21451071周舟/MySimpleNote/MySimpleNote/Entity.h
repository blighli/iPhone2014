//
//  Entity.h
//  MySimpleNote
//
//  Created by 周舟 on 24/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * imagepath;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date;

@end
