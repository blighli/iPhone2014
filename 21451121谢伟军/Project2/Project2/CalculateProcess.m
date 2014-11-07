//
//  CalculateProcess.m
//  Project2
//
//  Created by xvxvxxx on 14/11/5.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "CalculateProcess.h"

@interface CalculateProcess()



@end

@implementation CalculateProcess

-(instancetype)init{
    self = [super init];
    if (self) {
        self.lastNumber = 0;
        self.currentNumber = 0;
        self.memoryString = [NSMutableString stringWithCapacity:40];
        self.displayString = [NSMutableString stringWithCapacity:40];

    }
    return self;
}

-(void)processDigit:(NSInteger)digit{
    //self.currentNumber = self.currentNumber * 10 + digit;
    [self.displayString appendString:[NSString stringWithFormat:@"%i",digit]];


}


-(void)displayNumberatScreen:(UILabel *)labelScreen{
    self.currentNumber = [self.displayString doubleValue];
    NSLog(@"%@",self.displayString);
    labelScreen.text = self.displayString;
}

-(void)processDot{
    [self.displayString appendString:[NSString stringWithFormat:@"."]];

}
@end
