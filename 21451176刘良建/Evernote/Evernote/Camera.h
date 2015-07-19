//
//  Camera.h
//  Evernote
//
//  Created by JANESTAR on 14-11-24.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Camera : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * time;

@end
