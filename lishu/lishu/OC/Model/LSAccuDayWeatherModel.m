//
//  LSAccuDayWeatherModel.m
//  lishu
//
//  Created by xueping on 2021/3/28.
//

#import "LSAccuDayWeatherModel.h"

@implementation LSAccuDayWeatherModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return @{@"Night":[LSAccuDayAndNightWeatherModel class],
             @"Day":[LSAccuDayAndNightWeatherModel class]
    };
}

@end
