//
//  LSLunarTermItemModel.m
//  lishu
//
//  Created by xueping on 2021/9/23.
//

#import "LSLunarTermItemModel.h"
#import "LSDate.h"

@implementation LSLunarTermItemModel

- (instancetype)initWithType:(NSInteger)type JD:(double)JD {
    self = [super init];
    if (self) {
        self.type = type;
        self.JD = JD;
    }
    return self;
}

- (void)calculateLocalDate:(NSString *)timeZone {
    
    self.localDate = [[LSDate alloc] initWithJD:self.JD timezone:timeZone];
    
}

@end
