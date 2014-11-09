//
//  MyStack.m
//  Calculator
//
//  Created by turbobhh on 11/5/14.
//  Copyright (c) 2014 org.bhh.homework. All rights reserved.
//

#import "MyStack.h"

@interface MyStack ()
@property (strong,nonatomic) NSMutableArray* array;

@end

@implementation MyStack


-(instancetype)init{
    if (self=[super init]) {
        _array=[[NSMutableArray alloc] init];
    }
    
    return self;
}

-(int)count{
    return self.array.count;
}

-(BOOL)isEmpty{
    return self.count<=0;
}

-(id)top{
    if (self.isEmpty) {
        return nil;
    }
    id object=[self.array objectAtIndex:self.array.count-1];
    return object;

}

-(id)pop{
    if (self.isEmpty) {
        return nil;
    }
    id object=self.top;
    [self.array removeObjectAtIndex:self.array.count-1];
    return object;
}

-(void)push:(id)object{
    [self.array addObject:object];
    
}

@end
