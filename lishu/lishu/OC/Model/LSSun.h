//
//  LSSun.h
//  lishu
//
//  Created by xueping on 2021/3/24.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LSRiseSetTime.h"
#import "LSGeoPosition.h"


NS_ASSUME_NONNULL_BEGIN

@interface LSSun : NSObject

@property(nonatomic,assign)double RA;
@property(nonatomic,assign)double Dec;


@property(nonatomic,assign)double R;


@property(nonatomic,assign)double jd;



@property(nonatomic,strong)LSRiseSetTime *riseSet;
@property(nonatomic,strong)LSRiseSetTime *civilRiseSet;
@property(nonatomic,strong)LSRiseSetTime *nuticalRiseSet;
@property(nonatomic,strong)LSRiseSetTime *astroRiseSet;



- (instancetype)initWithJD:(double)jd;





- (void)calculateSun;


+ (double)calculateSunLongWithJd:(double)jd ;

+ (double)calculateSunLongWithStartJd:(double)startjd  endJd:(double)endJd startLong:(double)startLong endLong:(double)endLong targetSunLong:(double)sunlong;

- (void)calculateSunRiseSetWithlocation:(LSGeoPosition *)location date:(NSDate *)date timezone:(NSString *)timezone ;





@end

NS_ASSUME_NONNULL_END
