//
//  Data.h
//  Project4-Note
//
//  Created by  ws on 11/21/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Data : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * attribute;
@property (nonatomic, retain) NSDate * time;

@end
