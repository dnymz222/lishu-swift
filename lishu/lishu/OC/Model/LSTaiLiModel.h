//
//  LSTaiLiModel.h
//  lishu
//
//  Created by xueping wang on 2024/5/23.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSTaiLiModel : NSObject


@property(nonatomic,assign)int calendarYear;
@property(nonatomic,assign)int calendarMonth;
@property(nonatomic,assign)int calendarDay;
@property(nonatomic,assign)BOOL calendarLeap;

@property(nonatomic,assign)BOOL isFestival;

@property(nonatomic,copy)NSString *Festival;


@property(nonatomic,strong)LSDate *lsdate;

- (instancetype)initWithYear:(int)year month:(int)month day:(int)day;

@end

NS_ASSUME_NONNULL_END
