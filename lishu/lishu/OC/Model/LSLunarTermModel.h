//
//  LSLunarTermModel.h
//  lishu
//
//  Created by xueping on 2021/9/23.
//

#import <Foundation/Foundation.h>
#import "LSLunarTermItemModel.h"



NS_ASSUME_NONNULL_BEGIN

@class LSDate;

@interface LSLunarTermModel : NSObject

@property(nonatomic,assign)double startJD;
@property(nonatomic,assign)double endJD;

@property(nonatomic,assign)double duration;

@property(nonatomic,strong)LSDate *startDate;
@property(nonatomic,strong)LSDate *endDate;


@property(nonatomic,strong)NSMutableArray<LSLunarTermItemModel *> *lunarArray;

- (instancetype)initWithStartJD:(double)startJD endJD:(double)endJD;

@end

NS_ASSUME_NONNULL_END
