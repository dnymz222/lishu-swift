//
//  LSAccuDayAndNightWeatherModel.h
//  lishu
//
//  Created by xueping on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSAccuDayAndNightWeatherModel : NSObject


@property(nonatomic,assign)NSInteger CloudCover;
@property(nonatomic,copy)NSString *LongPhrase;
@property(nonatomic,assign)NSInteger RainProbability;
@property(nonatomic,copy)NSDictionary *Ice;
@property(nonatomic,assign)NSInteger HoursOfPrecipitation;
@property(nonatomic,assign)NSInteger IceProbability;
@property(nonatomic,assign)NSInteger HoursOfIce;
@property(nonatomic,assign)NSInteger HoursOfRain;
@property(nonatomic,assign)NSInteger ThunderstormProbability;
@property(nonatomic,copy)NSDictionary *Rain;
@property(nonatomic,assign)NSInteger SnowProbability;
@property(nonatomic,copy)NSDictionary *LocalSource;
@property(nonatomic,assign)NSInteger PrecipitationProbability;
@property(nonatomic,copy)NSDictionary *Snow;
@property(nonatomic,copy)NSDictionary *Wind;
@property(nonatomic,copy)NSString *ShortPhrase;
@property(nonatomic,copy)NSDictionary *WindGust;
@property(nonatomic,assign)NSInteger HoursOfSnow;
@property(nonatomic,copy)NSDictionary *TotalLiquid;
@property(nonatomic,copy)NSString *IconPhrase;
@property(nonatomic,assign)NSInteger Icon;

@end

NS_ASSUME_NONNULL_END
