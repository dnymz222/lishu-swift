//
//  LSLunarTermItemModel.h
//  lishu
//
//  Created by xueping on 2021/9/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSDate;

@interface LSLunarTermItemModel : NSObject

@property(nonatomic,assign)double JD;
@property(nonatomic,assign)NSInteger type;//0.新月1.上弦月 2.满月 3.下弦月


@property(nonatomic,strong)LSDate *localDate;

- (void)calculateLocalDate:(NSString *)timeZone;





- (instancetype)initWithType:(NSInteger)type JD:(double)JD;



@end

NS_ASSUME_NONNULL_END
