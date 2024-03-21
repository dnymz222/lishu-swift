//
//  LSMoselm.m
//  lishu
//
//  Created by xueping on 2021/11/10.
//

#import "LSMoselm.h"
#include "AA+.h"

@implementation LSMoselm

- (instancetype)initWithYear:(int)year Month:(int)month Day:(int)day {
    self = [super init];
    if (self) {
        
        CAACalendarDate moslemdate = CAAMoslemCalendar::JulianToMoslem(year, month, day);
        self.moslemYear = moslemdate.Year;
        self.moslemMonth = moslemdate.Month;
        self.moslemDay = moslemdate.Day;
        
    }
    return self;
}

@end
