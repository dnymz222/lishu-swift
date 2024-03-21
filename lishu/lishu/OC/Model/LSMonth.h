//
//  LSMonth.h
//  lishu
//
//  Created by xueping on 2021/5/31.
//

#import <Foundation/Foundation.h>
#import "LSDay.h"
#import "LSLunarTermModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface LSMonth : NSObject

@property(nonatomic,assign )NSInteger year;
@property(nonatomic,assign)NSInteger month;
@property(nonatomic,assign)NSInteger days;

@property(nonatomic,strong)NSMutableArray *daysArray;

@property(nonatomic,assign)NSInteger firstdayWeekday;

@property(nonatomic,strong)NSArray *moonsArray;

@property(nonatomic,assign)double startJD;
@property(nonatomic,assign)double endJD;

@property(nonatomic,copy)NSString *timeZone;

@property(nonatomic,strong)LSLunarTermModel *lunarTermModel;


- (instancetype)initWithYear:(NSInteger)year month:(NSInteger)month timezone:(NSString *)timezone;


- (void)caculateLunarTermodel;



@end

NS_ASSUME_NONNULL_END
