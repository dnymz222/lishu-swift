//
//  LSChineseFestival.m
//  lishu
//
//  Created by xueping on 2021/11/6.
//

#import "LSChineseFestival.h"
#import "LSYear.h"

@implementation LSChineseFestival

- (instancetype)initWithYear:(int)year {
    self = [super init];
    if (self) {
        
        self.year = year;
        self.type = (int)LSCalendarTypeChinese;
        
        LSDate *zeroDate = [[LSDate alloc] initWithYear:year month:1 day:1 timezone:@"Asia/Shanghai"];
        int days = [self isLeap:year]?366:365;
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
        LSYear *lsyear = [[LSYear alloc] initWithyear:year timezone:@"Asia/Shanghai"];
        [lsyear calculateSolorTerm];
        
        
        for (int i = 0; i < days; i++) {
            LSCalendarTypeModel *calnedar = [[LSCalendarTypeModel alloc] initWithType:LSCalendarTypeChinese timezone:@"Asia/Shanghai"];
            
            LSDate *lsdate = [zeroDate dateforDayDelta:i];
            
            [calnedar calculcateYear:lsdate.localYear month:lsdate.localMonth day:lsdate.localDay];
            [calnedar calculateFestivalWithLSYear:lsyear];
            
            if (calnedar.isFestival) {
                
                LSChineseFestivalItem *item = [[LSChineseFestivalItem alloc] initWithCalendarModel:calnedar];
                
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

@implementation LSChineseFestivalItem


- (instancetype)initWithCalendarModel:(LSCalendarTypeModel *)calendarModel {
    
    self = [super init];
    if (self) {
        
        self.type = (int)LSCalendarTypeChinese;
        self.calendarModel   = calendarModel;
        
        self.lsdate = calendarModel.lsdate;
        self.name = calendarModel.festivalString;
        
        
        
    }
    return self;
}

@end
