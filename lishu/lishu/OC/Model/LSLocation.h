//
//  LSLocation.h
//  lishu
//
//  Created by xueping on 2021/3/13.
//

#import <Foundation/Foundation.h>
#import "LSGeoPosition.h"
#import "LSTimeZone.h"
#import "LSParentCity.h"
#import "LSSun.h"
#import "LSAccuCurrentWetherModel.h"
#import "LSMoon.h"
#import "LSAstroPostion.h"
#import "LSRiseSetTime.h"
#import "LSCountryOrDistrictModel.h"
#import "LSAdministrativeAreaModel.h"
#import "LSDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSLocation : NSObject


@property(nonatomic,strong)NSDate *date;

@property(nonatomic,copy)NSString *LocalizedName;
@property(nonatomic,copy)NSString *Key;
@property(nonatomic,copy)NSString *EnglishName;

@property(nonatomic,strong)LSGeoPosition *GeoPosition;
@property(nonatomic,strong)LSTimeZone *TimeZone;
@property(nonatomic,strong)LSParentCity *ParentCity;
@property(nonatomic,strong)LSCountryOrDistrictModel *CountryOrDistrict;
@property(nonatomic,strong)LSAdministrativeAreaModel *AdministrativeArea;




//@property(nonatomic,assign)NSInteger year;
//@property(nonatomic,assign)NSInteger month;
//@property(nonatomic,assign)NSInteger day;
//@property(nonatomic,assign)NSInteger hour;
//@property(nonatomic,assign)NSInteger minutes;
//@property(nonatomic,assign)double second;

@property(nonatomic,strong)NSCalendar *calendar;

@property(nonatomic,strong)LSDate *lsDate;


@property(nonatomic,strong)LSAccuCurrentWetherModel *currentModel;


@property(nonatomic,strong)LSAstroPostion *sunPostion;

@property(nonatomic,strong)LSAstroPostion *moonPosition;

@property(nonatomic,strong)LSRiseSetTime *moonriseSet;

@property(nonatomic,strong)LSRiseSetTime *sunRiseSet;
@property(nonatomic,strong)LSRiseSetTime *civilRiseSet;
@property(nonatomic,strong)LSRiseSetTime *nutaionRiseSet;
@property(nonatomic,strong)LSRiseSetTime *astroRiseSet;

@property(nonatomic,assign)BOOL selected;

@property(nonatomic,assign)BOOL isCurrent;//是否是当前位置


@property(nonatomic,strong)LSMoon *lsmoon;
@property(nonatomic,strong)LSSun *lssun;




@property(nonatomic,assign)double JD;

@property(nonatomic,assign)double TTJD;



@property(nonatomic ,assign)double meanSiderealTime;
@property(nonatomic ,assign)double apparentSiderealTime;
@property(nonatomic,assign)double meanSolarTime;
@property(nonatomic,assign)double trueSolarTime;
@property(nonatomic,assign)double lunarTime;

@property(nonatomic,assign)double UTC;
@property(nonatomic,assign)double TDT;

@property(nonatomic,assign)double sundelta;









- (void)calculateSun:(LSSun *)sun;

- (void)calculateMoon:(LSMoon *)moon;








- (void)calcuteDate:(NSDate *)date isShow:(BOOL)isShow;

- (void)calcualateSunRiseSet;

- (void)calculateMoonRiseSet;


- (void)calcualteAstronomicalTime:(double)jd;










@end

NS_ASSUME_NONNULL_END
