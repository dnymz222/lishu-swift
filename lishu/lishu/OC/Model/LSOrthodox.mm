//
//  LSOrthodox.m
//  lishu
//
//  Created by xueping on 2021/10/24.
//

#import "LSOrthodox.h"
#include "AA+.h"



@implementation LSOrthodox

- (instancetype)initWithYear:(int)year {
    self = [super init];
    if (self) {
        
        CAAEasterDetails easter = CAAEaster::Calculate(year, false);
        
        self.type = (int)LSCalendarTypeOrthodoxHolidays;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        
//        int e = 0;
//        if (year>1600)
//         {
//             int  y2=floor(year/100.0);
//             e=10+y2-16-floor((y2-16)/4.0);
//         }
//        if (year<1583)
//         {
//             e=0;
//         }
//
//        int G=year%19;
//        int  I=(19*G+15)%30;
//        int J= (year+(int)floor(year/4.0)+I)%7;
//        int L=I-J;
//        int p=L+e;
//        int d=1+(p+27+(int)floor((p+6)/40.0))%31;
//        int  m=3+floor((p+26)/30.0)-1;
        
        
        
            int   a, b, d, c ,e , day ;
           int y = year;
                        
            a=(y%19);b=(y%4);c=(y%7);d=(16+19*a)%30;e=((2*b)+(4*c)+(6*d))%7;
            day=3+d+e ;
            int m = 4;
            if (day > 30) {
                m = 5;
                day = day-30;
            }
             
        
        
        
        LSDate *easterdate = [LSJulianCalendar convertJuliantoGerDayWithYear:year month:m day:day];
        LSDate *PalmSunday = [easterdate dateforNearWeekDay:0 before:YES];
        LSDate *Ascension = [easterdate dateforDayDelta:39];
        LSDate *Pentecost = [easterdate dateforDayDelta:49];
        
        
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithYear:year-1 month:12 day:25 name:@"Nativity of the Lord"]];
        
        
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithYear:year month:1 day:6 name:@"Theophany"]];
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithYear:year month:2 day:2 name:@"Presentation of the Lord"]];
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithYear:year month:3 day:25 name:@"Annunciation"]];
        
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithLSdate:PalmSunday name:@"Palm Sunday"]];
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithYear:year month:m day:day name:@"Pascha" ]];
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithLSdate:Ascension name:@"Ascension" ]];
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithLSdate:Pentecost name:@"Pentecost"]];
        
        
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithYear:year month:8 day:6 name:@"Transfiguration"]];
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithYear:year month:8 day:15 name:@"Dormition"]];
        
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithYear:year month:9 day:8 name:@"Nativity of the Theotokos"]];
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithYear:year month:9 day:14 name:@"Elevation of the Holy Cross"]];
        [dataArray addObject:[[LSOrthodoxItem alloc] initWithYear:year month:11 day:21 name:@"Presentation of the Theotokos"]];
       
     
       
        
        
        self.dataArray= dataArray.copy;
        
        
        
        
        
    }
    return self;
}

- (NSArray *)filterItemWithLSDate:(LSDate *)lsdate {
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (LSOrthodoxItem *item in self.dataArray) {
        if (item.lsdate.localYear == lsdate.localYear && item.lsdate.localMonth == lsdate.localMonth && item.lsdate.localDay == lsdate.localDay) {
            [dataArray addObject:item];
        }
    }
    
    
    return dataArray.copy;
}



@end


@implementation LSOrthodoxItem


- (instancetype)initWithYear:(int)year month:(int)month day:(int)day name:(NSString *)name {
    
    self = [super init];
    if (self) {
        
        self.julidanCalendarDay = [[LSJulianCalendar alloc] initWithJulianYear:year month:month day:day];
        self.lsdate = [LSJulianCalendar convertJuliantoGerDayWithYear:year month:month day:day];
        self.name = [[NSBundle mainBundle] localizedStringForKey:name value:@"" table:@"lish"];
        self.type = (int)LSCalendarTypeOrthodoxHolidays;
        
        self.calendarModel = [[LSCalendarTypeModel  alloc] initWithType:LSCalendarTypeOrthodoxHolidays];
        self.calendarModel.calendarYear = self.julidanCalendarDay.year;
        self.calendarModel.calendarMonth = self.julidanCalendarDay.month;
        self.calendarModel.calendarDay = self.julidanCalendarDay.day;
        self.calendarModel.calendarEra = 1;
        
        
        
    }
    return self;
    
}


- (instancetype)initWithLSdate:(LSDate *)lsdate name:(NSString *)name{
    self = [super init];
    if (self) {
        self.julidanCalendarDay =  [[LSJulianCalendar alloc] initWithYear:lsdate.localYear month:lsdate.localMonth day:lsdate.localDay];
        self.lsdate = lsdate;
        self.name = [[NSBundle mainBundle] localizedStringForKey:name value:@"" table:@"lish"];
        self.type = (int)LSCalendarTypeOrthodoxHolidays;
        
        
        self.calendarModel = [[LSCalendarTypeModel  alloc] initWithType:LSCalendarTypeOrthodoxHolidays];
        self.calendarModel.calendarEra = 1;
        self.calendarModel.calendarYear = self.julidanCalendarDay.year;
        self.calendarModel.calendarMonth = self.julidanCalendarDay.month;
        self.calendarModel.calendarDay = self.julidanCalendarDay.day;
    }
    return self;
}


@end



