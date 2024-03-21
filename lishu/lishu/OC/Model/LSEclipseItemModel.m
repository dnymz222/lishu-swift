//
//  LSEclipseItemModel.m
//  lishu
//
//  Created by efc on 2021/9/24.
//

#import "LSEclipseItemModel.h"

@implementation LSEclipseItemModel

- (instancetype)initWithType:(NSInteger)tye JD:(double)jd {
    self = [super init];
    if (self) {
        
        self.type = tye;
        self.jd = jd;
        
    }
    return self;
}


@end
