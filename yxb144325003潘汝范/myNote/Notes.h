//
//  Notes.h
//  mynote
//
//  Created by Van on 14/11/18.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Notes : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * fileName;

@end
