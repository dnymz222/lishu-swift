//
//  LSHolidayRegion.h
//  lishu
//
//  Created by xueping on 2021/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSHolidayRegion : NSObject


@property(nonatomic,copy)NSString *flag;
@property(nonatomic,copy)NSString *code;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSArray *languages;
@property(nonatomic,assign)NSInteger selected;//0:未选中 1.选中

@end

NS_ASSUME_NONNULL_END
