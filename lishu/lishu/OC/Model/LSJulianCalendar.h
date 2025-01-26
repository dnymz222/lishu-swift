//
//  LSJulianCalendar.h
//  lishu
//
//  Created by xueping on 2021/10/24.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSJulianCalendar : NSObject

@property(nonatomic,assign)long year;
@property(nonatomic,assign)long month;
@property(nonatomic,assign)long day;

@property(nonatomic,assign)long gyear;
@property(nonatomic,assign)long gmonth;
@property(nonatomic,assign)long gday;

- (instancetype)initWithYear:(int)year month:(int)month day:(int)day;//用格里高历初始化


- (instancetype)initWithJulianYear:(int)year month:(int)month day:(int)day;//用儒略历初始化




+ (LSDate *)convertJuliantoGerDayWithYear:(int)year month:(int)month day:(int)day;





@end

NS_ASSUME_NONNULL_END
