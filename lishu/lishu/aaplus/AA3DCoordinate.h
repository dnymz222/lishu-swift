/*
Module : AA3DCoordinate.h
Purpose: Implementation for the simple class to encapsulate a three dimensional coordinate
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

#ifndef __AA3DCOORDINATE_H__
#define __AA3DCOORDINATE_H__

#ifndef AAPLUS_EXT_CLASS
#define AAPLUS_EXT_CLASS
#endif //#ifndef AAPLUS_EXT_CLASS


/////////////////////// Classes ///////////////////////////////////////////////

class AAPLUS_EXT_CLASS CAA3DCoordinate
{
public:
//Constructors / Destructors
  CAA3DCoordinate() noexcept : X(0),
                               Y(0),
                               Z(0)
  {
  };
  CAA3DCoordinate(const CAA3DCoordinate&) = default;
  CAA3DCoordinate(CAA3DCoordinate&&) = default;
  ~CAA3DCoordinate() = default;

//Methods
  CAA3DCoordinate& operator=(const CAA3DCoordinate&) = default;
  CAA3DCoordinate& operator=(CAA3DCoordinate&&) = default;

//Member variables
  double X;
  double Y;
  double Z;
};


#endif //#ifndef __AA3DCOORDINATE_H__
