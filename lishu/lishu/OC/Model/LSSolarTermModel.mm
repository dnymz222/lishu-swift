//
//  LSSolarTermModel.m
//  lishu
//
//  Created by xueping on 2021/9/22.
//

#import "LSSolarTermModel.h"
#include "AA+.h"
#import "LSSun.h"




@implementation LSSolarTermModel

- (instancetype)initWithYear:(int)year timeZone:(NSString *)timeZone {
    
    self = [super init];
    if (self) {
        
        self.year = year;
        
        self.timeZone = timeZone;
        
        LSDate *startDate = [[LSDate alloc] initWithYear:year month:1 day:1 timezone:timeZone];
        
        self.startJD = startDate.JD;
        LSDate *endDate = [[LSDate alloc] initWithYear:year+1 month:1 day:1 timezone:timeZone];
        self.endJD = endDate.JD;
        
        
        
        self.startLong = [LSSun calculateSunLongWithJd:self.startJD];
        
        self.endLong = [LSSun calculateSunLongWithJd:self.endJD];
        
        
        

        
        
    }
    return self;
}


- (void)calculateSolarTermWithHemisType:(NSInteger)hemisType {
    
    self.solarTermsArray = [NSMutableArray array];
    for (int i = 0; i < 24; i ++) {
        
        LSSolarTermItemModel *itemModel = [[LSSolarTermItemModel alloc] initWithType:(i+19)%24 hemisType:hemisType];
        
        [itemModel calculateSolorTerm:self];
        
        [self.solarTermsArray  addObject:itemModel];
        
    }
    
    
    
    
    
}

@end
