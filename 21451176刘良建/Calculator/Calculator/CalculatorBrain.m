//
//  CalculatorBrain.m
//  Calculator
//
//  Created by JANESTAR on 14-11-5.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()

@end

@implementation CalculatorBrain
@synthesize operandStack=_operandStack;
@synthesize operatorStack=_operatorStack;
@synthesize result=_result;
@synthesize origin=_origin;
@synthesize operandStack_copy=_operandStack_copy;
@synthesize operatorStack_copy=_operatorStack_copy;


//获取运算符优先级
-(int)getPrior:(NSString*)c{
    if([c isEqualToString:@"-"]||[c isEqualToString:@"+"]){
        return 0;
    }
   if([c isEqualToString:@"x"]||[c isEqualToString:@"/"]){
       return 1;
    }
   if([c isEqualToString:@"("]||[c isEqualToString:@")"]){
      return -1;
   }
    return 2;

}

-(NSMutableArray *)operandStack{
    if(_operandStack==nil){
    
        _operandStack=[[NSMutableArray alloc]init];
    }
    return _operandStack;


}

-(NSMutableArray *)operandStack_copy{
    if(_operandStack_copy==nil){
        
        _operandStack_copy=[[NSMutableArray alloc]init];
    }
    return _operandStack_copy;
    
    
}

-(NSMutableArray *)operatorStack_copy{
    if(_operatorStack_copy==nil){
        
        _operatorStack_copy=[[NSMutableArray alloc]init];
    }
    return _operatorStack_copy;
    
    
}


-(NSMutableArray*)result{
    if(_result==nil){
        _result=[[NSMutableArray alloc]init];
    }
    return _result;

}

-(NSMutableArray*)origin{
    if(_origin==nil){
        _origin=[[NSMutableArray alloc]init];
    }
    return _origin;
}


-(void)setResult:(NSMutableArray*)re{
    _result=re;

}

-(void)setOrigin:(NSMutableArray *)ori{
    _origin=ori;
}


-(NSMutableArray *)operatorStack{
    if(_operatorStack==nil){
        _operatorStack=[[NSMutableArray alloc]init];
    }
    return _operatorStack;

}

-(void)setOperatorStack:(NSMutableArray *)opera{
    _operatorStack=opera;

}




-(void)setOperandStack:(NSMutableArray *)operand{
    _operandStack=operand;

}

-(void)setOperandStack_copy:(NSMutableArray *)operandStack_copy2{
    _operandStack_copy=operandStack_copy2;
    
}

-(void)setOperatorStack_copy:(NSMutableArray *)operatorStack_copy2{
    _operandStack_copy=operatorStack_copy2;
    
}
-(void)pushOperator:(NSString*)oper{

    [self.operatorStack addObject:oper];

}

-(void)pushOrigin:(NSString *)ori{
    [self.origin addObject:ori];

}
-(void)pushOperand:(NSString*)operand{

    [self.operandStack addObject:operand];

}
-(void)pushOperand_copy:(NSString*)operand{
    
    [self.operandStack_copy addObject:operand];
    
}
-(void)pushOperator_copy:(NSString*)operator_{
    
    [self.operatorStack_copy addObject:operator_];
    
}

-(void)pushResult:(double)re{
    NSNumber* num=[NSNumber numberWithDouble:re];
    [self.result addObject:num];
  
}


-(NSString*)popOper{
    NSString *operatorObject=[self.operatorStack lastObject];
    if(operatorObject!=nil){
        [self.operatorStack removeLastObject];
    
    }
    return operatorObject;
    


}

-(NSString*)popOri{
    NSString* ori_=[self.origin lastObject];
    if(ori_!=nil){
        [self.origin removeLastObject];
    }
    return ori_;


}

-(NSString*)popOperand{
    NSString *operandObject=[self.operandStack lastObject];
    if(operandObject !=nil){
        [self.operandStack removeLastObject];
    }
    return operandObject;
  

}

-(NSString*)popOperand_copy{
    NSString *operandObject=[self.operandStack_copy lastObject];
    if(operandObject !=nil){
        [self.operandStack_copy removeLastObject];
    }
    return operandObject;
    
    
}
-(NSString*)popOperator_copy{
    NSString *operatorObject=[self.operatorStack_copy lastObject];
    if(operatorObject !=nil){
        [self.operandStack_copy removeLastObject];
    }
    return operatorObject;
    
    
}

-(double)popResult{
    NSNumber *re=[self.result lastObject];
    if(re!=nil){
        [self.result removeLastObject];
    }
    return [re doubleValue];


}






@end
