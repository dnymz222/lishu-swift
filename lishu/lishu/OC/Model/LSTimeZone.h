//
//  LSTimeZone.h
//  lishu
//
//  Created by xueping on 2021/3/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSTimeZone : NSObject


@property(nonatomic,assign)BOOL IsDaylightSaving;//: false,
@property(nonatomic,copy)NSString * Code;//: "CST",
@property(nonatomic,assign)double GmtOffset;//: 8,
@property(nonatomic,copy)NSString*  Name;//: "Asia/Shanghai",
@property(nonatomic,assign)NSInteger  NextOffsetChange;//;//: null

@end

NS_ASSUME_NONNULL_END
