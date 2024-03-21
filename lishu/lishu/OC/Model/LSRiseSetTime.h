//
//  LSRiseSetTime.h
//  lishu
//
//  Created by xueping on 2021/4/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSRiseSetTime : NSObject


@property(nonatomic,assign)double riseJD;
@property(nonatomic,assign)double setJD;
@property(nonatomic,assign)double transitJD;
@property(nonatomic,assign)double transitAbove;
@property(nonatomic,assign)BOOL nextday;

@property(nonatomic,assign)BOOL nextday_transit;

- (instancetype)initWithRiseJd:(double)riseJD setJD:(double)setJD transitJD:(double)transitJD nextDay:(BOOL)nextday transitAbove:(BOOL)above;


//- (NSString *)riseSetStringWithFomatter:(NSDateFormatter *)formatter;

+ (NSString *)riseSetStringTimeZone:(NSString *)timeZone JD:(double)JD;

+ (NSString *)riseSetStringFullTimeZone:(NSString *)timeZone JD:(double)JD;

@end

NS_ASSUME_NONNULL_END
