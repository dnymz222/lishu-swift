//
//  LSAstroPostion.m
//  lishu
//
//  Created by xueping on 2021/3/24.
//

#import "LSAstroPostion.h"
#include "AA+.h"



@implementation LSAstroPostion

- (instancetype)initWithHeight:(double)height azimuth:(double)azimuth {
    
    self   = [super init];
    if (self) {
        
        self.Height   =height;
        self.Azimuth  =azimuth;
        
    }
    return self;
}

- (void)calculateDec:(double)dec latitude:(double)latitude {
    
    
    double decRadian = dec/180.0*M_PI;
    double latitudeRadian =  latitude/180*M_PI;
    double x = sin(latitudeRadian)*tan(decRadian);
    double y =  cos(latitudeRadian);
    if (fabs(x) > fabs(y)) {
        if (x*y >0) {
            self.isAbove   =YES;
        } else {
            self.isBelow  = YES;
        }
       
  
    } else {
        
        double value  = x/y;
        double xita = asin(value);
        self.RiseAzimuth = 90-xita/M_PI *180.0;
        self.SetAzimuth  =270+xita/M_PI*180.0;
        if (self.Azimuth > self.RiseAzimuth && self.Azimuth < self.SetAzimuth) {
            self.fixAzimuth   =90 + (self.Azimuth-self.RiseAzimuth)/(self.SetAzimuth-self.RiseAzimuth)*180;
        } else {
            
            double deltaAzimuth   = self.Azimuth - self.SetAzimuth;
            double delta  =CAACoordinateTransformation::MapTo0To360Range(deltaAzimuth );
            double fixazimuth = 270 + delta/(360-(self.SetAzimuth-self.RiseAzimuth))*180;
            self.fixAzimuth =CAACoordinateTransformation::MapTo0To360Range(fixazimuth );
            
        }
    }
    
}

@end
