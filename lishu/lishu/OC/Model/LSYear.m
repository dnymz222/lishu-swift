//
//  LSYear.m
//  lishu
//
//  Created by xueping on 2021/5/31.
//

#import "LSYear.h"

#import "LSCalendarGroup.h"
#import "LSDataBaseTool.h"


#import "LSIslamicHolidays.h"
#import "LSChineseFestival.h"
#import "LSJewish.h"
#import "LSWorldDay.h"
#import "LSChristian.h"
#import "LSOrthodox.h"
#import "LSSolarTermModel.h"



#import "LSMoon.h"


@interface LSYear ()


@property(nonatomic,copy)NSString *timeZone;


@end


@implementation LSYear

- (instancetype)initWithyear:(NSInteger)year timezone:(NSString *)timezone {
    self = [super init];
    if (self) {
        
        self.monthArray = [NSMutableArray array];
        self.year = year;
        self.timeZone = timezone;
        
        for (int i = 0; i < 12; i ++) {
            
            LSMonth *month = [[LSMonth alloc] initWithYear:year month:i+1 timezone:timezone];
            
            [self.monthArray addObject:month];
            
        }
        
        
        
        
    }
    return self;
}

- (void)createFestilvalArray {
    
    NSArray *calendarArray   = [LSDataBaseTool excuteCaledarConfigArrayHasFestival];
    
    self.festivalArray = [NSMutableArray array];
    
    for (LSCalendarTypeModel *model in calendarArray) {
        switch (model.type) {
            case LSCalendarTypeWorldDay :{
                
                LSWorldDay *worldDay = [[LSWorldDay alloc] initWithYear:self.year];
                [self.festivalArray addObject:worldDay];
                
            }
                
                break;
            case LSCalendarTypeHebrew:
            {
                LSJewish *jewish = [[LSJewish alloc] initWithYear:self.year];
                [self.festivalArray addObject:jewish];
            }
                break;
            case LSCalendarTypeOrthodoxHolidays:
            {
                LSOrthodox *orthodox = [[LSOrthodox alloc] initWithYear:self.year];
                [self.festivalArray addObject:orthodox];
            }
                break;
            case LSCalendarTypeChristianHolidays:
            {
                LSChristian *chritan = [[LSChristian alloc] initWithYear:self.year];
                [self.festivalArray addObject:chritan];
            }
                
                break;
                
            default:
                break;
        }
    }
    
    [self calculateSolorTerm];
    
    
}


- (void)calculateSolorTerm {
    
    
    LSSolarTermModel*solarTerm = [[LSSolarTermModel alloc] initWithYear:self.year timeZone:self.timeZone];
    [solarTerm  calculateSolarTermWithHemisType:0];
    
    
    self.solarTerm = solarTerm;
    
//    self.solarTermFestivalArray = [NSMutableArray array];
//    for (LSSolarTermItemModel *solarItem in solarTerm.solarTermsArray) {
//        if (solarItem.isFestival) {
//            [self.solarTermFestivalArray addObject:solarItem];
//        }
//    }
    
}


- (void)calculateLunarTerm {
    
    
    LSDate *startdate = [[LSDate alloc] initWithYear:self.year month:1 day:1 timezone:self.timeZone];
    
    LSDate *enddate = [[LSDate alloc] initWithYear:self.year+1 month:1 day:1 timezone:self.timeZone];
    
    NSMutableArray *lunarArray = [NSMutableArray array];
    
    double startjd = [LSMoon nextmoondateWithJd:startdate.JD K:0];
    
    double endjd = [LSMoon nextmoondateWithJd:startjd K:1];
    
    while (startjd < enddate.JD) {
        LSLunarTermModel *lunarTermModel = [[LSLunarTermModel alloc] initWithStartJD:startjd endJD:endjd];
        
        
        lunarTermModel.startDate = [[LSDate alloc] initWithJD:startjd timezone:self.timeZone];
        lunarTermModel.endDate = [[LSDate alloc] initWithJD:endjd timezone:self.timeZone];
        
        
        for (LSLunarTermItemModel *itemmodel in lunarTermModel.lunarArray) {
            [itemmodel calculateLocalDate:self.timeZone];
        }
        
        [lunarArray addObject:lunarTermModel];
        startjd = endjd;
        endjd = [LSMoon nextmoondateWithJd:startjd K:1];
        lunarTermModel.duration = endjd-startjd;
        
       
        
       
        
    }
    
    self.lunarItermArray = lunarArray.copy;
    
    
    
}

@end
