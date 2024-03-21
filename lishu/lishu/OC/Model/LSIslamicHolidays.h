//
//  LSIslamicHolidays.h
//  lishu
//
//  Created by xueping on 2021/11/7.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"
#import "LSCalendarTypeModel.h"
#import "LSFestival.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSIslamicHolidays : NSObject<LSFetival>
@property(nonatomic,assign)int year;

@property(nonatomic,copy)NSArray *dataArray;
@property(nonatomic,assign)NSInteger type;


- (instancetype)initWithYear:(int)year;

@end


@interface LSIslamicHolidayItem : NSObject<LSFetivalItem>

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)LSDate *lsdate;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,strong)LSCalendarTypeModel *calendarModel;




- (instancetype)initWithCalendarModel:(LSCalendarTypeModel *)calendarModel;

@end

NS_ASSUME_NONNULL_END
