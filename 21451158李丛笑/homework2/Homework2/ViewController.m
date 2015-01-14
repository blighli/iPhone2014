//
//  ViewController.m
//  Homework2
//
//  Created by 李丛笑 on 14/11/5.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import "ViewController.h"
#import "Calcu.h"
#import "ActionofButton.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize textView;

NSDecimalNumber *result;
NSDecimalNumber *store;
NSMutableString *ifresult;
int left=0;
ActionofButton *act;
Calcu *cl;
- (void)viewDidLoad {
    [super viewDidLoad];
    textstr = [NSMutableString stringWithCapacity:50];
    numstr = [NSMutableString stringWithCapacity:50];
    ifresult = [NSMutableString stringWithCapacity:10];
    act = [[ActionofButton alloc]init];
    cl = [[Calcu alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zero {
    textView.text = [act ActtoNum:@"0" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)one {
    textView.text = [act ActtoNum:@"1" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)two {
   textView.text = [act ActtoNum:@"2" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)three {
    textView.text = [act ActtoNum:@"3" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)four {
    textView.text = [act ActtoNum:@"4" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)five {
    textView.text = [act ActtoNum:@"5" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)six {
    textView.text = [act ActtoNum:@"6" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)seven {
    textView.text = [act ActtoNum:@"7" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)eight {
    textView.text = [act ActtoNum:@"8" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)nine {
    textView.text = [act ActtoNum:@"9" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)dot {
    textView.text = [act ActtoNum:@"." Text:textstr Num:numstr Is:ifresult];}

- (IBAction)left {
    textView.text = [act ActtoNum:@"(" Text:textstr Num:numstr Is:ifresult];
    left++;
}

- (IBAction)right {
    if([textstr length]!=0 && [@"0123456789)" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound)
    {
        if ([@"0123456789" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound) {
            [numstr appendString:@" "];
        }
        if (left>0) {
            [numstr appendString:@")"];
            [textstr appendString:@")"];
            if ([textstr length]>13)
                textView.text = [textstr substringFromIndex:[textstr length]-13];
            else textView.text = textstr;
            
            left--;
        }
        
    }
}



- (IBAction)plus {
    textView.text = [act ActtoSym:@"+" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)minus {
    textView.text = [act ActtoSym:@"-" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)multiple {
    textView.text = [act ActtoSym:@"*" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)divide {
   textView.text = [act ActtoSym:@"/" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)percent {
    textView.text = [act ActtoSym:@"%" Text:textstr Num:numstr Is:ifresult];}

- (IBAction)mod {
    textView.text = [act ActtoSym:@"m" Text:textstr Num:numstr Is:ifresult];
}



- (IBAction)back {
    if ([textstr length]!=0) {
        if([textstr length]>1 && [@"+-*/)%m" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound && [@"0123456789" rangeOfString:[textstr substringWithRange:NSMakeRange([textstr length]-2, 1)]].location!=NSNotFound)
        {
            if ([@"%" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound) {
                [numstr deleteCharactersInRange:NSMakeRange([numstr length]-6,6)];
            }
            else [numstr deleteCharactersInRange:NSMakeRange([numstr length]-2,2)];
        }
        else
            [numstr deleteCharactersInRange:NSMakeRange([numstr length]-1,1)];
            [textstr deleteCharactersInRange:NSMakeRange([textstr length]-1,1)];
        
    }
    if ([textstr length]>13)
        textView.text = [textstr substringFromIndex:[textstr length]-13];
    else textView.text = textstr;

}

- (IBAction)ac {
    [textstr setString:@""];
    [numstr setString:@""];
    store = [store decimalNumberBySubtracting:store];
    result=store;
    textView.text = textstr;
}

- (IBAction)mplus {
    if ([ifresult isEqualToString:@"y"]) {
    if (store==nil) {
        store = [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    store = [store decimalNumberByAdding:result];
    result = store;
    [textstr setString:@""];
    [numstr setString:@""];
    textView.text = textstr;
    }
}

- (IBAction)mminus {
    if ([ifresult isEqualToString:@"y"]) {
    if (store==nil) {
        store = [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    store = [store decimalNumberBySubtracting:result                                                                                                                                                                                                                                                                                                                                                      ];
    result = store;
    [textstr setString:@""];
    [numstr setString:@""];
    textView.text = textstr;
        
    }

}

- (IBAction)mc {
    store = [store decimalNumberBySubtracting:store];
}

- (IBAction)mr {
    if(store==nil){
        store = [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    [textstr setString:@""];
    [textstr appendString:[NSString stringWithFormat:@"%@", store]];
    textView.text = textstr;

    [numstr setString:@""];
    [numstr appendString:[NSString stringWithFormat:@"%@", store]];
    [ifresult setString:@"y"];
}

- (IBAction)equles {
    if([textstr length]!=0 && [@"0123456789)%" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound)
 {
        if ([@"0123456789" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound){
            [numstr appendString:@" "];
        }
     while (left>0) {
         [numstr appendString:@")"];
         [textstr appendString:@")"];
         left--;
     }
     NSString *res = [cl getResult:[cl getPostfix:numstr]];
     if ([res isEqualToString:@"error"]) {
         [textstr setString:@"error"];
         [numstr setString:@""];
         textView.text = textstr;
         [textstr setString:@""];
     }
     else{
     result = [NSDecimalNumber decimalNumberWithString:res];
     [textstr setString:[NSString stringWithFormat:@"%@", res]];
     
     textView.text = textstr;

     [numstr setString:@""];
         if ( [@"1234567890" rangeOfString:[textstr substringToIndex:1]].location==NSNotFound) {
             [numstr appendString:@"0 "];
         }
     [numstr appendString:textstr];
     [ifresult setString:@"y"];
     }
     
 }
    
}


@end
