//
//  LSMonth.m
//  lishu
//
//  Created by xueping on 2021/5/31.
//

#import "LSMonth.h"
#import "LSDate.h"


@implementation LSMonth

- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month timezone:(NSString *)timezone {
    
    
    self = [super init];
    if (self) {
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [calendar setTimeZone:[NSTimeZone timeZoneWithName:timezone]];
        LSDate *firstdate = [[LSDate alloc] initWithYear:year month:month day:2 timezone:timezone];
        
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:firstdate.date];
        self.days = range.length;
        
        self.daysArray = [NSMutableArray array];
        self.year = year;
        self.month = month;
        self.timeZone = timezone;
        for (int i = 0; i < self.days; i++) {
            
            LSDay  *day =[[LSDay alloc] initWithyear:year month:month day:i+1 timezone:timezone];
            
            if (0 == i) {
                self.firstdayWeekday = day.dayInWeek;
                
                self.startJD = day.lsdate.JD;
            }
            
            [self.daysArray addObject:day];
            
            
        }
        
        self.endJD  = self.startJD + self.days;
        
        
        
      

        
        
    }
    
    return self;
    
}

- (void)caculateLunarTermodel {
    
    self.lunarTermModel = [[LSLunarTermModel alloc] initWithStartJD:self.startJD endJD:self.endJD];
}

@end
