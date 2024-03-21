//
//  LSMoon.m
//  lishu
//
//  Created by xueping on 2021/3/24.
//

#import "LSMoon.h"
#include "AA+.h"
#include "AHAAHelper.hpp"
#import "LSDate.h"

@implementation LSMoon



- (instancetype)initWithJD:(double)jd {
        
    self = [super init];
    if (self) {
        
        self.jd = jd;
    }
    return self;
}


- (void)calculateMoon{
    
    double JDMoon = CAADynamicalTime::UTC2TT(self.jd);


    double jlamada = CAAMoon::EclipticLongitude(JDMoon);
    double jbeta = CAAMoon::EclipticLatitude(JDMoon);
    double eclipsion = CAANutation::TrueObliquityOfEcliptic(self.jd);
    double R = CAAMoon::RadiusVector(self.jd);
    CAA2DCoordinate coordinate = CAACoordinateTransformation::Ecliptic2Equatorial(jlamada,jbeta,eclipsion);

    double alpha = coordinate.X;
    double delta = coordinate.Y;
    jlamada = CAACoordinateTransformation::MapTo0To360Range(jlamada);
    
    double illuminated_fraction = 0;
    double position_angle = 0;
    double phase_angle = 0;
    GetMoonIllumination(self.jd, illuminated_fraction, position_angle, phase_angle);
    
    self.RA = alpha;
    self.Dec = delta;
    
    

    self.distance = R;
    self.R  = R;
    
    self.illuminated_fraction = illuminated_fraction;
    self.positionAngle = position_angle;
    self.phaseangle = phase_angle;
    
    
    
    
    
}

- (void)calcuateMoonRiseSetWithLocation:(LSGeoPosition *)location date:(NSDate *)date timeZone:(NSString *)timezone
{
    LSDate *zerodate = [LSDate localZerodateWithDate:date timeZone:timezone];
    double zerojd = [zerodate julianDay];
    
    CAARiseTransitSetDetails  risedetail = GetMoonRiseTransitSet(zerojd,-location.Longitude ,location.Latitude);
    self.moonnextDay = NO;
    
    double risejd = 0;
    if (risedetail.bRiseValid) {
        risejd = risedetail.Rise/24.0 + zerojd;
    }
    
    double setjd = 0;
    if (risedetail.bSetValid) {
        setjd = risedetail.Set/24.0 + zerojd;
    }
    
//    if (setjd < risejd) {
//        CAARiseTransitSetDetails  risedetail_next = GetMoonRiseTransitSet(zerojd+1,-location.Longitude ,location.Latitude);
//        if (risedetail_next.bSetValid) {
//            setjd = risedetail_next.Set/24.0 + zerojd +1;
//            self.moonnextDay  = YES;
//        }
//
//    }
    
    
    double moontransitjd = 0;
    if (risedetail.bTransitValid) {

            moontransitjd  =(risedetail.Transit)/24.0 + zerojd;

    }
    
//    if (moontransitjd < risejd ) {
//        CAARiseTransitSetDetails  risedetail_next = GetMoonRiseTransitSet(zerojd+1,-location.Longitude ,location.Latitude);
//        if (risedetail_next.bTransitValid) {
//            moontransitjd    = risedetail_next.Transit/24.0 + zerojd +1;
//            self.moontransitNextDay  = YES;
//        }
//    }

    
    self.moonRiseJD = risejd;
    self.moonSetJD = setjd;
    self.moontransitJD = moontransitjd;
    
    double illuminated_fraction = 0;
    double position_angle = 0;
    double phase_angle = 0;
    GetMoonIllumination(zerojd+0.5, illuminated_fraction, position_angle, phase_angle);
    self.moonillumation = illuminated_fraction;
    [self calculateMoonageWithJD:zerojd+0.5];

//    self.distance =CAAMoon::RadiusVector(zerojd +1);

    
    
    
    
    
}


+ (double)lastmoondateWithJd:(double)jd K:(double)k {
    
    CAADate  aadate  =CAADate(jd, true);

    double fraction =aadate.FractionalYear();

    double kvalue = floor(CAAMoonPhases::K(fraction));

    double phasejulian  = CAAMoonPhases::TruePhase(kvalue + k);
    if (phasejulian > jd  ) {
        phasejulian  =CAAMoonPhases ::TruePhase(kvalue+k - 1);
    }


    return phasejulian;
    
}

- (void)calculateMoonageWithJD:(double)JD {
    
    double lastnewjd = [LSMoon lastmoondateWithJd:JD K:0];
     self.moonage =JD - lastnewjd;
    
    
    
}

+ (double)nextmoondateWithJd:(double)jd K:(double)k {
    
      CAADate  aadate  =CAADate(jd, true);

       double fraction =aadate.FractionalYear();

       double kvalue = floor(CAAMoonPhases::K(fraction));

       double phasejulian  = CAAMoonPhases::TruePhase(kvalue + k);
       if (phasejulian <jd  ) {
           phasejulian  =CAAMoonPhases ::TruePhase(kvalue+k+1);
       }


       return phasejulian;
    
}



@end
