#import <Foundation/Foundation.h>
#import "Calendar.h"




int main(int argc,const char * argv[]){
  
    @autoreleasepool {
        
       if(argc==1){
           //获得当前日期
           NSDate *date = [NSDate date];
           NSCalendar *calendar = [NSCalendar currentCalendar];
           NSDateComponents *comps;
           //该年
           comps = [calendar components:(NSYearCalendarUnit) fromDate:date];
           NSInteger year = [comps year];
           //该月
           comps = [calendar components:(NSMonthCalendarUnit) fromDate:date];
           NSInteger month = [comps month];
           
           [Calendar print_One:(int)year inMonth:(int)month];
            return 0;
        
        }
        if(argc==2){
            
          
                const char* c=argv[1];
                int i=atoi(c);
            
                if((int)i>=1&&(int)i<=9999){
                    [Calendar print_All:(int)i];
                    
                }
                else{
                    printf("cal: year %d not in range 1..9999\n",i);
                    
                }
                
          }
    
        if(argc==3){
            
            
            
                const char* d1=argv[1];
                const char* d2=argv[2];
               
                char* d5="-m";
               
                    int result2=strcmp(d1, d5);
                    if(!result2){
                        int tmp=atoi(d2);
                        if(tmp>=1&&tmp<=12){
                            //获得当前日期
                            NSDate *date = [NSDate date];
                            NSCalendar *calendar = [NSCalendar currentCalendar];
                            NSDateComponents *comps;
                            //本年
                            comps = [calendar components:(NSYearCalendarUnit) fromDate:date];
                            NSInteger year = [comps year];
                            [Calendar print_One:(int)year inMonth:tmp];
                            
                        }else{
                            printf("cal: %s is neither a month number (1..12) nor a name\n",d2);
                            
                        }
                        
                        
                        
                    }else{
                        int t=atoi(d2);
                        if(t>=1&&t<=9999){
                            int t2=atoi(d1);
                            if(t2>=1&&t2<=12){
                                [Calendar print_One:t inMonth:t2];
                                
                                
                            }
                            else{
                                printf("cal: %s is neither a month number (1..12) nor a name\n",d1);
                            }
                            
                            
                            
                        }
                        else{
                            printf("cal: year %d not in range 1..9999\n",t);
                            
                        }
                        
                        
                    }
                    
                    
                }
                 }
    return 0;
}