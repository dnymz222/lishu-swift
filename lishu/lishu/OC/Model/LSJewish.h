//
//  LSJewish.h
//  lishu
//
//  Created by xueping on 2021/10/24.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"
#import "LSFestival.h"
#import "LSCalendarTypeModel.h"

NS_ASSUME_NONNULL_BEGIN


@class LSJewishItem;

@interface LSJewish : NSObject<LSFetival>

@property(nonatomic,strong)LSJewishItem *Pessah;

@property(nonatomic,assign)int year;

@property(nonatomic,copy)NSArray *dataArray;
@property(nonatomic,assign)NSInteger type;


- (instancetype)initWithYear:(int)year;

- (NSArray *)filterItemWithLSDate:(LSDate *)lsdate;



@end



@interface LSJewishItem : NSObject<LSFetivalItem>

@property(nonatomic,assign)long jewishYear;
@property(nonatomic,assign)long jewishMonth;
@property(nonatomic,assign)long jewishDay;
@property(nonatomic,strong)LSDate *lsdate;

@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)LSCalendarTypeModel *calendarModel;

- (instancetype)initWithYear:(int)year month:(int)month day:(int)day name:(NSString*)name;
- (instancetype)initWithLSDate:(LSDate *)lsdate name:(NSString *)name;



@end

NS_ASSUME_NONNULL_END
