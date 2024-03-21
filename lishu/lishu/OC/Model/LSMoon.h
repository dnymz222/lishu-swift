//
//  LSMoon.h
//  lishu
//
//  Created by xueping on 2021/3/24.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LSGeoPosition.h"
#import "LSRiseSetTime.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSMoon : NSObject

@property(nonatomic,assign)double RA;
@property(nonatomic,assign)double Dec;


@property(nonatomic,assign)double R;


@property(nonatomic,assign)double jd;

@property(nonatomic,assign)double moonage;

@property(nonatomic,assign)double distance;
@property(nonatomic,assign)float illuminated_fraction;
@property(nonatomic,assign)float phaseangle;
@property(nonatomic,assign)float positionAngle;

@property(nonatomic,assign)double moonRiseJD;
@property(nonatomic,assign)BOOL moonnextDay;
@property(nonatomic,assign)double moonSetJD;

@property(nonatomic,assign)double moontransitJD;
@property(nonatomic,assign)double moontransitNextDay;

@property(nonatomic,assign)double moonillumation;


- (instancetype)initWithJD:(double)jd;

+ (double)lastmoondateWithJd:(double)jd K:(double)k;


- (void)calculateMoon;




- (void)calcuateMoonRiseSetWithLocation:(LSGeoPosition *)location date:(NSDate *)date timeZone:(NSString *)timezone;

- (void)calculateMoonageWithJD:(double)JD;

+ (double)nextmoondateWithJd:(double)jd K:(double)k ;




@end

NS_ASSUME_NONNULL_END
