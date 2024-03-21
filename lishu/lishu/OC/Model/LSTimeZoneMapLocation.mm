//
//  LSTimeZoneMapLocation.m
//  lishu
//
//  Created by xueping on 2021/3/8.
//

#import "LSTimeZoneMapLocation.h"
#include "maptrans.hpp"
#include "ofxMercatorMap.h"

@implementation LSTimeZoneMapLocation

- (instancetype)initWithX:(double)x Y:(double)y {
    self  =[super init];
    if (self) {
        self.x  =x;
        self.y =  y;
        
   
       
        
       
        

        ofxMercatorMap      merMap;
        merMap.setup(2004, 1195,-180,-60,180,80);
        CAA2DCoordinate coordinar  = merMap.getLatLonFromScreenLocation(x, y);
        
        NSLog(@"latitude:%0.4f",coordinar.Y);
        NSLog(@"longtitude:%0.4f",coordinar.X);
        
        
        self.location  =[[CLLocation alloc] initWithLatitude:coordinar.Y longitude:coordinar.X];
        
        
        
        
//
        
        
        
    }
    return self;
}


- (instancetype)initWithLocation:(CLLocation *)location {
    
    self  = [super init];
    if (self) {
        
        self.location  = location;

        
        
        
        ofxMercatorMap      merMap;
        merMap.setup(2004, 1195,-180,-60,180,80);
        CAA2DCoordinate coordinar  = merMap.getScreenLocationFromLatLon(location.coordinate.latitude, location.coordinate.longitude);
        
        self.x  = coordinar.X;
        self.y  = coordinar.Y;
        
        
        
        
    }
    
    return self;
    
}






@end
