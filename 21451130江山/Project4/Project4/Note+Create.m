//
//  Note+Create.m
//  Project4
//
//  Created by 江山 on 1/7/15.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import "Note+Create.h"
#import "Note.h"

@implementation Note (Create)

+ (Note *)NoteWithTitle:(NSString *)title andContent:(NSString *)content 
                inManagedObjectContext:(NSManagedObjectContext *)context
{
    Note *note = nil;
    
    // This is just like Photo(Flickr)'s method.  Look there for commentary.
    
    if (title.length) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Note"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date"
                                                                  ascending:NO
                                                                   selector:@selector(localizedCaseInsensitiveCompare:)]];
        request.predicate = [NSPredicate predicateWithFormat:@"title = %@", title];
        
        NSError *error;
        NSArray *matches = [context executeFetchRequest:request error:&error];
        
        if (!matches || ([matches count] > 1)) {
            // handle error
        } else if (![matches count]) {
            note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
            note.title = title;
            note.content = content;
        } else {
            note = [matches lastObject];
        }
    }
    
    return note;
}

@end
