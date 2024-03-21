//
//  LSChineseBuddhismFestival.h
//  lishu
//
//  Created by xueping on 2021/12/30.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"
#import "LSFestival.h"
#import "LSCalendarTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSChineseBuddhismFestival : NSObject<LSFetival>

@property(nonatomic,assign)int year;

@property(nonatomic,copy)NSArray *dataArray;
@property(nonatomic,assign)NSInteger type;


- (instancetype)initWithYear:(int)year;


@end


@interface LSChineseBuddhismItem : NSObject <LSFetivalItem>

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)LSDate *lsdate;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,strong)LSCalendarTypeModel *calendarModel;

- (instancetype)initWithCalendarModel:(LSCalendarTypeModel *)calendarModel;





@end

NS_ASSUME_NONNULL_END
