//
//  LSEclipseItemModel.h
//  lishu
//
//  Created by efc on 2021/9/24.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSEclipseItemModel : NSObject

@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)double jd;

@property(nonatomic,strong)LSDate *lsdate;

@property(nonatomic,strong)NSString *name;

- (instancetype)initWithType:(NSInteger)tye JD:(double)jd;

@end

NS_ASSUME_NONNULL_END
