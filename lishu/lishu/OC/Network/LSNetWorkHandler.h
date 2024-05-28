//
//  LSNetWorkHandler.h
//  lishu
//
//  Created by xueping on 2021/3/18.
//

#import <Foundation/Foundation.h>
#import "LSNetWork.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSNetWorkHandler : NSObject

+ (void)requestTest;

#pragma mark 实时天气
+ (void)currentWithparamater:(NSDictionary *)paramaters
        success:(LSSuccessBlock)successBlock
                      failed:(LSFailedBlock)failedBlock;

#pragma mark 经纬度获取key
+ (void)locationkeyWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                          failed:(LSFailedBlock)failedBlock;

#pragma mark 查询城市
+ (void)locationCityWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                          failed:(LSFailedBlock)failedBlock;

#pragma mark 逐日天气
+ (void)accudayweatherWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                             failed:(LSFailedBlock)failedBlock;

#pragma mark 小时天气
+ (void)accuhourweatherWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                              failed:(LSFailedBlock)failedBlock;



+ (void)WorkingDaysDayWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                             failed:(LSFailedBlock)failedBlock;


+ (void)WorkingDaysMonthWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                               failed:(LSFailedBlock)failedBlock;

+ (void)WorkingDaysYearWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                              failed:(LSFailedBlock)failedBlock;



+ (void)WorkingDaysConfigWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                                failed:(LSFailedBlock)failedBlock;



+ (void)SupabaseConfigWithParamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                             failed:(LSFailedBlock)failedBlock;








@end

NS_ASSUME_NONNULL_END
