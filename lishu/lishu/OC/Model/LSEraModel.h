//
//  LSEraModel.h
//  lishu
//
//  Created by xueping on 2021/10/15.
//

#import <Foundation/Foundation.h>
#import "LSEraItemModel.h"

NS_ASSUME_NONNULL_BEGIN



@interface LSEraModel : NSObject

@property(nonatomic,assign)NSInteger startYear;
@property(nonatomic,assign)NSInteger endYear;
@property(nonatomic,strong)NSMutableArray<LSEraItemModel*> *eraArray;
@property(nonatomic,assign)LSEraType type;

- (instancetype)initWithType:(LSEraType)type startYear:(int)startyear endyear:(int)endyear;


@end

NS_ASSUME_NONNULL_END
