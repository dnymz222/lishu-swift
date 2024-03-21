//
//  LSEra.m
//  lishu
//
//  Created by xueping on 2021/10/23.
//

#import "LSEra.h"

@interface LSEra ()





@end


@implementation LSEra

- (instancetype)initWithYear:(int)year type:(LSCalendarType)type {
    
    self  =[super init];
    if (self) {
        
        self.year = year;
        
        LSCalendarTypeModel *startcalendar = [[LSCalendarTypeModel alloc] initWithType:type];
        [startcalendar calculcateYear:year month:1 day:1];
        self.startCalendar =startcalendar;
        self.startDate = self.startCalendar.lsdate;
        
        LSCalendarTypeModel *endcalendar = [[LSCalendarTypeModel alloc] initWithType:type];
        [endcalendar calculcateYear:year month:12 day:31];
        self.endCalendar = endcalendar ;
        self.endDate = self.endCalendar.lsdate;
        
        
        
        
        
    }
    return self;
}




@end
