//
//  LSStar.m
//  lishu
//
//  Created by xueping on 2021/5/30.
//

#import "LSStar.h"
#include "AA+.h"

@implementation LSStar


- (void)calculateRaAndDec {
    
 
    
     NSString* RightAscension = [self.RightAscension stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    
    
    NSString *Declination = [self.Declination  stringByReplacingOccurrencesOfString:@" " withString:@""];
    BOOL minus = ![Declination containsString:@"+"];
    Declination = [Declination substringFromIndex:1];
    NSArray *hourarray = [RightAscension     componentsSeparatedByString:@"h"];
    NSString *hour = hourarray[0];
    NSString *hoourleft = hourarray[1];
    NSArray *minarray = [hoourleft componentsSeparatedByString:@"m"];
    NSString *min = minarray[0];
    NSString *minleft = minarray[1];
    NSArray *secondarray = [minleft componentsSeparatedByString:@"s"];
    NSString *second = secondarray[0];
    self.RA = [hour intValue] + [min intValue]/60.0 +[second doubleValue]/3600.0;
    
    NSArray *degreearray = [Declination componentsSeparatedByString:@"°"];
    NSString *degree = degreearray[0];
    NSString *degreeleft = degreearray[1];
    NSArray *dmarray = [degreeleft componentsSeparatedByString:@"′"];
    NSString *dm =dmarray[0];
    NSString *dmleft = dmarray[1];
    NSArray *dsarray = [dmleft componentsSeparatedByString:@"″"];
    NSString *ds = dsarray[0];
    
    self.Dec  =CAACoordinateTransformation::DMSToDegrees([degree doubleValue], [dm doubleValue], [ds doubleValue]);
    if (minus) {
        self.Dec = - self.Dec;
    }
    
    
}


@end
