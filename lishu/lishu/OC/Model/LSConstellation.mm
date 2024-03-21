//
//  LSConstellation.m
//  lishu
//
//  Created by xueping on 2021/5/30.
//

#import "LSConstellation.h"
#include "AA+.h"

@implementation LSConstellation

- (void)calculateRaAndDec {
    
    NSArray *racArray = [self.RightAscension componentsSeparatedByString:@" "];
    NSString *rahour  = racArray[0];
    NSString *ramin = racArray[1];
    self.RA = [rahour intValue] + [ramin doubleValue]/60.0;
    
//    BOOL minus = [self.Declination containsString:@"-"];
//    NSString *declination = [self.Declination stringByReplacingOccurrencesOfString:@"−" withString:@""];
    NSArray *decArray = [self.Declination componentsSeparatedByString:@" "];
    NSString *decdegree = decArray[0];
    double degreevalue = [decdegree doubleValue];
    BOOL minus = degreevalue < 0;
    if (minus) {
        degreevalue = -degreevalue;
    }
    NSString *decmin = decArray[1];
    self.Dec = CAACoordinateTransformation::DMSToDegrees(degreevalue, [decmin doubleValue], 0);
    if (minus) {
        self.Dec = -self.Dec;
    }
    
    
    
}


@end
