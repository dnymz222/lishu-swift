//
//  LSChristian.h
//  lishu
//
//  Created by xueping on 2021/10/22.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"
#import "LSFestival.h"
#import "LSCalendarTypeModel.h"



NS_ASSUME_NONNULL_BEGIN

@class LSChristianItem;

@interface LSChristian : NSObject<LSFetival>

@property(nonatomic,copy)NSArray *dataArray;

@property(nonatomic,assign)int year;

@property(nonatomic,strong)LSDate *easterDate;
@property(nonatomic,assign)NSInteger type;



- (NSArray *)filterItemWithLSDate:(LSDate *)lsdate;









@end

@interface LSChristianItem : NSObject <LSFetivalItem>

@property(nonatomic,strong)LSDate *lsdate;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)LSCalendarTypeModel *calendarModel;

- (instancetype)initWithYear:(int)year month:(int)month day:(int)day name:(NSString *)name;

- (instancetype)initWithLSDate:(LSDate *)lsdate name:(NSString *)name;



@end





NS_ASSUME_NONNULL_END
