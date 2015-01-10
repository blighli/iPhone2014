//
//  Diary.m
//  MySecretDiary
//
//  Created by icy on 14-12-19.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import "Diary.h"
#import "User.h"
#import "AppDelegate.h"
@implementation Diary

@dynamic title;
@dynamic date;
@dynamic picture;
@dynamic content;
@dynamic user;


+(bool)deleteDiary:(Diary *)diary{
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    [diary.user removeDiariesObject:diary];
    [context deleteObject:diary];
    
    NSError *error = nil;
    [context save:&error];
    if(error)
    {
        NSLog(@"%@\n", [error  description]);
        return NO;
    }

    return YES;
}


@end
