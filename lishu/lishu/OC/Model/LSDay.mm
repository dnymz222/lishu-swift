//
//  LSDay.m
//  lishu
//
//  Created by xueping on 2021/3/11.
//

#import "LSDay.h"
#include "AA+.h"
#import "LSYear.h"


@interface LSDay ()



@end

@implementation LSDay


- (instancetype)initWithDate:(NSDate *)date timezone:(NSString *)timzone {
    
    self =  [super init];
    if (self) {
        
        self.lsdate = [[LSDate alloc] initWithDate:date timezoneName:timzone];
        
        self.offset =  self.lsdate.offset;
        self.date =  date;
        self.dayInMonth  =self.lsdate.localDay;
        self.year = self.lsdate.localYear;
        self.month = self.lsdate.localMonth;
        
        NSInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear;
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        [calendar setTimeZone:[NSTimeZone timeZoneWithName:timzone]];
        NSDateComponents*     comps = [calendar components:unitFlags fromDate:date];
        
        self.dayInWeek = comps.weekday;
        
        self.timeZone = timzone;
        self.jd = self.lsdate.JD;
        
//        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self.date];
//        self.yearDays  = range.length;
////        self. = (int)range.length;
//
//        self.dayInYear =[calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self.date];
    
        
    }
    return self;
}


- (instancetype)initWithyear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day timezone:(NSString *)timzone {
    
    self = [super init];
    if (self) {
        
        self.lsdate = [[LSDate alloc] initWithYear:year month:month day:day timezone:timzone];
        self.offset = self.lsdate.offset;
   
        self.date = self.lsdate.date;
        self.dayInMonth  =self.lsdate.localDay;
        self.year = self.lsdate.localYear;
        self.month = self.lsdate.localMonth;
        
        NSInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear;
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        [calendar setTimeZone:[NSTimeZone timeZoneWithName:timzone]];
        NSDateComponents*     comps = [calendar components:unitFlags fromDate:self.date];
        
        self.dayInWeek = comps.weekday;
        self.jd = self.lsdate.JD;
        self.timeZone = timzone;
        
//        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self.date];
//        self.yearDays  = range.length;
////        self. = (int)range.length;
//        
//        self.dayInYear =[calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self.date];
        
    }
    return self;
    
    
}

- (void)calculateSolunarWithLocation:(CLLocation *)location {
    
    
    
    
}

- (void)calulateMoonWithLocation:(LSGeoPosition *)location {
    
    self.moon = [[LSMoon alloc] init];
    self.moon.jd = self.lsdate.JD;
    [self calulateSolunar];
    
    [self.moon calcuateMoonRiseSetWithLocation:location date:self.date timeZone:self.timeZone];
    
    
    
   
}

- (void)calculateSunWithLocation:(LSGeoPosition *)location

{
    self.sun = [[LSSun alloc] init];
    self.sun.jd = self.lsdate.JD;
    [self.sun calculateSunRiseSetWithlocation:location date:self.date timezone:self.timeZone];
    
    
}


- (void)calculateGridPhaseAngle {
    
    LSMoon *moon = [[LSMoon alloc] init];
    double JD = self.lsdate.JD +0.5;
    
 
    [moon calculateMoonageWithJD:JD];
    
   
}


- (void)calulateSolunar {
    double jd = self.jd +0.5;
    double JDUD = CAADynamicalTime::UTC2TT(jd);
    double jmoonlamada = CAAMoon::EclipticLongitude(JDUD);
    
    double SunLong = CAASun::ApparentEclipticLongitude(JDUD, false);
    
    double delata = jmoonlamada- SunLong;
    while (delata < 0) {
        delata   += 360 ;
    }
    
    self.phase_delta = delata;
    
    
}


- (void)calculateCalendarWithLSYear:(LSYear *)lsyear {
    
    self.clanedarArray = [NSMutableArray array];
    
    
    
    
    for (int i= 0; i < 19; i++) {
        LSCalendarTypeModel *model = [[LSCalendarTypeModel alloc] initWithType:(LSCalendarType)i timezone:self.timeZone];
        [model calculcateYear:self.year month:self.month day:self.dayInMonth];
        [model calculateFestivalWithLSYear:lsyear];
        
        [self.clanedarArray addObject:model];
        
    }
    
    

    
}


- (void)calculatePlanet:(LSPlanet *)planet {
    
    
    
}

@end
