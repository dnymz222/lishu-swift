//
//  LSAccuDayWeatherModel.h
//  lishu
//
//  Created by xueping on 2021/3/28.
//

#import <Foundation/Foundation.h>
#import "LSAccuDayAndNightWeatherModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSAccuDayWeatherModel : NSObject

@property(nonatomic,copy)NSDictionary *Temperature;
@property(nonatomic,copy)NSDictionary *Sun;
@property(nonatomic,copy)NSDictionary *RealFeelTemperature;
@property(nonatomic,copy)NSDictionary *Moon;
//@property(nonatomic,copy)NSDictionary *Sources;
//@property(nonatomic,copy)NSDictionary *DegreeDaySummary;
//@property(nonatomic,copy)NSString *Link;
//@property(nonatomic,copy)NSArray *AirAndPollen;
//@property(nonatomic,copy)NSDictionary *HoursOfSun;
@property(nonatomic,strong)LSAccuDayAndNightWeatherModel *Night;
@property(nonatomic,copy)NSString *Date;
//@property(nonatomic,copy)NSDictionary *RealFeelTemperatureShade;
//@property(nonatomic,assign)NSInteger EpochDate;
//@property(nonatomic,copy)NSString *MobileLink;
@property(nonatomic,strong)LSAccuDayAndNightWeatherModel *Day;

//@property(nonatomic,assign)float windSpedd;
//@property(nonatomic,assign)float sheshitemperature;
//@property(nonatomic,assign)float intensity;


@end

NS_ASSUME_NONNULL_END
