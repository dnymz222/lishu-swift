//
//  LSMoselm.h
//  lishu
//
//  Created by xueping on 2021/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSMoselm : NSObject

@property(nonatomic,assign)long moslemYear;
@property(nonatomic,assign)long moslemMonth;
@property(nonatomic,assign)long moslemDay;

- (instancetype)initWithYear:(int)year Month:(int)month Day:(int)day;

@end

NS_ASSUME_NONNULL_END
