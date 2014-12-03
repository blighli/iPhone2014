//
//  iHabitTests.m
//  iHabitTests
//
//  Created by 陆钟豪 on 14/12/1.
//  Copyright (c) 2014年 lzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "Habit.h"

@interface iHabitTests : XCTestCase

@end

@implementation iHabitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [MagicalRecord setupCoreDataStackWithStoreNamed: @"iHabitDB.sqlite"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [MagicalRecord cleanUp];
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    Habit *newHabit = [Habit MR_createEntity];
    newHabit.title = @"testtitle";
    [[NSManagedObjectContext MR_defaultContext]MR_saveToPersistentStoreAndWait];
    Habit *habit = [Habit MR_findFirst];
    XCTAssert([habit.title isEqualToString:@"testtitle"], @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
