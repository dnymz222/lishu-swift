/*
Module : AANearParabolic.h
Purpose: Implementation for the algorithms for a near parabolic orbit
Created: PJN / 29-12-2003

Copyright (c) 2003 - 2020 by PJ Naughter (Web: www.naughter.com, Email: pjna@naughter.com)

All rights reserved.

Copyright / Usage Details:

You are allowed to include the source code in any product (commercial, shareware, freeware or otherwise) 
when your product is released in binary form. You are allowed to modify the source code in any way you want 
except you cannot modify the copyright details at the top of each module. If you want to distribute source 
code with your application, then you are only allowed to distribute versions released by the author. This is 
to maintain a single distribution point for the source code. 

*/


/////////////////////// Macros / Defines //////////////////////////////////////

#if _MSC_VER > 1000
#pragma once
#endif //#if _MSC_VER > 1000

#ifndef __AANEARPARABOLIC_H__
#define __AANEARPARABOLIC_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


/////////////////////// Includes //////////////////////////////////////////////

#include "AA3DCoordinate.h"


/////////////////////// Classes ///////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAANearParabolicObjectElements
{
public:
//Constructors / Destructors
  CAANearParabolicObjectElements() noexcept : q(0),
                                              i(0),
                                              w(0),
                                              omega(0),
                                              JDEquinox(0),
                                              T(0),
                                              e(1.0)
  {
  };
  CAANearParabolicObjectElements(const CAANearParabolicObjectElements&) = default;
  CAANearParabolicObjectElements(CAANearParabolicObjectElements&&) = default;
  ~CAANearParabolicObjectElements() = default;

//Methods
  CAANearParabolicObjectElements& operator=(const CAANearParabolicObjectElements&) = default;
  CAANearParabolicObjectElements& operator=(CAANearParabolicObjectElements&&) = default;

//Member variables
  double q;
  double i;
  double w;
  double omega;
  double JDEquinox;
  double T;
  double e;
};

class AAPLUS_EXT_CLASS CAANearParabolicObjectDetails
{
public:
//Constructors / Destructors
  CAANearParabolicObjectDetails() noexcept : HeliocentricEclipticLongitude(0),
                                             HeliocentricEclipticLatitude(0),
                                             TrueGeocentricRA(0),
                                             TrueGeocentricDeclination(0),
                                             TrueGeocentricDistance(0),
                                             TrueGeocentricLightTime(0),
                                             AstrometricGeocentricRA(0),
                                             AstrometricGeocentricDeclination(0),
                                             AstrometricGeocentricDistance(0),
                                             AstrometricGeocentricLightTime(0),
                                             Elongation(0),
                                             PhaseAngle(0)
  {
  };
  CAANearParabolicObjectDetails(const CAANearParabolicObjectDetails&) = default;
  CAANearParabolicObjectDetails(CAANearParabolicObjectDetails&&) = default;
  ~CAANearParabolicObjectDetails() = default;

//Methods
  CAANearParabolicObjectDetails& operator=(const CAANearParabolicObjectDetails&) = default;
  CAANearParabolicObjectDetails& operator=(CAANearParabolicObjectDetails&&) = default;

//Member variables
  CAA3DCoordinate HeliocentricRectangularEquatorial;
  CAA3DCoordinate HeliocentricRectangularEcliptical;
  double HeliocentricEclipticLongitude; 
  double HeliocentricEclipticLatitude;
  double TrueGeocentricRA;
  double TrueGeocentricDeclination;
  double TrueGeocentricDistance;
  double TrueGeocentricLightTime;
  double AstrometricGeocentricRA;
  double AstrometricGeocentricDeclination;
  double AstrometricGeocentricDistance;
  double AstrometricGeocentricLightTime;
  double Elongation;
  double PhaseAngle;
};

class AAPLUS_EXT_CLASS CAANearParabolic
{
public:
//Static methods
  static CAANearParabolicObjectDetails Calculate(double JD, const CAANearParabolicObjectElements& elements, bool bHighPrecision) noexcept;
  static double cbrt(double x) noexcept;
  static void CalculateTrueAnnomalyAndRadius(double JD, const CAANearParabolicObjectElements& elements, double& v, double& r) noexcept;
};


#endif //#ifndef __AANEARPARABOLIC_H__
