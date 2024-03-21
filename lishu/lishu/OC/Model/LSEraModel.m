//
//  LSEraModel.m
//  lishu
//
//  Created by xueping on 2021/10/15.
//

#import "LSEraModel.h"

@implementation LSEraModel

- (instancetype)initWithType:(LSEraType)type startYear:(int)startyear endyear:(int)endyear {
    
    self.type =  type;
    self.startYear =  startyear;
    self.endYear = endyear;
    self.eraArray = [NSMutableArray array];
    
    self = [super init];
    if (self) {
        
        for (int i = startyear; i < endyear + 1; i++) {
            LSEraItemModel *itemModel = [[LSEraItemModel alloc] initWithType:type year:i];
            [self.eraArray addObject:itemModel];
        }
        
    }
    return self;
    
    
}

@end
