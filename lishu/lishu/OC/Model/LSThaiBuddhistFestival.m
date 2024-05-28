//
//  LSThaiBuddhistCalendar.m
//  lishu
//
//  Created by xueping wang on 2024/5/24.
//

#import "LSThaiBuddhistFestival.h"
#import "LSYear.h"

@implementation LSThaiBuddhistFestival

- (instancetype)initWithYear:(int)year {
    self = [super init];
    if (self) {
        
        self.year = year;
        self.type = (int)LSCalendarTypeZangli;
        
        LSDate *zeroDate = [[LSDate alloc] initWithYear:year month:1 day:1 timezone:@"Asia/Bangkok"];
        int days = [self isLeap:year]?366:365;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        LSYear *lsyear = [[LSYear alloc] initWithyear:year timezone:@"Asia/Bangkok"];
//        [lsyear calculateSolorTerm];
        
        
        for (int i = 0; i < days; i++) {
            LSCalendarTypeModel *calnedar = [[LSCalendarTypeModel alloc] initWithType:LSCalendarTypeThaiLunar timezone:@"Asia/Bangkok"];
            
            LSDate *lsdate = [zeroDate dateforDayDelta:i];
            
            [calnedar calculcateYear:lsdate.localYear month:lsdate.localMonth day:lsdate.localDay];
//            [calnedar calculateFestivalWithLSYear:lsyear];
            
            if (calnedar.taili.isFestival) {
                
                LSThaiBuddhistFestivalItem   *item = [[LSThaiBuddhistFestivalItem alloc] initWithCalendarModel:calnedar];
                
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


@implementation LSThaiBuddhistFestivalItem

- (instancetype)initWithCalendarModel:(LSCalendarTypeModel *)calendarModel {
    
    self = [super init];
    if (self) {
        
        self.type = (int)LSCalendarTypeZangli;
        self.calendarModel   = calendarModel;
        
        self.lsdate = calendarModel.lsdate;
        self.name = calendarModel.festivalString;
        
        
        
    }
    return self;
}



@end
