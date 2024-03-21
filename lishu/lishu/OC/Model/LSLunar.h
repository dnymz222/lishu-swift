//
//  LSLunar.h
//  lishu
//
//  Created by xueping on 2021/10/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSLunar : NSObject


@property (nonatomic, assign) int lunarDay;
@property (nonatomic, assign) int lunarYear;
@property (nonatomic, assign) int lunarMonth;

@property (nonatomic, assign) int solarDay;
@property (nonatomic, assign) int solarYear;
@property (nonatomic, assign) int solarMonth;

@property (nonatomic, copy) NSString* ganzhiDay;
@property (nonatomic, copy) NSString* ganzhiYear;
@property (nonatomic, copy) NSString* ganzhiMonth;

@property (nonatomic, copy) NSString* animal;
@property (nonatomic, copy) NSString* lunarDayInChinese;
@property (nonatomic, copy) NSString* lunarMonthInChinese;

@property (nonatomic, assign) BOOL isLeap;
@property (nonatomic, assign) BOOL isTerm;



- (instancetype)initWithYear:(int)year month:(int)month day:(int)day;


@end

NS_ASSUME_NONNULL_END
