//
//  LSAccuWeatherHourModel.h
//  lishu
//
//  Created by xueping on 2021/3/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSAccuWeatherHourModel : NSObject


@property(nonatomic,copy)NSDictionary *Temperature;
//@property(nonatomic,assign)NSInteger IceProbability;
@property(nonatomic,copy)NSDictionary *RealFeelTemperature;
//@property(nonatomic,copy)NSDictionary *Ice;
@property(nonatomic,copy)NSString *DateTime;
@property(nonatomic,assign)NSInteger WeatherIcon;
@property(nonatomic,copy)NSDictionary *Rain;
//@property(nonatomic,copy)NSDictionary *WindGust;
//@property(nonatomic,copy)NSDictionary *TotalLiquid;
//@property(nonatomic,copy)NSDictionary *Ceiling;
//@property(nonatomic,assign)NSInteger RainProbability;
//@property(nonatomic,copy)NSDictionary *Visibility;
@property(nonatomic,assign)NSInteger EpochDateTime;
//@property(nonatomic,copy)NSString *Link;
@property(nonatomic,copy)NSString *IconPhrase;
//@property(nonatomic,assign)NSInteger RelativeHumidity;
//@property(nonatomic,copy)NSDictionary *DewPoint;
//@property(nonatomic,assign)NSInteger CloudCover;
//@property(nonatomic,copy)NSString *UVIndexText;
//@property(nonatomic,copy)NSDictionary *Snow;
//@property(nonatomic,copy)NSDictionary *WetBulbTemperature;
//@property(nonatomic,copy)NSString *MobileLink;
//@property(nonatomic,copy)NSDictionary *Wind;
//@property(nonatomic,assign)BOOL IsDaylight;
//@property(nonatomic,assign)NSInteger SnowProbability;
@property(nonatomic,assign)NSInteger PrecipitationProbability;
//@property(nonatomic,assign)NSInteger UVIndex;

@end

NS_ASSUME_NONNULL_END
