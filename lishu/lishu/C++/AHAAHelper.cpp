//
//  AHAAHelper.cpp
//  Astrohelper
//
//  Created by xueping on 2020/3/4.
//  Copyright © 2020 xueping. All rights reserved.
//

#include "AHAAHelper.hpp"

void GetSolarRaDecByJulian(double JD, bool bHighPrecision, double& RA, double& Dec)
{
    const double JDSun = CAADynamicalTime::UTC2TT(JD);
    const double lambda = CAASun::ApparentEclipticLongitude(JDSun, bHighPrecision);
    const double beta = CAASun::ApparentEclipticLatitude(JDSun, bHighPrecision);
    const double epsilon = CAANutation::TrueObliquityOfEcliptic(JDSun);
    CAA2DCoordinate Solarcoord = CAACoordinateTransformation::Ecliptic2Equatorial(lambda, beta, epsilon);
    RA = Solarcoord.X;
    Dec = Solarcoord.Y;
}







void GetLunarRaDecByJulian(double JD, double& RA, double& Dec)
{
    const double JDMoon = CAADynamicalTime::UTC2TT(JD);
    const double lambda = CAAMoon::EclipticLongitude(JDMoon);
    const double beta = CAAMoon::EclipticLatitude(JDMoon);
    const double epsilon = CAANutation::TrueObliquityOfEcliptic(JDMoon);
    CAA2DCoordinate Lunarcoord = CAACoordinateTransformation::Ecliptic2Equatorial(lambda, beta, epsilon);
    RA = Lunarcoord.X;
    Dec = Lunarcoord.Y;
}

CAARiseTransitSetDetails GetSunRiseTransitSet(double JD, double longitude, double latitude, double altitude)
{
    double alpha1 = 0;
    double delta1 = 0;
    GetSolarRaDecByJulian(JD - 1, false, alpha1, delta1);
    double alpha2 = 0;
    double delta2 = 0;
    GetSolarRaDecByJulian(JD, false, alpha2, delta2);
    double alpha3 = 0;
    double delta3 = 0;
    GetSolarRaDecByJulian(JD + 1, false, alpha3, delta3);
    return CAARiseTransitSet::Calculate(JD, alpha1, delta1, alpha2, delta2, alpha3, delta3, longitude, latitude, altitude);
}







CAARiseTransitSetDetails GetMoonRiseTransitSet(double JD, double longitude, double latitude)
{
    double alpha1 = 0;
    double delta1 = 0;
    GetLunarRaDecByJulian(JD - 1, alpha1, delta1);
    double alpha2 = 0;
    double delta2 = 0;
    GetLunarRaDecByJulian(JD, alpha2, delta2);
    double alpha3 = 0;
    double delta3 = 0;
    GetLunarRaDecByJulian(JD + 1, alpha3, delta3);
    return CAARiseTransitSet::Calculate(JD, alpha1, delta1, alpha2, delta2, alpha3, delta3, longitude, latitude, 0.125);
}


void GetMoonIllumination(double JD, double& illuminated_fraction, double& position_angle, double& phase_angle)
{
    double moon_alpha = 0;
    double moon_delta = 0;
    GetLunarRaDecByJulian(JD, moon_alpha, moon_delta);
    double sun_alpha = 0;
    double sun_delta = 0;
    GetSolarRaDecByJulian(JD, false, sun_alpha, sun_delta);
    const double geo_elongation = CAAMoonIlluminatedFraction::GeocentricElongation(moon_alpha, moon_delta, sun_alpha, sun_delta);

    position_angle = CAAMoonIlluminatedFraction::PositionAngle(sun_alpha, sun_delta, moon_alpha, moon_delta);
    phase_angle = CAAMoonIlluminatedFraction::PhaseAngle(geo_elongation, 368410.0, 149971520.0);
    illuminated_fraction = CAAMoonIlluminatedFraction::IlluminatedFraction(phase_angle);
}


CAARiseTransitSetDetails GetStarRiseTransitSet2(double JD,double RA,double Dec, double longitude, double latitude,double altitude)
{
//    double  delta = - CAACoordinateTransformation::DMSToDegrees(29,0,28.1);
//
//    double alpha =17.7611;
    double jd2000 = 2451545.0;
    
    CAA2DCoordinate coordainate = CAAPrecession::PrecessEquatorial(RA, Dec, jd2000, JD);
    double alpha = coordainate.X;
    double delta = coordainate.Y;
    
       
    double alpha1 = alpha;
    double delta1 = delta;
//    GetLunarRaDecByJulian(JD - 1, alpha1, delta1);
    double alpha2 = alpha;;
    double delta2 = delta;
//    GetLunarRaDecByJulian(JD, alpha2, delta2);
    double alpha3 = alpha;;
    double delta3 = delta;
//    GetLunarRaDecByJulian(JD + 1, alpha3, delta3);
    
    CAARiseTransitSetDetails detail =  CAARiseTransitSet::Calculate(JD, alpha1, delta1, alpha2, delta2, alpha3, delta3, longitude, latitude, altitude);


    return detail;
}


