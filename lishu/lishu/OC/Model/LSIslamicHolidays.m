//
//  LSIslamicHolidays.m
//  lishu
//
//  Created by xueping on 2021/11/7.
//

#import "LSIslamicHolidays.h"

@implementation LSIslamicHolidays

- (instancetype)initWithYear:(int)year {
    self = [super init];
    
    if (self) {
        
        self.year = year;
        self.type = (int)LSCalendarTypeIslamic;
        
        LSDate *zeroDate = [[LSDate alloc] initWithYear:year month:1 day:1 ];
        int days = [self isLeap:year]?366:365;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        for (int i = 0; i < days; i++) {
            LSCalendarTypeModel *calnedar = [[LSCalendarTypeModel alloc] initWithType:LSCalendarTypeIslamic timezone:@"Asia/Shanghai"];
            
            LSDate *lsdate = [zeroDate dateforDayDelta:i];
            
            [calnedar calculcateYear:lsdate.localYear month:lsdate.localMonth day:lsdate.localDay];
            [calnedar calculateFestivalWithLSYear:nil];
            
            if (calnedar.isFestival) {
                
                LSIslamicHolidayItem *item = [[LSIslamicHolidayItem alloc] initWithCalendarModel:calnedar];
                
                [dataArray  addObject:item];
                
            }
            
        }
        
        self.dataArray   = dataArray.copy;
        
        
    }
    return self;
}


- (BOOL)isLeap:(int)Year {
    if ((Year % 100) == 0)
      return ((Year % 400) == 0) ? YES : NO;
    else
      return ((Year % 4) == 0) ? YES : false;
}


@end

@implementation LSIslamicHolidayItem

- (instancetype)initWithCalendarModel:(LSCalendarTypeModel *)calendarModel {
    
    self = [super init];
    if (self) {
        
        self.type = (int)LSCalendarTypeIslamic;
        self.calendarModel   = calendarModel;
        
        self.lsdate = calendarModel.lsdate;
        self.name = calendarModel.festivalString;
        
        
        
    }
    return self;
}


@end
