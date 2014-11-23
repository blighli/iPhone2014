//
//  Note.h
//  MyNotes
//
//  Created by YilinGui on 14-11-23.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * type;

@end
