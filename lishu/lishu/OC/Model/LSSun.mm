//
//  LSSun.m
//  lishu
//
//  Created by xueping on 2021/3/24.
//

#import "LSSun.h"
#include "AA+.h"
#include "AHAAHelper.hpp"
#import "LSDate.h"


@implementation LSSun


- (instancetype)initWithJD:(double)jd
{
    self  =[super init];
    if (self) {
        
        self.jd = jd;
        
    }
    
    return self;
    
}



- (void)calculateSun {
    
     double JDSun = CAADynamicalTime::UTC2TT(self.jd);

        double SunLong = CAASun::ApparentEclipticLongitude(JDSun, false);
       // double SunLong2 = CAASun::ApparentEclipticLongitude(JDSun, true);
        double SunLat = CAASun::ApparentEclipticLatitude(JDSun, false);
        //double SunLat2 = CAASun::ApparentEclipticLatitude(JDSun, true);
        CAA2DCoordinate Equatorial = CAACoordinateTransformation::Ecliptic2Equatorial(SunLong, SunLat, CAANutation::TrueObliquityOfEcliptic(JDSun));
        double suneq_long =CAACoordinateTransformation::MapTo0To24Range(Equatorial.X);

        SunLong = CAACoordinateTransformation::MapTo0To360Range(SunLong);
    
    
     self.RA = suneq_long;
     self.Dec = Equatorial.Y;
    
    
    self.R = CAAEarth::RadiusVector(self.jd, false);
    
    
       
//    SCCelestialBody *bodyData = [[SCCelestialBody alloc] initWithAplha:suneq_long Delta:Equatorial.Y Lamada:SunLong beta:SunLat H:SunHorizontal_X A:SunHorizontal.Y R:SunRad];
//
//    self.bodyData = bodyData;
    
    
}

+ (double)calculateSunLongWithJd:(double)jd {
    
     double JDSun = CAADynamicalTime::UTC2TT(jd);

        double SunLong = CAASun::ApparentEclipticLongitude(JDSun, true);
       // double SunLong2 = CAASun::ApparentEclipticLongitude(JDSun, true);
//        double SunLat = CAASun::ApparentEclipticLatitude(JDSun, false);
//        //double SunLat2 = CAASun::ApparentEclipticLatitude(JDSun, true);
//        CAA2DCoordinate Equatorial = CAACoordinateTransformation::Ecliptic2Equatorial(SunLong, SunLat, CAANutation::TrueObliquityOfEcliptic(JDSun));
//        double suneq_long =CAACoordinateTransformation::MapTo0To24Range(Equatorial.X);
    
//    double SunLong = CAASun::GeometricEclipticLongitude(JDSun, true);
    
    return CAACoordinateTransformation::MapTo0To360Range(SunLong);

    
}


+ (double)calculateSunLongWithStartJd:(double)startjd  endJd:(double)endJd startLong:(double)startLong endLong:(double)endLong targetSunLong:(double)sunlong {
    
//    double result = [LSSun calculateSunLongWithJd:startjd];
//    double resultjd =  startjd;
//    if (result > 355) {
//        result = result-360;
//    }
    
    double resultjd = startjd;
    
    if (sunlong > startLong) {
        
        resultjd =  startjd + (sunlong-startLong)*360/365.25;
        
    } else {
        resultjd = endJd - (endLong - sunlong)*360/365.25;
        
    }
    
    double result = [LSSun calculateSunLongWithJd:resultjd  ];
    
    
   
    while (fabs(sunlong-result) > 0.000001) {
        
        resultjd =  resultjd + (sunlong-result)*365.25/360 ;
        result =  [LSSun calculateSunLongWithJd:resultjd];
        
        if (result > 355) {
            result = result-360;
        }
        
    }
    
    
    return resultjd;
    
    
    
}











- (void)calculateSunRiseSetWithlocation:(LSGeoPosition *)location date:(NSDate *)date timezone:(NSString *)timezone {
    
    self.riseSet =  [self calculateSunRiseSet:-0.8333 location:location date:date timezone:timezone];
    self.civilRiseSet = [ self calculateSunRiseSet:-6 location:location date:date timezone:timezone];
    self.nuticalRiseSet = [self calculateSunRiseSet:-12 location:location date:date timezone:timezone];
    self.astroRiseSet  = [self calculateSunRiseSet:-18 location:location date:date timezone:timezone];
}



- (LSRiseSetTime*)calculateSunRiseSet:(double)altitude location:(LSGeoPosition *)location date:(NSDate *)date timezone:(NSString *)timezone{
    
    LSDate *zerodate = [LSDate localZerodateWithDate:date timeZone:timezone ];
             double zerojd = [zerodate julianDay];
          
       CAARiseTransitSetDetails  sunrisesetdetail = GetSunRiseTransitSet(zerojd,-location.Longitude,location.Latitude,altitude);
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
    
    LSRiseSetTime *risesetTime =[[LSRiseSetTime alloc] initWithRiseJd:sunrisejd setJD:sunsetjd transitJD:suntransitjd nextDay:NO transitAbove:sunrisesetdetail.bTransitAboveHorizon];
    
    return risesetTime;
    
    
    
}


@end
