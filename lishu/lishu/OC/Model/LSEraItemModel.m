//
//  LSEraItemModel.m
//  lishu
//
//  Created by xueping on 2021/10/15.
//

#import "LSEraItemModel.h"

@implementation LSEraItemModel

- (instancetype)initWithType:(LSEraType)type year:(int)year {
    self = [super init];
    if (self) {
        
        self.type =  type;
        self.year = year;
        
        
        
    }
    return self;
}

@end
