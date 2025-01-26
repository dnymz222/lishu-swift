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
        
        CAADate date = CAADate(year,month,day,0,0,10,true);
        self.gyear = year;
        self.gmonth = month;
        self.gday = day;
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
        
        CAADate date = CAADate(year,month,day,false);
        date.SetInGregorianCalendar(true);
        self.year = year;
        self.month = month;
        self.day  =day;
        self.gyear = date.Year();
        self.gmonth = date.Month();
        self.gday = date.Day();
        
       
        
    }
    return self;
}

+(LSDate *)convertJuliantoGerDayWithYear:(int)year month:(int)month day:(int)day{
    
 
        
        CAADate date = CAADate(year,month,day,0,0,10,false);
        date.SetInGregorianCalendar(true);
    LSDate *lsdate = [[LSDate alloc] initWithYear:date.Year() month:date.Month() day:date.Day() ];
    
    return lsdate;
        

}

@end
