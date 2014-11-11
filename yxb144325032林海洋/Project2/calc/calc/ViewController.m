//
//  ViewController.m
//  calc
//
//  Created by xufei on 14/11/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize label;
@synthesize op;
@synthesize flag;
@synthesize op1,op2;
@synthesize control;
@synthesize keep;
@synthesize isequal;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	//[self clearscreen];
	self.op = YES;
	self.flag = YES;
	self.control = 1;
	self.flag_.text = @"";
	self.isequal = false;
	self.fuck = true;
}

-(IBAction)buttonInputDel:(id)sender
{
	if (![self.label.text isEqual:@""]) {
		self.label.text = [self.label.text substringToIndex:[self.label.text length]-1];
	}
}

-(IBAction)button90:(id)sender
{//

}

-(BOOL)clearscreen
{
	self.label.text = @"";
	if (![self.label.text  isEqual: @""])
		return false;
	return true;
}

-(IBAction)buttonInputNu:(id)sender
{
	if (self.control == 2 || self.fuck == true) {
		self.label.text = @"";
		self.control = 1;
		self.fuck = false;
	}


	if(isequal == true)
	{
		[self clearscreen];
		isequal = false;
	}

	NSString *input =((UIButton*) sender).titleLabel.text;

	self.label.text = [NSString stringWithFormat:@"%@%@",self.label.text,input];

	//or can push
}

-(void)getnumberBy:(BOOL)o
{
	if (o == YES) {
        self.op1 = [self.label.text doubleValue];
		if (self.flag == NO) {
			self.op1 *= -1;
			self.flag = YES;
		}
	} else {
		self.op2 =[self.label.text doubleValue];
		if (self.flag == NO) {
			self.op2 *= -1;
			self.flag = YES;
		}
	}
}

-(NSString *)calcByop:(NSString*)ope
{
	if ([ope isEqual:@"+"]) {
		op1+=op2;
	} else if([ope isEqual:@"-"]){
		op1-=op2;
	} else if ([ope isEqual:@"x"]){
		op1*=op2;
	} else if ([ope isEqual:@"/"]){
		if (op2!=0) {
			op1/=op2;
		}
	} else if ([ope isEqual:@"%"]){
		if (op2!=0) {
			int a = (int)op1;
			int b = (int)op2;
			a%=b;
			op1 = (double)a;
		}
	}
	return [NSString stringWithFormat:@"%f",op1];
}

-(IBAction)buttonInputOp:(id)sender
{
	NSString *input =((UIButton*) sender).titleLabel.text;

	//get number
	if ([input isEqualToString:@"AC"]) {
		[self clearscreen];
	}else
	{
		[self getnumberBy:self.op];//first number
		self.label.text = [NSString stringWithFormat:@"%@",input];
		keep = input;
	}

	if (self.flag == NO) {
		self.flag_.text = @"";
	}

	self.op = !self.op;
	self.control++;
}

-(IBAction)buttonsum:(id)sender
{
	[self getnumberBy:self.op];//second number
	self.label.text = [self calcByop:keep];

	self.op1 = 0;
	self.op2 = 0;

	self.op = YES;
	self.flag = YES;
	self.control = 1;
	self.flag_.text = @"";

	self.isequal = true;
}

-(IBAction)buttonInputflag:(id)sender
{
	//NSString *num = self.label.text;
	self.flag = !self.flag;

	if (self.flag == NO) {
		self.flag_.text = @"-";
	}else
		self.flag_.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
