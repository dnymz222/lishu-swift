/*
Module : AABinaryStar.h
Purpose: Implementation for the algorithms for a binary star system
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

#ifndef __AABINARYSTAR_H__
#define __AABINARYSTAR_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


/////////////////////// Classes ///////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAABinaryStarDetails
{
public:
//Constructors / Destructors
  CAABinaryStarDetails() noexcept : r(0),
                                    Theta(0),
                                    Rho(0)
  {
  };
  CAABinaryStarDetails(const CAABinaryStarDetails&) = default;
  CAABinaryStarDetails(CAABinaryStarDetails&&) = default;
  ~CAABinaryStarDetails() = default;

//Methods
  CAABinaryStarDetails& operator=(const CAABinaryStarDetails&) = default;
  CAABinaryStarDetails& operator=(CAABinaryStarDetails&&) = default;

//Member variables
  double r;
  double Theta;
  double Rho;
};

class AAPLUS_EXT_CLASS CAABinaryStar
{
public:
//Static methods
  static CAABinaryStarDetails Calculate(double t, double P, double T, double e, double a, double i, double omega, double w) noexcept;
  static double ApparentEccentricity(double e, double i, double w) noexcept;
};


#endif //#ifndef __AABINARYSTAR_H__
