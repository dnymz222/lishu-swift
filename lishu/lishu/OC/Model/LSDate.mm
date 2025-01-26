//
//  LSDate.m
//  lishu
//
//  Created by xueping on 2021/3/7.
//

#import "LSDate.h"
#include "AA+.h"
//#import "LSTimeZoneMapLocation.h"


@implementation LSDate

- (instancetype)initWithDate:(NSDate *)date {
    self  = [super init];
    if (self) {
        
   
   
      
       
        [self calculateDate:date timezone:[NSTimeZone systemTimeZone]];
        
        self.timeZone  = [NSTimeZone systemTimeZone];
        
        
    }
    
    return self;
}

- (instancetype)initWithDate:(NSDate *)date timezone:(nonnull NSTimeZone*)timeZone {
    
    self=[super init];
    if (self) {
        [self calculateDate:date timezone:timeZone];
        
        self.timeZone  = timeZone;
    }
    return self;
}


- (void)calculateDate:(NSDate *)date timezone:(NSTimeZone *)timezone{
    
    
    self.date = date;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian  ];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    
    
    
    self.year = comps.year;
    self.month  = comps.month;
    self.day   =  comps.day;
    self.hour=(int) comps.hour;
    self.minutes =(int) comps.minute;
    self.second = comps.second;
    
    
   
    NSCalendar *localcalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian  ];
    [localcalendar setTimeZone:timezone];
    
    NSDateComponents *localcomps = [localcalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    
    
    
    self.localYear = localcomps.year;
    self.localMonth  = localcomps.month;
    self.localDay   =  localcomps   .day;
    self.localHour =(int) localcomps.hour;
    self.localMinute  =(int) localcomps.minute;
    self.localDayInWeek=  (int)localcomps.weekday;
    self.localSecond = localcomps.second;
    
//    self.second = comps.second;
    
    self.offset = [timezone secondsFromGMTForDate:date];
    
    
    self.JD  = [self julianDay];
    
    
    
    
}


- (instancetype)initWithDate:(NSDate *)date timezoneName:(nonnull NSString *)timezoneName {
    self  = [super init];
    if (self) {
        
   
      
      
        
        [self calculateDate:date timezone:[NSTimeZone timeZoneWithName:timezoneName]];
        
        
        self.timeZone = [NSTimeZone timeZoneWithName:timezoneName];
        
        
    }
    
    return self;
}

- (instancetype)initWithYear:(int)year month:(int)month day:(int)day {
    self  = [super init];
    if (self) {
        
      
        
        NSTimeZone *timezone = [NSTimeZone systemTimeZone];
        
        self.timeZone = timezone;
        NSInteger h_offset = [timezone secondsFromGMT] ;
        
        int offset = 0;
        
        NSDate *date = [LSDate dateWithYear:year month:month day:day];
        
        //夏令时修正
        if (h_offset < 0) {
            
          
            NSDate *localdate = [NSDate dateWithTimeInterval:3601 sinceDate:date];
            
            
           offset = [timezone secondsFromGMTForDate:localdate] ;
            
            
          
        } else {
            
           NSDate *localdate = [NSDate dateWithTimeInterval:-3601 sinceDate:date];
            offset = [timezone secondsFromGMTForDate:localdate] ;
            
            
            
        }
        
        
        
        NSDate *datefix = [LSDate dateWithYear:year month:month day:day offset:offset];
        

        
        [self calculateDate:datefix timezone:timezone];
        
    }
    return self;
}


- (instancetype)initWithYear:(int)year month:(int)month day:(int)day timezone:(NSString *)timezoneName {
    self  = [super init];
    if (self) {
        
      
       
        NSTimeZone *timezone = [NSTimeZone timeZoneWithName:timezoneName];
        self.timeZone = [NSTimeZone timeZoneWithName:timezoneName];
        NSInteger h_offset = [timezone secondsFromGMT] ;
        
        int offset = 0;
        
        NSDate *date = [LSDate dateWithYear:year month:month day:day];
        
        //夏令时修正
        if (h_offset < 0) {
            
          
            NSDate *localdate = [NSDate dateWithTimeInterval:3601 sinceDate:date];
            
            
           offset = [timezone secondsFromGMTForDate:localdate] ;
            
            
          
        } else {
            
           NSDate *localdate = [NSDate dateWithTimeInterval:-3601 sinceDate:date];
            offset = [timezone secondsFromGMTForDate:localdate] ;
            
            
            
        }
        
        
        
        NSDate *datefix = [LSDate dateWithYear:year month:month day:day offset:offset];
        

        
        [self calculateDate:datefix timezone:timezone];
     
        
        
        
    }
    return self;
}




+ (LSDate *)localZerodateWithDate:(NSDate *)date timeZone:(NSString *)timezoneName {
    
    
    
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian  ];
    
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:timezoneName];
    [calendar setTimeZone:timezone];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday fromDate:date];
    
    
    

   
    
    return [[LSDate alloc] initWithYear:comps.year month:comps.month day:comps.day timezone: timezoneName];
    
}


- (double)date2julianDay {
    
      CAADate date = CAADate(_year,_month,_day,_hour,_minutes,_second,TRUE);
    
     return date.Julian();
    

}

+ (NSDate *)julianDaytoDate:(double)jd {
    
    CAADate date = CAADate(jd,TRUE);
    
    int year  = date.Year();
    int month  = date.Month();
    int day  = date.Day();
    int hour  = date.Hour();
    int minutes   =date.Minute();
    double second   = date.Second();
    
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier: NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    NSDateComponents *component = [[NSDateComponents alloc] init];
    component.year = year;

    component.month = month;
    component.day = day;
    component.hour = hour;
    component.minute = minutes;
    component.second = second;
    
 
    
    return  [calendar dateFromComponents:component];
    
          
          

    
    
    
}

+(NSDate *)dateWithYear:(int)year month:(int)month day:(int)day {
    
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier: NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    NSDateComponents *component = [[NSDateComponents alloc] init];
    component.year = year;

    component.month = month;
    component.day = day;
    component.hour = 0;
    component.minute = 0;
    component.second = 0;
    
 
    
    return  [calendar dateFromComponents:component];
    
    
    
}


+(NSDate *)dateWithYear:(int)year month:(int)month day:(int)day offset:(int)offset{
    
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier: NSCalendarIdentifierGregorian];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    
    NSDateComponents *component = [[NSDateComponents alloc] init];
    component.year = year;

    component.month = month;
    component.day = day;
    component.hour = 0;
    component.minute = 0;
    component.second = 0;
    
 
    
    NSDate *date = [calendar dateFromComponents:component];


   return [NSDate dateWithTimeInterval:-offset sinceDate:date];

    
}






- (instancetype)initWithJD:(double)JD {
    
    self   =[super init];
    if (self) {
        
        if (JD < 1) {
            return nil;
        }


        
    
      
        NSDate *date = [LSDate julianDaytoDate:JD];
        
        [self calculateDate:date timezone:[NSTimeZone systemTimeZone]];
        
        


        
    }
    
    return self;
    
}



- (instancetype)initWithJD:(double)JD timezone:(NSString *)timezoneName {
    
    self   =[super init];
    if (self) {
        
        if (JD < 1) {
            return nil;
        }

        NSDate *date = [LSDate julianDaytoDate:JD];
        
        [self calculateDate:date timezone:[NSTimeZone timeZoneWithName:timezoneName]];


        
    }
    
    return self;
    
}


- (double)julianDay {
    
    CAADate date = CAADate(_year,_month,_day,_hour,_minutes,_second,TRUE);
  
   return date.Julian();
}


- (CAA2DCoordinate )calculatetimeLineWithLongtitude:(double)longtitude latitude:(double)latitude Equatoria:(CAA2DCoordinate) Equatorial  {
        
    
    double Longitude = -longtitude; //West is considered positive
    double Latitude = latitude;
    double Height = 1706;
    const CAA2DCoordinate SunTopo = CAAParallax::Equatorial2Topocentric(Equatorial.X, Equatorial.Y, self.sunRad, Longitude, Latitude, Height, self.TTJD);


    double AST = CAASidereal::ApparentGreenwichSiderealTime(self.JD);
    double LongtitudeAsHourAngle = CAACoordinateTransformation::DegreesToHours(Longitude);
    double LocalHourAngle = AST - LongtitudeAsHourAngle - SunTopo.X;
    CAA2DCoordinate SunHorizontal = CAACoordinateTransformation::Equatorial2Horizontal(LocalHourAngle, SunTopo.Y, Latitude);
    SunHorizontal.Y += CAARefraction::RefractionFromTrue(SunHorizontal.Y, 1013, 10);



    double SunHorizontal_X  = CAACoordinateTransformation::MapTo0To360Range(SunHorizontal.X+180);

    double   sun_Height  = SunHorizontal.Y;
    double  sun_Azimuth = SunHorizontal_X;
    
    CAA2DCoordinate coordinate ;
    
    coordinate.X  = sun_Height;
    coordinate.Y  = sun_Azimuth;
    
    return coordinate;
}
    

//- (void)calculateLocation {
//    
//    self.locationArray = [NSMutableArray array];
//    
//   
//    
//      double JDSun = CAADynamicalTime::UTC2TT(self.JD);
//    self.TTJD  = JDSun;
//
//       double SunLong = CAASun::ApparentEclipticLongitude(JDSun, false);
//      // double SunLong2 = CAASun::ApparentEclipticLongitude(JDSun, true);
//       double SunLat = CAASun::ApparentEclipticLatitude(JDSun, false);
//       //double SunLat2 = CAASun::ApparentEclipticLatitude(JDSun, true);
//       CAA2DCoordinate Equatorial = CAACoordinateTransformation::Ecliptic2Equatorial(SunLong, SunLat, CAANutation::TrueObliquityOfEcliptic(JDSun));
//    
//    const double SunRad = CAAEarth::RadiusVector(JDSun, false);
//    
//    self.sunRad  =SunRad;
//
//
//    double AST = CAASidereal::ApparentGreenwichSiderealTime(self.JD);
//    
//    
//    double hour  =AST- Equatorial.X;
//    
//    double degress  = 90 + Equatorial.Y;
//    
////    double sunradain  =CAACoordinateTransformation::DegreesToRadians(degress);
////
////    double hourdegree   = CAACoordinateTransformation::HoursToDegrees(hour);
////
////
//    int fix  = Equatorial.Y > 0 ? 1:-1;
//    
//    self.fix   =fix;
//    
//    for (int i =  0; i < 360+1; i ++) {
//        
//        double longtitude =  -180 +i;
//        
//        int check = 0; //0:初始化 1：(heigt<-0.8) 2：height > -0.8    3: 完成
//        
//        int latitude =0;
//        
//        while (check < 3) {
//            if (1 == check) {
//                if (fix > 0) {
//                    ++latitude;
//                } else {
//                    --latitude;
//                }
//                
//            } else if(2 == check){
//                if (fix >0 ) {
//                    --latitude;
//                } else {
//                    ++latitude;
//                }
//            }
//            
//            CAA2DCoordinate sun  = [self calculatetimeLineWithLongtitude:longtitude latitude:latitude Equatoria:Equatorial];
//            if (0 == check) {
//                if (sun.X < -0.8) {
//                    check = 1;
//                } else {
//                    check = 2;
//                }
//            }
//            
//            if (check == 1) {
//                if (sun.X > -0.8) {
//                    check=3;
//                }
//            } else {
//                if (sun.X < -0.8) {
//                    check = 3;
//                }
//            }
//            if (latitude > 79) {
//                break;
//            }
//            
//            if (latitude < -59) {
//                break;
//            }
//        }
//        
//        CLLocation *loc = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
//        
//        LSTimeZoneMapLocation *location = [[LSTimeZoneMapLocation alloc] initWithLocation:loc];
//        [self.locationArray addObject:location];
//        
//        
//        
//        
//    
//        
//        
//    }
//    
//
//}


//- (void)calculateTwlightLocation {
//    
//    self.twlightLocationArray = [NSMutableArray array];
//    
//   
//    
//      double JDSun = CAADynamicalTime::UTC2TT(self.JD);
//    self.TTJD  = JDSun;
//
//       double SunLong = CAASun::ApparentEclipticLongitude(JDSun, false);
//      // double SunLong2 = CAASun::ApparentEclipticLongitude(JDSun, true);
//       double SunLat = CAASun::ApparentEclipticLatitude(JDSun, false);
//       //double SunLat2 = CAASun::ApparentEclipticLatitude(JDSun, true);
//       CAA2DCoordinate Equatorial = CAACoordinateTransformation::Ecliptic2Equatorial(SunLong, SunLat, CAANutation::TrueObliquityOfEcliptic(JDSun));
//    
//    const double SunRad = CAAEarth::RadiusVector(JDSun, false);
//    
//    self.sunRad  =SunRad;
//
//
//    double AST = CAASidereal::ApparentGreenwichSiderealTime(self.JD);
//    
//    
//    double hour  =AST- Equatorial.X;
//    
//    double degress  = 90 + Equatorial.Y;
//    
////    double sunradain  =CAACoordinateTransformation::DegreesToRadians(degress);
////
////    double hourdegree   = CAACoordinateTransformation::HoursToDegrees(hour);
////
////
//    int fix  = Equatorial.Y > 0 ? 1:-1;
//    
//    self.fix   =fix;
//    
//    for (int i =  0; i < 360+1; i ++) {
//        
//        double longtitude =  -180 +i;
//        
//        int check = 0; //0:初始化 1：(heigt<-0.8) 2：height > -0.8    3: 完成
//        
//        int latitude =0;
//        
//        while (check < 3) {
//            if (1 == check) {
//                if (fix > 0) {
//                    ++latitude;
//                } else {
//                    --latitude;
//                }
//                
//            } else if(2 == check){
//                if (fix >0 ) {
//                    --latitude;
//                } else {
//                    ++latitude;
//                }
//            }
//            
//            CAA2DCoordinate sun  = [self calculatetimeLineWithLongtitude:longtitude latitude:latitude Equatoria:Equatorial];
//            if (0 == check) {
//                if (sun.X < -6) {
//                    check = 1;
//                } else {
//                    check = 2;
//                }
//            }
//            
//            if (check == 1) {
//                if (sun.X > -6) {
//                    check=3;
//                }
//            } else {
//                if (sun.X < -8) {
//                    check = 3;
//                }
//            }
//            if (latitude > 79) {
//                break;
//            }
//            
//            if (latitude < -59) {
//                break;
//            }
//        }
//        
//        CLLocation *loc = [[CLLocation alloc] initWithLatitude:latitude longitude:longtitude];
//        
//        LSTimeZoneMapLocation *location = [[LSTimeZoneMapLocation alloc] initWithLocation:loc];
//        [self.twlightLocationArray addObject:location];
//        
//        
//        
//        
//    
//        
//        
//    }
//    
//
//}


- (NSString *)localTimeString {
    
    
    NSString *timestring = [NSString stringWithFormat:@"%02d:%02d",self.localHour,self.localMinute];
    
    return timestring;
    
}

- (NSString *)localFullTimeString {
    NSString *dayString = [NSString stringWithFormat:@"%02d-%02d %02d:%02d:%02d",self.localMonth,self.localDay,self.localHour,self.localMinute, (int)self.localSecond];
    return dayString;
}

- (NSString *)localdayString {
    
    NSString *dayString = [NSString stringWithFormat:@"%02d-%02d",self.localMonth,self.localDay];
    return dayString;
}


- (LSDate *)dateforDayDelta:(int)days {
    
    NSDate *date = [NSDate dateWithTimeInterval:days*86400 sinceDate:self.date];
    
    LSDate *lsdate = [[LSDate alloc] initWithDate:date timezone:self.timeZone];
    
    return lsdate;
    
}


- (LSDate *)dateforNearWeekDay:(int)dayInweek before:(BOOL)is_before {
    
    
    for (int i = 1; i < 15; i++) {
        
        int days = is_before?-i:i;
        NSDate *date = [NSDate dateWithTimeInterval:days*86400 sinceDate:self.date];
        
        LSDate *lsdate = [[LSDate alloc] initWithDate:date timezone:self.timeZone];
        if (dayInweek+1 == lsdate.localDayInWeek) {
            return lsdate;
        }
    }
    
    return nil;
    
}



@end
