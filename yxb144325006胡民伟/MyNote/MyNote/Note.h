//
//  Note.h
//  MyNote
//
//  Created by Cocoa on 14/11/20.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * type;

@end
