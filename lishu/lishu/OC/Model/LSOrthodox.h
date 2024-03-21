//
//  LSOrthodox.h
//  lishu
//
//  Created by xueping on 2021/10/24.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"
#import "LSJulianCalendar.h"
#import "LSCalendarTypeModel.h"

#import "LSFestival.h"

NS_ASSUME_NONNULL_BEGIN

@class LSOrthodoxItem;

@interface LSOrthodox : NSObject<LSFetival>

@property(nonatomic,assign)int year;
@property(nonatomic,copy)NSArray *dataArray;

@property(nonatomic,strong)LSOrthodoxItem   *easter;

- (instancetype)initWithYear:(int)year;
@property(nonatomic,assign)NSInteger type;


- (NSArray *)filterItemWithLSDate:(LSDate *)lsdate;;




@end

@interface LSOrthodoxItem : NSObject<LSFetivalItem>

@property(nonatomic,strong)LSDate *lsdate;
@property(nonatomic,strong)LSJulianCalendar  *julidanCalendarDay;
@property(nonatomic,copy)NSString  *name;

@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)LSCalendarTypeModel *calendarModel;



- (instancetype)initWithYear:(int)year month:(int)month day:(int)day name:(NSString *)name ;

- (instancetype)initWithLSdate:(LSDate *)lsdate name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
