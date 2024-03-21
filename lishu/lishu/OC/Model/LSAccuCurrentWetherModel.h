//
//  LSAccuCurrentWetherModel.h
//  lishu
//
//  Created by xueping on 2021/3/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSAccuCurrentWetherModel : NSObject
@property(nonatomic,assign)NSInteger WeatherIcon;
@property(nonatomic,copy)NSDictionary *Temperature;
@property(nonatomic,assign)NSInteger EpochTime;
@property(nonatomic,copy)NSDictionary *RealFeelTemperature;

@end

NS_ASSUME_NONNULL_END
