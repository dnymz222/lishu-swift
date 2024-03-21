//
//  LSJulianCalendar.m
//  lishu
//
//  Created by xueping on 2021/10/24.
//

#import "LSJulianCalendar.h"
#include "AA+.h"


@implementation LSJulianCalendar

- (instancetype)initWithYear:(int)year month:(int)month day:(int)day{
    
    self = [super init];
    if (self) {
        
        CAADate date = CAADate(year,month,day,true);
        date.SetInGregorianCalendar(false);
        self.year = date.Year();
        self.month = date.Month();
        self.day  =date.Day();
       
        
    }
    return self;
}

- (instancetype)initWithJulianYear:(int)year month:(int)month day:(int)day{
    
    self = [super init];
    if (self) {
        
//        CAADate date = CAADate(year,month,day,true);
//        date.SetInGregorianCalendar(false);
        self.year = year;
        self.month = month;
        self.day  =day;
       
        
    }
    return self;
}

+(LSDate *)convertJuliantoGerDayWithYear:(int)year month:(int)month day:(int)day{
    
 
        
        CAADate date = CAADate(year,month,day,false);
        date.SetInGregorianCalendar(true);
    LSDate *lsdate = [[LSDate alloc] initWithYear:date.Year() month:date.Month() day:date.Day()];
    
    return lsdate;
        

}

@end
