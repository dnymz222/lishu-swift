//
//  AHAAHelper.hpp
//  Astrohelper
//
//  Created by xueping on 2020/3/4.
//  Copyright © 2020 xueping. All rights reserved.
//

#ifndef AHAAHelper_hpp
#define AHAAHelper_hpp


#include "AA+.h"
#include <stdio.h>

void GetSolarRaDecByJulian(double JD, bool bHighPrecision, double& RA, double& Dec);

void GetLunarRaDecByJulian(double JD, double& RA, double& Dec);

CAARiseTransitSetDetails GetSunRiseTransitSet(double JD, double longitude, double latitude, double altitude);



CAARiseTransitSetDetails GetMoonRiseTransitSet(double JD, double longitude, double latitude);

void GetMoonIllumination(double JD, double& illuminated_fraction, double& position_angle, double& phase_angle);


CAARiseTransitSetDetails GetStarRiseTransitSet2(double JD,double RA,double Dec, double longitude, double latitude,double altitude);


#endif /* AHAAHelper_hpp */
