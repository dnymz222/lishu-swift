//
//  LSRiseSetTime.m
//  lishu
//
//  Created by xueping on 2021/4/5.
//

#import "LSRiseSetTime.h"
#import "LSDate.h"

@implementation LSRiseSetTime

- (instancetype)initWithRiseJd:(double)riseJD setJD:(double)setJD transitJD:(double)transitJD nextDay:(BOOL)nextday transitAbove:(BOOL)above {
    
    self = [super init];
    if (self) {
        
        self.riseJD = riseJD;
        self.setJD = setJD;
        self.transitJD  = transitJD;
        self.nextday = nextday;
        self.transitAbove = above;
        
    }
    return self;
}

+ (NSString *)riseSetStringTimeZone:(NSString *)timeZone JD:(double)JD {
    
    if (JD < 1) {
        return @"-";
    }
    
    LSDate *lsdate = [[LSDate alloc] initWithJD:JD timezone:timeZone];
    return [lsdate localTimeString];
    
}

+ (NSString *)riseSetStringFullTimeZone:(NSString *)timeZone JD:(double)JD {
    if (JD < 1) {
        return @"-";
    }
    
    LSDate *lsdate = [[LSDate alloc] initWithJD:JD timezone:timeZone];
    return [lsdate localFullTimeString];
}

@end
