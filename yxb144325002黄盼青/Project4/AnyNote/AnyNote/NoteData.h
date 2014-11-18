//
//  NoteData.h
//  AnyNote
//
//  Created by 黄盼青 on 14/11/18.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface NoteData : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * contents;

@end
