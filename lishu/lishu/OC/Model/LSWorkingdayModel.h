//
//  LSWorkingdayModel.h
//  lishu
//
//  Created by xueping on 2021/9/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSWorkingdayModel : NSObject


@property(nonatomic,copy)NSString* working_day;//: "1",
@property(nonatomic,copy)NSString*code;//: "CN",
@property(nonatomic,copy)NSString*public_holiday_description;//: "",
@property(nonatomic,copy)NSString*month;//: "09",
@property(nonatomic,copy)NSString*weekend_day;//: "0",
@property(nonatomic,copy)NSString*public_holiday;//: "0",
@property(nonatomic,copy)NSString*year;//: "2021",
@property(nonatomic,copy)NSString*date;//: "2021-09-01",
@property(nonatomic,copy)NSString*configuration;//: "",
@property(nonatomic,copy)NSString*work_hours;//: "8",
@property(nonatomic,copy)NSString*day;//: "01"

@end

NS_ASSUME_NONNULL_END
