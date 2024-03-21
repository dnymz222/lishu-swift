//
//  LSCalendarGroup.h
//  lishu
//
//  Created by xueping on 2021/10/17.
//

#import <Foundation/Foundation.h>
#import "LSCalendarTypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSCalendarGroup : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger type;//1-8
@property(nonatomic,copy)NSArray *dataArray;

- (instancetype)initWithType:(NSInteger)type;

- (void)createData;

@end

NS_ASSUME_NONNULL_END
