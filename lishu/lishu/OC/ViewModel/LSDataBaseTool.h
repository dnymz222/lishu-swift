//
//  LSDataBaseTool.h
//  lishu
//
//  Created by xueping on 2021/3/27.
//

#import <Foundation/Foundation.h>
#import "LSLocation.h"
#import "LSWorkingDayConfig.h"
#import "LSCalendarTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSDataBaseTool : NSObject


+ (void)addLocation:(LSLocation *)location;

+ (void)addLocation:(LSLocation *)location index:(NSInteger)index;

+ (void)updateLocalLocation:(LSLocation *)location;


+ (void)updateLocationSelected:(LSLocation *)location;

+ (void)addWorkingDayConfig:(LSWorkingDayConfig *)config;


+ (NSArray *)excuteWorkingdaysconfig;


    


+ (NSArray *)excuteLocationArray ;

+ (BOOL)updateWorkingDayConfigWithCongifId:(NSString *)config_id selected:(BOOL)selected;



+ (BOOL)addCalendarType:(LSCalendarTypeModel *)model ;

+ (BOOL)updateCalendarConfigWithType:(NSInteger)type selected:(BOOL)selected;

    
+ (NSArray *)excuteCaledarConfigArraySelected:(BOOL )selected;
+ (NSArray *)excuteCaledarConfigArrayGrouptype:(NSInteger)groupType;

+ (NSArray *)excuteCaledarConfigArrayHasFestival;

+ (BOOL)deleteLocation:(LSLocation *)location ;


+ (NSArray *)excuteWorkingdaysconfigSelected:(BOOL)selected;


+ (void)vipExpiredResetConfig;



@end

NS_ASSUME_NONNULL_END
