//
//  LSStaticAstroBody.m
//  lishu
//
//  Created by xueping on 2021/3/13.
//

#import "LSStaticAstroBody.h"
#include "AA+.h"
#include "AHAAHelper.hpp"
#import "LSDate.h"



@implementation LSStaticAstroBody


- (instancetype)initWithRA:(double)RA dec:(double)Dec{
    self = [super init];
    if (self) {
        self.RA = RA;
        self.Dec = Dec;
    }
    return self;
}

- (LSRiseSetTime*)calculaterisesetWithZeroJd:(double)zerojd location:(LSGeoPosition *)location {
    
       
    
       double alpha = self.RA;
        double delta = self.Dec;
          
        double jd2000 =2451545.0;
          
            
        CAA2DCoordinate coordate = CAAPrecession ::PrecessEquatorial(alpha, delta, jd2000, zerojd);
          
          alpha = coordate.X;
          delta  = coordate.Y;
    
//    alpha = self.RA;
//    delta = self.Dec;
    
    CAARiseTransitSetDetails  starrisesetdetail = GetStarRiseTransitSet2(zerojd, alpha, delta, -location.Longitude, location.Latitude, -0.57);
           if (!starrisesetdetail.bTransitAboveHorizon) {
               
               LSRiseSetTime *risetime = [[LSRiseSetTime alloc] initWithRiseJd:0 setJD:0 transitJD:0 nextDay:NO transitAbove:NO];
               risetime.nextday_transit = NO;
               return risetime;
               
           } else{
           
               double risejd = 0;
               
               BOOL nextday = NO;
               BOOL nextday_transit = NO;
               
               if (starrisesetdetail  .bRiseValid) {
                   risejd = starrisesetdetail.Rise/24.0+zerojd;
               }
               
               double transitJd = 0;
               if (starrisesetdetail.bTransitValid) {
                   transitJd = starrisesetdetail.Transit/24.0+zerojd;
               }
               
               double setjd = 0;
               if (starrisesetdetail.bSetValid) {
                   setjd = starrisesetdetail.Set/24.0 + zerojd;
               }
               
               if (risejd > transitJd) {
                   CAARiseTransitSetDetails  starrisesetdetail_next = GetStarRiseTransitSet2(zerojd+1, self.RA, self.Dec, -location.Longitude, location.Latitude, -0.57);
                                     if (starrisesetdetail_next.bTransitValid) {
                                         nextday_transit = YES;
                                         transitJd = starrisesetdetail_next.Transit/24.0+zerojd+1;
                                         if (transitJd - risejd > 1) {
                                             
                                             CAARiseTransitSetDetails  starrisesetdetail_next = GetStarRiseTransitSet2(zerojd+0.5, self.RA, self.Dec, -location.Longitude, location.Latitude, -0.57);
                                             
                                             transitJd = starrisesetdetail_next.Transit/24.0+zerojd+0.5;
                                             
                                             if (transitJd < zerojd+1) {
                                                 nextday_transit = NO;
                                             }
                                             
                                         }
                                    }
               }
               
               
               
               if (risejd > setjd) {
                   CAARiseTransitSetDetails  starrisesetdetail_next = GetStarRiseTransitSet2(zerojd+1, self.RA, self.Dec, -location.Longitude, location.Latitude, -0.57);
                   if (starrisesetdetail_next.bSetValid) {
                       nextday = YES;
                       setjd = starrisesetdetail_next.Set/24.0+zerojd+1;
                       
                       if (setjd-risejd > 1) {
                           CAARiseTransitSetDetails  starrisesetdetail_next = GetStarRiseTransitSet2(zerojd+0.5, self.RA, self.Dec, -location.Longitude, location.Latitude, -0.57);
                           setjd = starrisesetdetail_next.Set/24.0+zerojd+0.5;
                           if (setjd < zerojd+1) {
                               nextday = NO;
                           }
                       }
                   }
               }
               
             
                LSRiseSetTime *risetime = [[LSRiseSetTime alloc] initWithRiseJd:risejd setJD:setjd transitJD:transitJd nextDay:nextday transitAbove:YES];
               risetime.nextday_transit = nextday_transit;
            
               return risetime;
                 
               
           }
    
}



@end
