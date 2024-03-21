//
//  LSDay.h
//  lishu
//
//  Created by xueping on 2021/3/11.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LSDate.h"
#import "LSSun.h"
#import "LSMoon.h"
#import "LSRiseSetTime.h"
#import "LSGeoPosition.h"
#import "LSCalendarTypeModel.h"
#import "LSPlanet.h"



NS_ASSUME_NONNULL_BEGIN
@class LSYear;
@interface LSDay : NSObject

@property(nonatomic,assign)NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger dayInMonth;
@property(nonatomic,assign)NSInteger dayInWeek;
@property(nonatomic,assign)NSInteger dayInYear;
@property(nonatomic,assign)NSInteger yearDays;


@property(nonatomic,strong)LSDate *lsdate;
@property(nonatomic,copy)NSString *timeZone;

@property(nonatomic,assign)double  offset;

@property(nonatomic,strong)NSDate *date;

@property(nonatomic,assign)double jd;


@property(nonatomic,strong)LSSun *sun;
@property(nonatomic,strong)LSMoon *moon;

@property(nonatomic,strong)LSRiseSetTime *planetRiseSetTime;

@property(nonatomic,strong)LSRiseSetTime *staticAstroRiseSetTime;


//@property(nonatomic,strong)LSRiseSetTime *moonriseSet;

//@property(nonatomic,strong)LSRiseSetTime *sunRiseSet;
//@property(nonatomic,strong)LSRiseSetTime *civilRiseSet;
//@property(nonatomic,strong)LSRiseSetTime *nutaionRiseSet;
//@property(nonatomic,strong)LSRiseSetTime *astroRiseSet;

@property(nonatomic,assign)float phase_delta;



@property(nonatomic,strong)NSMutableArray *clanedarArray;











- (instancetype)initWithDate:(NSDate *)date timezone:(NSString*)timzone ;

- (instancetype)initWithyear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day timezone:(NSString *)timzone;


- (void)calculateGridPhaseAngle;



- (void)calculateSolunarWithLocation:(CLLocation *)location;

-(void)calulateMoonWithLocation:(LSGeoPosition *)location;



- (void)calculateSunWithLocation:(LSGeoPosition *)location;

- (void)calulateSolunar;


- (void)calculateCalendarWithLSYear:(LSYear*)lsyear;

- (void)calculatePlanet:(LSPlanet *)planet;





@end

NS_ASSUME_NONNULL_END
