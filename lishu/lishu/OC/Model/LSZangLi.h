//
//  LSZangLi.h
//  lishu
//
//  Created by xueping on 2021/10/21.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSZangLi : NSObject

@property(nonatomic,assign)BOOL dayLeap;//=dayLeap;
@property(nonatomic,assign)BOOL  monthLeap;
@property(nonatomic,assign)BOOL dayMiss;
@property(nonatomic,copy)NSString* value;//=result.year+"年"+result.month+"月("+result.tMonth+"月)"+result.day;
@property(nonatomic,copy)NSString *year;
@property(nonatomic,copy)NSString *month;
@property(nonatomic,copy)NSString *tmonth;
@property(nonatomic,copy)NSString *day;
@property(nonatomic,assign)BOOL isFestival;
@property(nonatomic,copy)NSString *extraInfo;
@property(nonatomic,copy)NSString *extraInfo2;

@property(nonatomic,assign)int calendarYear;
@property(nonatomic,assign)int calendarMonth;
@property(nonatomic,assign)int calendarDay;

@property(nonatomic,strong)LSDate *lsdate;

- (void)calculcateYear:(int)year month:(int)month day:(int)day;

@end

NS_ASSUME_NONNULL_END
