//
//  LSSolarTermItemModel.h
//  lishu
//
//  Created by xueping on 2021/9/22.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"



NS_ASSUME_NONNULL_BEGIN

@class LSSolarTermModel;

@interface LSSolarTermItemModel : NSObject




@property(nonatomic,assign)NSInteger type;//0-23

@property(nonatomic,assign)NSInteger hemisType;//0 北 1 南

@property(nonatomic,copy)NSString *name;




@property(nonatomic,assign)int targetLong;

@property(nonatomic,assign)BOOL isFestival;
@property(nonatomic,copy)NSString *festivalString;

@property(nonatomic,assign)double  resultJD;

@property(nonatomic,strong)LSDate *resultDate;


@property(nonatomic,assign)BOOL startNowYear;










- (instancetype)initWithType:(NSInteger)type hemisType:(NSInteger)hemisType;

- (void)calculateSolorTerm:(LSSolarTermModel *)solarTerm;








@end

NS_ASSUME_NONNULL_END
