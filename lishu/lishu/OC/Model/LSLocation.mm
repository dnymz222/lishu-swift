//
//  LSLocation.m
//  lishu
//
//  Created by xueping on 2021/3/13.
//

#import "LSLocation.h"
#import <YYModel/YYModel.h>
#import "LSNetWorkHandler.h"
#import "LSNetWorkHelper.h"
#import "LSAccuCurrentWetherModel.h"
#include "AA+.h"
#import "LSDate.h"
#include "AHAAHelper.hpp"




@interface LSLocation ()

@property(nonatomic,assign)NSInteger lastTimeStamp;

@property(nonatomic,assign)BOOL isRequesTing;

@property(nonatomic,assign)NSInteger lastRequestTimeStemp;


@end


@implementation LSLocation

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{@"GeoPosition":[LSGeoPosition class],
             @"TimeZone":[LSTimeZone class],
             @"ParentCity":[LSParentCity class],
             @"CountryOrDistrict":[LSCountryOrDistrictModel class],
             @"AdministrativeArea":[LSAdministrativeAreaModel class]
             
    };
}

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    
    return @{@"CountryOrDistrict":@"Country"};
}

- (NSString *)LocalizedName {
    if (_LocalizedName) {
        if (0 == _LocalizedName.length) {
            return _EnglishName;
        }
    }
    
    return _LocalizedName;
}


- (NSCalendar *)calendar    {
    if (!_calendar) {
        _calendar   = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [_calendar setTimeZone:[NSTimeZone timeZoneWithName:self.TimeZone.Name]];
    }
    return _calendar;
}

- (void)calcuteDate:(NSDate *)date isShow:(BOOL)isShow{
    
    
    self.date   =date;
    
   
    self.lsDate = [[LSDate alloc] initWithDate:date timezoneName:self.TimeZone.Name];
    
    NSInteger nowstemp = [[NSDate date] timeIntervalSince1970];
    
    if (self.currentModel) {
        if (nowstemp -self.lastRequestTimeStemp > 15*60  && isShow) {
            [self requestCurrent];
        }
       
        
    } else {
        
        self.lastRequestTimeStemp = 0;
        [self requestCurrent];
    }
    

    
    
       
       // 直接调用自己weekDay属性
//    [self.clockView configHour:comps.hour minutes:comps.minute seconds:comps.second];

    
}



- (void)calculateSun:(LSSun *)sun {
    
    double JDSun = CAADynamicalTime::UTC2TT(sun.jd);
    
    
    const double SunRad = sun.R;
   // const double SunRad2 = CAAEarth::RadiusVector(JDSun, true);
//    UNREFERENCED_PARAMETER(SunRad2);
    double Longitude = -self.GeoPosition.Longitude; //West is considered positive
    double Latitude = self.GeoPosition.Latitude;
    double Height = 1706;
    const CAA2DCoordinate SunTopo = CAAParallax::Equatorial2Topocentric(sun.RA, sun.Dec, SunRad, Longitude, Latitude, Height, JDSun);


    double AST = CAASidereal::ApparentGreenwichSiderealTime(JDSun);
    double LongtitudeAsHourAngle = CAACoordinateTransformation::DegreesToHours(Longitude);
    double LocalHourAngle = AST - LongtitudeAsHourAngle - SunTopo.X;
    CAA2DCoordinate SunHorizontal = CAACoordinateTransformation::Equatorial2Horizontal(LocalHourAngle, SunTopo.Y, Latitude);
    SunHorizontal.Y += CAARefraction::RefractionFromTrue(SunHorizontal.Y, 1013, 10);



 


    double SunHorizontal_X  = CAACoordinateTransformation::MapTo0To360Range(SunHorizontal.X+180);

 

//   self.Height  = SunHorizontal.Y;
//   self.Azimuth = SunHorizontal_X;
    
    


//    NSLog(@"topx:%.1f,topy:%.1f,localangle:%0.1f,heigt:%.1f,azimuth:%.1f",SunTopo.X,SunTopo.Y,LocalHourAngle,SunHorizontal.Y,SunHorizontal_X);


    self.sunPostion  = [[LSAstroPostion alloc] initWithHeight:SunHorizontal.Y azimuth:SunHorizontal_X];
    [self.sunPostion calculateDec:sun.Dec latitude:self.GeoPosition.Latitude];


    
    
}

- (void)calculateMoon:(LSMoon *)moon {
    
    double JDMoon = CAADynamicalTime::UTC2TT(moon.jd);




    double  MoonRad =moon.R /149597870.691; //Convert KM to AU
    double   Longitude = -self.GeoPosition.Longitude; //West is considered positivejd
    double   Latitude = self.GeoPosition.Latitude;

    double Height = 1706;
    const CAA2DCoordinate MoonTopo = CAAParallax::Equatorial2Topocentric(moon.RA, moon.Dec, MoonRad, Longitude, Latitude, Height, JDMoon);
    double AST = CAASidereal::ApparentGreenwichSiderealTime(JDMoon);
    double LongtitudeAsHourAngle = CAACoordinateTransformation::DegreesToHours(Longitude);
    double LocalHourAngle = AST - LongtitudeAsHourAngle - MoonTopo.X;
    CAA2DCoordinate MoonHorizontal = CAACoordinateTransformation::Equatorial2Horizontal(LocalHourAngle, MoonTopo.Y,Latitude);
    MoonHorizontal.Y += CAARefraction::RefractionFromTrue(MoonHorizontal.Y, 1013, 10);

    double H = MoonHorizontal.X;
    double A = MoonHorizontal.Y;


    H = CAACoordinateTransformation::MapTo0To360Range(H+180);


//    double mooneq_long = CAACoordinateTransformation::MapTo0To360Range(CAACoordinateTransformation::HoursToDegrees(alpha));




    
//    SCCelestialBody *bodyData = [[SCCelestialBody alloc] initWithAplha:mooneq_long Delta:delta Lamada:jlamada beta:jbeta H:H A:A R:R];
//    self.bodyData = bodyData;
    
    

//    self.Height = A;
//    self.Azimuth = H;
//    self.distance = R;
    
    self.moonPosition  = [[LSAstroPostion alloc] initWithHeight:A azimuth:H];
    
    [self.moonPosition calculateDec:moon.Dec latitude:self.GeoPosition.Latitude];
    
//    NSLog(@"topx:%.1f,topy:%.1f,localangle:%0.1f,heigt:%.1f,azimuth:%.1f",MoonTopo.X,MoonTopo.Y,LocalHourAngle,A,H);
   
    
    
    
    
}





- (void)requestCurrent {
   
    
    if (self.isRequesTing) {
        return;
    }
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",self.GeoPosition.Latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",self.GeoPosition.Longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [LSNetWorkHelper   cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.Key,
                           @"language":NSLocalizedString(@"language", nil)
                           };
    
    self.isRequesTing   =YES;
    
    [LSNetWorkHandler currentWithparamater:dict success:^(NSURLResponse *response, id data) {
        
        
        self.isRequesTing   =NO;
       
        NSArray *dataArray = (NSArray *)data;
        
        LSAccuCurrentWetherModel *model = [LSAccuCurrentWetherModel yy_modelWithJSON:dataArray[0]];
        
        self.currentModel  = model;
        NSDate *date = [NSDate date];
        self.lastRequestTimeStemp = [date timeIntervalSince1970];
        
        
  
       
        
    } failed:^(NSError *error) {
        self.isRequesTing  = NO;
       
    }];
}

- (void)calcualateSunRiseSet {
    
    self.sunRiseSet   =[self calcualateSunRiseSetWithHeight:-0.8333];
    self.civilRiseSet   =[self calcualateSunRiseSetWithHeight:-6];
    self.nutaionRiseSet  = [self calcualateSunRiseSetWithHeight:-12];
    self.astroRiseSet   =[self calcualateSunRiseSetWithHeight:-18];
}

- (LSRiseSetTime*)calcualateSunRiseSetWithHeight:(double)height {
    
   LSDate *zerodate = [LSDate localZerodateWithDate:self.date timeZone:self.TimeZone.Name];
          double zerojd =[zerodate julianDay];
       
    CAARiseTransitSetDetails  sunrisesetdetail = GetSunRiseTransitSet(zerojd,-self.GeoPosition.Longitude,self.GeoPosition.Latitude,height);
    double sunrisejd = 0;
    
       if (sunrisesetdetail.bRiseValid) {

               sunrisejd  =(sunrisesetdetail.Rise)/24.0 + zerojd;
       }


       double sunsetjd = 0;
       if (sunrisesetdetail.bSetValid) {

               sunsetjd  =(sunrisesetdetail.Set)/24.0 + zerojd;

       }

       double suntransitjd = 0;
       if (sunrisesetdetail.bTransitValid) {

               suntransitjd  =(sunrisesetdetail.Transit)/24.0 + zerojd;

       }
    
    LSRiseSetTime *risesetTime =[[LSRiseSetTime  alloc] initWithRiseJd:sunrisejd setJD:sunsetjd transitJD:suntransitjd nextDay:NO transitAbove:sunrisesetdetail.bTransitAboveHorizon];
    
    return risesetTime;
    
}


- (void)calculateMoonRiseSet {
    
    LSDate *zerodate = [LSDate localZerodateWithDate:self.date timeZone:self.TimeZone.Name];
    double zerojd = [zerodate julianDay];
    
    CAARiseTransitSetDetails  risedetail = GetMoonRiseTransitSet(zerojd,-self.GeoPosition.Longitude  ,self.GeoPosition.Latitude);
    BOOL  moonnextDay = NO;
    
    double risejd = 0;
    if (risedetail.bRiseValid) {
        risejd = risedetail.Rise/24.0 + zerojd;
    }
    
    double setjd = 0;
    if (risedetail.bSetValid) {
        setjd = risedetail.Set/24.0 + zerojd;
    }
    
    double transitjd = 0;
    if (risedetail.bTransitValid) {

            transitjd =(risedetail .Transit)/24.0 + zerojd;

    }
    
    if (setjd < risejd) {
        CAARiseTransitSetDetails  risedetail_next = GetMoonRiseTransitSet(zerojd+1,-self.GeoPosition.Longitude  ,self.GeoPosition.Latitude);
        if (risedetail_next.bSetValid) {
            setjd = risedetail_next.Set/24.0 + zerojd +1;
            moonnextDay  = YES;
        }
        
    }
    
    
    LSRiseSetTime *risesetTime =[[LSRiseSetTime  alloc] initWithRiseJd:risejd setJD:setjd transitJD:transitjd nextDay:moonnextDay transitAbove:risedetail.bTransitAboveHorizon];
    
    self.moonriseSet   =risesetTime;
    
//    self.moonRiseJD = risejd;
//    self.moonSetJD = setjd;
    
    

    
}


- (void)calcualteAstronomicalTime:(double)jd {
    
    self.JD = jd;
    

    
    self.TTJD =  CAADynamicalTime::UTC2TT(self.JD);
    
    
//    if (!self.lssun) {
        self.lssun = [[LSSun alloc] initWithJD:self.JD];
        [self.lssun calculateSun];
        
//    }
//    if (!self.lsmoon) {
        self.lsmoon = [[LSMoon alloc] initWithJD:self.JD];
        [self.lsmoon calculateMoon];
//    }
    
    
    self.meanSiderealTime =CAASidereal::MeanGreenwichSiderealTime(self.TTJD);
    
   
    
    
    double  MoonRad =self.lsmoon.R /149597870.691; //Convert KM to AU
    double   Longitude = -self.GeoPosition.Longitude; //West is considered positivejd
    double   Latitude = self.GeoPosition.Latitude;

    double Height = 1706;
    const CAA2DCoordinate MoonTopo = CAAParallax::Equatorial2Topocentric(self.lsmoon.RA, self.lsmoon.Dec, MoonRad, Longitude, Latitude, Height, self.TTJD);
    double AST = CAASidereal::ApparentGreenwichSiderealTime(self.TTJD);
    self.apparentSiderealTime = AST;
    
    double LongtitudeAsHourAngle = CAACoordinateTransformation::DegreesToHours(Longitude);
    double LocalHourAngle = AST - LongtitudeAsHourAngle - MoonTopo.X;
    
    CAA2DCoordinate MoonHorizontal = CAACoordinateTransformation::Equatorial2Horizontal(LocalHourAngle, MoonTopo.Y,Latitude);
    
    MoonHorizontal.Y += CAARefraction::RefractionFromTrue(MoonHorizontal.Y, 1013, 10);

    double H = MoonHorizontal.X;
//    double A = MoonHorizontal.Y;


    H = CAACoordinateTransformation::MapTo0To360Range(H+180);
    
    self.lunarTime = LocalHourAngle;
    
    
    
    
    const double SunRad = self.lssun.R;
   // const double SunRad2 = CAAEarth::RadiusVector(JDSun, true);
//    UNREFERENCED_PARAMETER(SunRad2);
 

    const CAA2DCoordinate SunTopo = CAAParallax::Equatorial2Topocentric(self.lssun.RA, self.lssun.Dec, SunRad, Longitude, Latitude, Height, self.TTJD);


    double sunLocalHourAngle = AST - LongtitudeAsHourAngle - SunTopo.X;
    
    
    CAA2DCoordinate SunHorizontal = CAACoordinateTransformation::Equatorial2Horizontal(sunLocalHourAngle, SunTopo.Y, Latitude);
    SunHorizontal.Y += CAARefraction::RefractionFromTrue(SunHorizontal.Y, 1013, 10);

    
    NSLog(@"x:%0.1f",SunTopo.X);
 


    double SunHorizontal_X  = CAACoordinateTransformation::MapTo0To360Range(SunHorizontal.X+180);
    
    self.trueSolarTime = sunLocalHourAngle;
    
    
    
    
    
    
    
    
    
    
    
}






@end
