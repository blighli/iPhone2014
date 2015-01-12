//
//  HYBCard.m
//  2048
//
//  Created by hyb on 14/12/30.
//  Copyright (c) 2014年 hyb. All rights reserved.
//

#import "HYBCard.h"

@implementation HYBCard

+ (UIImage *)imageOfExp:(NSInteger)exp{
    UIImage *image = nil;
    NSArray *images = nil;
//    if (!images){
//        images = [NSArray arrayWithObjects:
//                  [UIImage imageNamed:@"lg.png"],
//                  [UIImage imageNamed:@"lg.png"],
//                  [UIImage imageNamed:@"tly.png"],
//                  [UIImage imageNamed:@"hy.png"],
//                  [UIImage imageNamed:@"lzx.png"],
//                  [UIImage imageNamed:@"mk.png"],
//                  [UIImage imageNamed:@"bl.png"],
//                  [UIImage imageNamed:@"fb.png"],
//                  nil];
//    }
    if (exp < [images count]){
        image = images[exp];
    }
    return image;
}

+ (UIColor *)colorOfExp:(NSInteger)exp{
    UIColor *resultColor = [UIColor whiteColor];
    NSArray *colors = nil;
    if (!colors){
        colors = [NSArray arrayWithObjects:
                  [UIColor whiteColor],
                  [UIColor colorWithRed:255.0/255.0 green:98.0/255.0 blue:176.0/255.0 alpha:1.f],
                  [UIColor colorWithRed:237.0/255.0 green:224.0/255.0 blue:200.0/255.0 alpha:1.f],
                  [UIColor colorWithRed:241.0/255.0 green:177.0/255.0 blue:121.0/255.0 alpha:1.f],
                  [UIColor colorWithRed:236.0/255.0 green:141.0/255.0 blue:84.0/255.0 alpha:1.f],
                  [UIColor colorWithRed:246.0/255.0 green:124.0/255.0 blue:95.0/255.0 alpha:1.f],
                  [UIColor colorWithRed:234.0/255.0 green:89.0/255.0 blue:55.0/255.0 alpha:1.f],
                  [UIColor colorWithRed:243.0/255.0 green:216.0/255.0 blue:107.0/255.0 alpha:1.f],
                  [UIColor colorWithRed:241.0/255.0 green:208.0/255.0 blue:75.0/255.0 alpha:1.f],
                  [UIColor colorWithRed:238.0/255.0 green:201.0/255.0 blue:67.0/255.0 alpha:1.f],
                  [UIColor colorWithRed:238.0/255.0 green:198.0/255.0 blue:44.0/255.0 alpha:1.f],
                  [UIColor colorWithRed:238.0/255.0 green:195.0/255.0 blue:9.0/255.0 alpha:1.f],
                  nil];
    }
    if (exp < [colors count]){
        resultColor = colors[exp];
    }
    return resultColor;
}

- (void)setNumberString:(NSString *)numberString{
    self.number = [numberString integerValue];
}

- (void)addExpWithDelay:(NSTimeInterval)time{
    _exp += 1;
    NSInteger number = (NSInteger)pow(2, _exp);
    NSString *numberString = [NSString stringWithFormat:@"%d",number];
    [self performSelector:@selector(setNumberString:) withObject:numberString afterDelay:time];
    [self performSelector:@selector(updateBackgroundColor) withObject:nil afterDelay:time];
    [self performSelector:@selector(setBackgroundColor:) withObject:[[self class] colorOfExp:_exp] afterDelay:time];
}

- (IBAction)pressed:(id)sender {
    [self.delegate cardDidPressed:self];
}

- (void)updateBackgroundColor{
    UIImage *image = [[self class] imageOfExp:_exp];
    self.imageView.image = image;
    UIColor *color = [[self class] colorOfExp:_exp];
    [UIView animateWithDuration:0.2f
                     animations:^{
                         self.backgroundColor = color;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)setExp:(NSInteger)exp{
    _exp = exp;
    self.number = (NSInteger)pow(2, _exp);
    self.backgroundColor = [[self class] colorOfExp:_exp];
    self.imageView.image = [[self class] imageOfExp:_exp];
}

- (void)setNumber:(NSInteger)number{
    _number = number;
    self.numberLabel.text = [NSString stringWithFormat:@"%d",_number];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"HYBCard" owner:self options:nil];
        if (nibs){
            self = nibs[0];
        }
        self.layer.cornerRadius = 4;
        [self setFrame:frame];
        self.currentAdded = NO;
    }
    return self;
}


@end
