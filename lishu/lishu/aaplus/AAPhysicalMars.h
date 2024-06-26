/*
Module : AAPhysicalMars.h
Purpose: Implementation for the algorithms which obtain the physical parameters of Mars
Created: PJN / 04-01-2004

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

#ifndef __AAPHYSICALMARS_H__
#define __AAPHYSICALMARS_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


/////////////////////// Classes ///////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAAPhysicalMarsDetails
{
public:
  CAAPhysicalMarsDetails() noexcept : DE(0),
                                      DS(0),
                                      w(0),
                                      P(0),
                                      X(0),
                                      k(0),
                                      q(0),
                                      d(0)
  {
  };
  CAAPhysicalMarsDetails(const CAAPhysicalMarsDetails&) = default;
  CAAPhysicalMarsDetails(CAAPhysicalMarsDetails&&) = default;
  ~CAAPhysicalMarsDetails() = default;

//Methods
  CAAPhysicalMarsDetails& operator=(const CAAPhysicalMarsDetails&) = default;
  CAAPhysicalMarsDetails& operator=(CAAPhysicalMarsDetails&&) = default;

//Member variables
  double DE;
  double DS;
  double w;
  double P;
  double X;
  double k;
  double q;
  double d;
};

class AAPLUS_EXT_CLASS CAAPhysicalMars
{
public:
//Static methods
  static CAAPhysicalMarsDetails Calculate(double JD, bool bHighPrecision) noexcept;
};


#endif //#ifndef __AAPHYSICALMARS_H__
