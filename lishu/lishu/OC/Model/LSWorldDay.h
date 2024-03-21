//
//  LSWorldDay.h
//  lishu
//
//  Created by xueping on 2021/10/25.
//

#import <Foundation/Foundation.h>

#import "LSDate.h"
#import "LSCalendarTypeModel.h"
#import "LSFestival.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSWorldDay : NSObject<LSFetival>


@property(nonatomic,copy)NSArray *dataArray;
@property(nonatomic,assign)int year;
@property(nonatomic,assign)NSInteger type;

- (instancetype)initWithYear:(int)year ;

- (NSArray *)filterItemWithLSDate:(LSDate *)lsdate;


@end


@interface LSWorldDayItem : NSObject <LSFetivalItem>

@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)int year;
@property(nonatomic,assign)int month;
@property(nonatomic,assign)int day;

@property(nonatomic,strong)LSCalendarTypeModel *calendarModel;


@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)LSDate *lsdate;


- (instancetype)initWithYear:(int)year month:(int)month day:(int)day name:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
