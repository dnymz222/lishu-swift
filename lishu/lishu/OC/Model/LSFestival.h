//
//  LSFestival.h
//  lishu
//
//  Created by xueping on 2021/11/6.
//

#ifndef LSFestival_h
#define LSFestival_h

#import "LSDate.h"


@class LSCalendarTypeModel;
@protocol LSFetival <NSObject>


- (instancetype)initWithYear:(int)year;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)int year;

@property(nonatomic,copy)NSArray *dataArray;

- (NSArray *)filterItemWithLSDate:(LSDate *)lsdate;



@end

@protocol LSFetivalItem <NSObject>


@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)LSDate *lsdate;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,strong)LSCalendarTypeModel *calendarModel;

@end

#endif /* LSFestival_h */
