//
//  ViewController.m
//  Test
//
//  Created by 李丛笑 on 14/11/5.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#import "ViewController.h"
#import "Calcu.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize textView;

NSDecimalNumber *result;
NSDecimalNumber *store;
int left=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    textstr = [NSMutableString stringWithCapacity:50];
    numstr = [NSMutableString stringWithCapacity:50];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)zero {
    if ([textstr length] ==0 || [@")" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
      [numstr appendString:@"0"];
      [textstr appendString:@"0"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;
    }
    
}

- (IBAction)dot {
    if ([textstr length]!=0 && [@"0123456789" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound)
    {
    [numstr appendString:@"."];
    [textstr appendString:@"."];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }
}

- (IBAction)one {
    if ([textstr length]==0||[@")" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
    [numstr appendString:@"1"];
    [textstr appendString:@"1"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }
}

- (IBAction)two {
    if ([textstr length]==0||[@")" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
    [numstr appendString:@"2"];
    [textstr appendString:@"2"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }
}

- (IBAction)three {
    if ([textstr length]==0||[@")" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
    [numstr appendString:@"3"];
    [textstr appendString:@"3"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;
    }
}

- (IBAction)four {
    if ([textstr length]==0||[@")" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
    [numstr appendString:@"4"];
    [textstr appendString:@"4"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }
}

- (IBAction)five {
    if ([textstr length]==0||[@")" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
    [numstr appendString:@"5"];
    [textstr appendString:@"5"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;
    }
}

- (IBAction)six {
    if ([textstr length]==0||[@")" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
    [numstr appendString:@"6"];
    [textstr appendString:@"6"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }
}

- (IBAction)seven {
    if ([textstr length]==0||[@")" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
    [numstr appendString:@"7"];
    [textstr appendString:@"7"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }
}

- (IBAction)eight {
    if ([textstr length]==0||[@")" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
    [numstr appendString:@"8"];
    [textstr appendString:@"8"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }
}

- (IBAction)nine {
    if ([textstr length]==0||[@")" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
    [numstr appendString:@"9"];
    [textstr appendString:@"9"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }
}

- (IBAction)plus {
    if ([textstr length]!=0 && [@"+-*/(" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
        if([@"0123456789" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound)
            [numstr appendString:@" "];
    [numstr appendString:@"+"];
    [textstr appendString:@"+"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }
}

- (IBAction)minus {
    if ([textstr length]==0 || [@"+-*/" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
        if([textstr length]!=0 && [@"0123456789" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound)
        [numstr appendString:@" -"];
        else
    [numstr appendString:@"0 -"];
    [textstr appendString:@"－"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }

}

- (IBAction)multiple {
    if ([textstr length]!=0 && [@"+-*/(" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
        if([@"0123456789" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound)
        [numstr appendString:@" "];
    [numstr appendString:@"*"];
    [textstr appendString:@"×"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }

}

- (IBAction)divide {
    if ([textstr length]!=0 && [@"+-*/(" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
        if([@"0123456789" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound)
        [numstr appendString:@" "];
    [numstr appendString:@"/"];
    [textstr appendString:@"÷"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }

}

- (IBAction)left {
    if([textstr length]==0 || [@"0123456789)" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location==NSNotFound)
    {
    [numstr appendString:@"("];
    [textstr appendString:@"("];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

        left++;
    }

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

- (IBAction)percent {
    if ([textstr length]!=0 && [@"0123456789)" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound) {
        if ([@"0123456789" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound)
            [numstr appendString:@" "];
        [numstr appendString:@"/100 "];
        [textstr appendString:@"%"];
        if ([textstr length]>13)
            textView.text = [textstr substringFromIndex:[textstr length]-13];
        else textView.text = textstr;

    }
}

- (IBAction)back {
    if ([textstr length]!=0) {
        if([textstr length]>1 && [@"+-*/)" rangeOfString:[textstr substringFromIndex:[textstr length]-1]].location!=NSNotFound && [@"0123456789" rangeOfString:[textstr substringWithRange:NSMakeRange([textstr length]-2, 1)]].location!=NSNotFound)
        {
            [numstr deleteCharactersInRange:NSMakeRange([numstr length]-2,2)];
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
    if (store==nil) {
        store = [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    store = [store decimalNumberByAdding:result];
    result = store;
    [textstr setString:@""];
    [numstr setString:@""];
    textView.text = textstr;

}

- (IBAction)mminus {
    if (store==nil) {
        store = [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    store = [store decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:result]];
    result = store;
    [textstr setString:@""];
    [numstr setString:@""];
    textView.text = textstr;

}

- (IBAction)mc {
    store = [store decimalNumberBySubtracting:store];
}

- (IBAction)mr {
    [textstr setString:@""];
    [textstr appendString:[NSString stringWithFormat:@"%@", store]];
    textView.text = textstr;

    [numstr setString:@""];
    [numstr appendString:[NSString stringWithFormat:@"%@", store]];
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
        Calcu *cl = [[Calcu alloc]init];
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
     }
     
 }
    
}


@end
