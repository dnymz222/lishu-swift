//
//  LSNetWorkHandler.m
//  lishu
//
//  Created by xueping on 2021/3/18.
//

#import "LSNetWorkHandler.h"

#define currentweather_path  @"/accu/current"

#define acculocationkey_path @"/accu/loctionkey"

//#define accucitysearch_apth @"/accu/city/search"


#define accucitysearch_apth @"/accu/city/search"

#define accu_dayweather_path @"/acuu/weather"

#define accu_houlyweather_path @"/accu/hourly"

#define workingdays_date_path @"/workingday/pulicholiday/date"

#define workingdays_month_path @"/workingday/month"

#define workingdays_year_path @"/workingday/pulicholiday/year"

#define workingdays_config_path @"/workingday/config"





@implementation LSNetWorkHandler

+ (void)requestTest {
    [LSNetWork sendGetRequestWithPath:@"" paramater:@{} success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
        
    } failed:^(NSError * _Nonnull error) {
        
    }];
}

+ (void)currentWithparamater:(NSDictionary *)paramaters
success:(LSSuccessBlock)successBlock
                      failed:(LSFailedBlock)failedBlock {
    
    
    
    [LSNetWork sendGetRequestWithPath:currentweather_path paramater:paramaters success:^(NSURLResponse *response, id data) {
           successBlock(response,data);
       } failed:^(NSError *error) {
           failedBlock(error);
       }];
    
    
}

+ (void)locationkeyWithparamater:(NSDictionary *)paramaters
success:(LSSuccessBlock)successBlock
                      failed:(LSFailedBlock)failedBlock {
    
    
    
    [LSNetWork sendGetRequestWithPath:acculocationkey_path paramater:paramaters success:^(NSURLResponse *response, id data) {
           successBlock(response,data);
       } failed:^(NSError *error) {
           failedBlock(error);
       }];
    
    
}

+ (void)locationCityWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                           failed:(LSFailedBlock)failedBlock
{
    
    
    
    [LSNetWork sendGetRequestWithPath:accucitysearch_apth paramater:paramaters success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
        successBlock(response,data);
    } failed:^(NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
    
}


+ (void)accudayweatherWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                           failed:(LSFailedBlock)failedBlock
{
    
    
    
    [LSNetWork sendGetRequestWithPath:accu_dayweather_path paramater:paramaters success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
        successBlock(response,data);
    } failed:^(NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
    
}

+ (void)accuhourweatherWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                           failed:(LSFailedBlock)failedBlock
{
    
    
    
    [LSNetWork sendGetRequestWithPath:accu_houlyweather_path paramater:paramaters success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
        successBlock(response,data);
    } failed:^(NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
    
}


+ (void)WorkingDaysDayWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                           failed:(LSFailedBlock)failedBlock
{
    
    
    
    [LSNetWork sendGetRequestWithPath:workingdays_date_path paramater:paramaters success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
        successBlock(response,data);
    } failed:^(NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
    
}


+ (void)WorkingDaysMonthWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                           failed:(LSFailedBlock)failedBlock
{
    
    
    
    [LSNetWork sendGetRequestWithPath:workingdays_month_path paramater:paramaters success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
        successBlock(response,data);
    } failed:^(NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
    
}


+ (void)WorkingDaysYearWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                           failed:(LSFailedBlock)failedBlock
{
    
    
    
    [LSNetWork sendGetRequestWithPath:workingdays_year_path paramater:paramaters success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
        successBlock(response,data);
    } failed:^(NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
    
}


+ (void)WorkingDaysConfigWithparamater:(NSDictionary *)paramaters
                  success:(LSSuccessBlock)successBlock
                           failed:(LSFailedBlock)failedBlock
{
    
    
    [LSNetWork sendGetRequestWithPath:workingdays_config_path paramater:paramaters success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
        successBlock(response,data);
    } failed:^(NSError * _Nonnull error) {
        failedBlock(error);
    }];
    
    
    
}



















@end
