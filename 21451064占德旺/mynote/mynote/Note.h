//
//  Note.h
//  mynote
//
//  Created by Devon on 14/11/21.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * c_text;
@property (nonatomic, retain) NSData * c_image;

@end
