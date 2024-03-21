//
//  LSDate.h
//  lishu
//
//  Created by xueping on 2021/3/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSDate : NSObject

@property(nonatomic,assign)long year;
@property(nonatomic,assign)long localYear;
@property(nonatomic,assign)long month;
@property(nonatomic,assign)long localMonth;
@property(nonatomic,assign)long day;
@property(nonatomic,assign)long localDay;
@property(nonatomic,assign)long hour;//GTM0
@property(nonatomic,assign)long minutes;//GMT0
@property(nonatomic,assign)double second;
@property(nonatomic,assign)long localDayInWeek;

@property(nonatomic,assign)int localHour;//当地时间
@property(nonatomic,assign)int localMinute;//当地时间
@property(nonatomic,assign)double localSecond;// 

@property(nonatomic,assign)NSInteger offset;

@property(nonatomic,strong)NSDate   *date;


@property(nonatomic,assign)double JD;

@property(nonatomic,assign)double zonehourdelta ;
@property(nonatomic,strong)NSTimeZone *timeZone;


@property(nonatomic,assign)float earthLatitude;

@property(nonatomic,strong)NSMutableArray *locationArray;

@property(nonatomic,assign)double sunEcliLat;
@property(nonatomic,assign)double sunEcliLong;
@property(nonatomic,assign)double sunRad;

@property(nonatomic,assign)double sunEquLat;
@property(nonatomic,assign)double sunEquLong;

@property(nonatomic,assign)double TTJD;

@property(nonatomic,assign)int fix;

@property(nonatomic,strong)NSMutableArray *twlightLocationArray;













- (instancetype)initWithDate:(NSDate *)date;
- (instancetype)initWithDate:(NSDate *)date timezoneName:(NSString*)timezoneName ;
- (instancetype)initWithJD:(double)JD;
- (instancetype)initWithJD:(double)JD timezone:(NSString *)timezoneName;

- (instancetype)initWithYear:(int)year month:(int)month day:(int)day;

- (instancetype)initWithYear:(int)year month:(int)month day:(int)day timezone:(NSString *)timezoneName ;

+ (NSDate *)julianDaytoDate:(double)jd;


+ (LSDate *)localZerodateWithDate:(NSDate *)date timeZone:(NSString *)timezoneName;

- (double)julianDay;

- (void)calculateLocation;

- (void)calculateTwlightLocation;

- (NSString *)localTimeString;

- (NSString *)localFullTimeString;

- (NSString *)localdayString;

- (LSDate *)dateforDayDelta:(int)days;

- (LSDate *)dateforNearWeekDay:(int)dayInweek before:(BOOL)is_before;


- (void)calculateAstronomicalTime;





@end

NS_ASSUME_NONNULL_END
