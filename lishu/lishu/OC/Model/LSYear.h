//
//  LSYear.h
//  lishu
//
//  Created by xueping on 2021/5/31.
//

#import <Foundation/Foundation.h>
#import "LSMonth.h"
#import "LSFestival.h"
#import "LSLunarTermModel.h"



NS_ASSUME_NONNULL_BEGIN


@class LSSolarTermModel;

@interface LSYear : NSObject

@property(nonatomic,assign)NSInteger year;

@property(nonatomic,strong)NSMutableArray *monthArray;

@property(nonatomic,strong)NSMutableArray *festivalArray;

@property(nonatomic,strong)LSSolarTermModel *solarTerm;

@property(nonatomic,copy)NSArray *lunarItermArray;

//@property(nonatomic,strong)NSMutableArray *solarTermFestivalArray;





- (instancetype)initWithyear:(NSInteger)year timezone:(NSString *)timezone;

- (void)createFestilvalArray;


- (void)calculateSolorTerm;

- (void)calculateLunarTerm;


@end

NS_ASSUME_NONNULL_END
