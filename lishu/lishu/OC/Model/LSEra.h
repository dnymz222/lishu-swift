//
//  LSEra.h
//  lishu
//
//  Created by xueping on 2021/10/23.
//

#import <Foundation/Foundation.h>
#import "LSCalendarTypeModel.h"
#import "LSDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSEra : NSObject

@property(nonatomic,assign)int year;
@property(nonatomic,strong)LSCalendarTypeModel *startCalendar;
@property(nonatomic,strong)LSCalendarTypeModel *endCalendar;

@property(nonatomic,strong)LSDate *startDate;
@property(nonatomic,strong)LSDate *endDate;
- (instancetype)initWithYear:(int)year type:(LSCalendarType)type;

@end

NS_ASSUME_NONNULL_END
