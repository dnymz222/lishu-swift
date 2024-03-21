//
//  LSPlanet.m
//  lishu
//
//  Created by xueping on 2021/3/13.
//

#import "LSPlanet.h"
#import "LSDate.h"
#include "AA+.h"
#include "AHAAHelper.hpp"


@implementation LSPlanet



- (instancetype)initWithType:(LSPlanetType)type {
    self = [super init];
    if (self) {
        
        self.type = type;
        switch (type) {
            case LSPlanetTypeMecury:{
                self.name = NSLocalizedString(@"mercury",nil);
//                self.magnitude = 2.39;
//                self.imageName  =@"Mercury";
            }
                
                break;
            case LSPlanetTypeVenus:
                self.name = NSLocalizedString(@"venus",nil);
//                self.magnitude = -3.9;
//                self.imageName =@"Venus";
                break;
            case LSPlanetTypeMars:
                self.name = NSLocalizedString(@"mars",nil);
//                self.magnitude = -0.54;
//                self.imageName = @"Mars";
                break;
            case LSPlanetTypeSaturn:
                self.name = NSLocalizedString(@"saturn",nil);
//                self.magnitude = 0.61;
//                self.imageName  = @"Saturn";
                break;
            case LSPlanetTypeJupiter:
                self.name = NSLocalizedString(@"jupiter",nil);
//                self.magnitude = -2.3;
//                self.imageName = @"Jupiter";
                break;
            case LSPlanetTypeUranus:
                self.name = NSLocalizedString(@"uranus",nil);
//                self.magnitude = 6.5;
//                self.imageName = @"Uranus";
                break;
            case LSPlanetTypeNeptune:
                self.name = NSLocalizedString(@"neptune",nil);
//                self.imageName = @"Neptune";
//                self.magnitude = 6.5;
                break;
            case LSPlanetTypePluto:
                self.name = NSLocalizedString(@"pluto",nil);
//                self.magnitude = 6.5;
//                self.imageName = @"Pluto";
                break;
                
            default:
                break;
        }
        
        
//        self.ahdate = [[AHDate alloc] initWithDate:date];
//        self.date = date;
//        self.jd = [self.ahdate date2julianDay];
//        self.location = location;
        
        
    }
    
    
    return self;
}


- (LSRiseSetTime *)calculateRiseTransitSetWithZeroJD:(double)zerojd location:(LSGeoPosition *)location   {
    

    
    std::vector<CAARiseTransitSetDetails2> events;
    
    switch (self.type) {
        case LSPlanetTypeMecury:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::MERCURY, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeVenus:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::VENUS, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeMars:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::MARS, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeSaturn:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::SATURN, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeJupiter:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::JUPITER, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeUranus:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::URANUS, -location.Longitude, location.Latitude, -0.5567);
            break;
       case LSPlanetTypeNeptune:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::NEPTUNE, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypePluto:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::PLUTO, -location.Longitude, location.Latitude, -0.5567);
            break;
        default:
            break;
    }
    
    

     double risejd = 0;
     double setjd = 0;
     double transitjd = 0;
    
    
    for (const auto& event : events)
    {
      switch (event.type)
      {
        case CAARiseTransitSetDetails2::Type::Rise:
        {
            risejd = CAADynamicalTime::TT2UTC(event.JD);
        
        }
               break;
        case CAARiseTransitSetDetails2::Type::Set:
        {
          setjd= CAADynamicalTime::TT2UTC(event.JD);
          
        }
              
               break;
        case CAARiseTransitSetDetails2::Type::SouthernTransit:
        {
            
            if (location.Latitude < 0) {
                transitjd= CAADynamicalTime::TT2UTC(event.JD);
            }


           
        }
               break;
        case CAARiseTransitSetDetails2::Type::NorthernTransit:
        {

            if (location.Latitude < 0) {
                
            } else {
                
                transitjd= CAADynamicalTime::TT2UTC(event.JD);
            }

           
            
            
         
        }
              break;
        default:
              
              break;
              
      }
    }
    
    if (risejd > setjd) {
        
        setjd = [self calculatenextSetJdWithZerojd:zerojd +1  location:location];
//        if (setjd > 0) {
            self.nextDay = YES;
//        }
        
    }
    
    if (risejd > transitjd) {
        
        transitjd =[self calculatenextTranistWithZerojd:zerojd+1  location:location];
        self.nextTransitDay =  YES;
        
    }
    
    
    
  
     
    
//    self.riseJD = risejd;
//    self.transitJD = transitjd;
//    self.setJD  = setjd;
    
    

    LSRiseSetTime *riseSet = [[LSRiseSetTime alloc] initWithRiseJd:risejd setJD:setjd transitJD:transitjd nextDay:self.nextDay transitAbove:(transitjd > 0)];
    
    
    
    riseSet.nextday_transit = self.nextTransitDay;
    
    return riseSet;
    
    
    

}


- (double)calculatenextSetJdWithZerojd:(double)zerojd  location:(LSGeoPosition *)location {

       
       
    
    
    std::vector<CAARiseTransitSetDetails2> events;
    
    switch (self.type) {
        case LSPlanetTypeMecury:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::MERCURY, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeVenus:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::VENUS, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeMars:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::MARS, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeSaturn:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::SATURN, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeJupiter:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::JUPITER, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeUranus:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::URANUS, -location.Longitude, location.Latitude, -0.5567);
            break;
       case LSPlanetTypeNeptune:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::NEPTUNE, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypePluto:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::PLUTO, -location.Longitude, location.Latitude, -0.5567);
            break;
        default:
            break;
    }
    
    

     double setjd = 0;
  
    
    
    for (const auto& event : events)
    {
      switch (event.type)
      {
       
        case CAARiseTransitSetDetails2::Type::Set:
        {
          setjd= CAADynamicalTime::TT2UTC(event.JD);
          
        }
              
               break;
      
    
        default:
              
              break;
              
      }
    }
     
    
    return setjd;
    

}


- (double)calculatenextTranistWithZerojd:(double)zerojd  location:(LSGeoPosition *)location {

       
       
    
    
    std::vector<CAARiseTransitSetDetails2> events;
    
    switch (self.type) {
        case LSPlanetTypeMecury:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::MERCURY, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeVenus:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::VENUS, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeMars:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::MARS, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeSaturn:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::SATURN, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeJupiter:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::JUPITER, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypeUranus:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::URANUS, -location.Longitude, location.Latitude, -0.5567);
            break;
       case LSPlanetTypeNeptune:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::NEPTUNE, -location.Longitude, location.Latitude, -0.5567);
            break;
        case LSPlanetTypePluto:
             events =  CAARiseTransitSet2::Calculate(CAADynamicalTime::UTC2TT(zerojd), CAADynamicalTime::UTC2TT(zerojd+1), CAARiseTransitSet2::Object::PLUTO, -location.Longitude, location.Latitude, -0.5567);
            break;
        default:
            break;
    }
    
    

     double transitJD = 0;
  
    
    
    for (const auto& event : events)
    {
      switch (event.type)
      {
       
        case CAARiseTransitSetDetails2::Type::NorthernTransit:
        {
            
            if (location.Latitude < 0) {
                    
            } else {
                transitJD = CAADynamicalTime::TT2UTC(event.JD);
            }
          
        }
              
               break;
          case CAARiseTransitSetDetails2::Type::SouthernTransit:
          {
              if (location.Latitude < 0) {
                  transitJD = CAADynamicalTime::TT2UTC(event.JD);
              }
              
          }
              break;
      
    
        default:
              
              break;
              
      }
    }
     
    
    return transitJD;
    

}




@end
