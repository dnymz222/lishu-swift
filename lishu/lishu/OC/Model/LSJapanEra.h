//
//  LSJapanEra.h
//  lishu
//
//  Created by xueping on 2021/10/22.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"

NS_ASSUME_NONNULL_BEGIN

@class LSJapanEraItemModel;

@interface LSJapanEra : NSObject


+ (LSJapanEraItemModel*)filterDate:(LSDate *)date;



@end

@interface LSJapanEraItemModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *english;
@property(nonatomic,strong)LSDate *startDate;
@property(nonatomic,strong)LSDate *endDate;
@property(nonatomic,copy)NSArray *date;
@property(nonatomic,copy)NSString *type;

- (void)calculateDate;

@end

NS_ASSUME_NONNULL_END
