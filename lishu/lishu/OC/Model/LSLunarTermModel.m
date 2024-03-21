//
//  LSLunarTermModel.m
//  lishu
//
//  Created by xueping on 2021/9/23.
//

#import "LSLunarTermModel.h"

#import "LSMoon.h"


@implementation LSLunarTermModel

- (instancetype)initWithStartJD:(double)startJD endJD:(double)endJD {
    self = [super init];
    if (self) {
        
        self.startJD=  startJD;
        self.endJD = endJD;
       NSMutableArray *lunarArray = [NSMutableArray array];
        for (int i =0; i < 4; i ++) {
            double resultJD = [LSMoon nextmoondateWithJd:startJD K:0.25*i];
            if (resultJD < endJD) {
                LSLunarTermItemModel *itemModel = [[LSLunarTermItemModel alloc] initWithType:i JD:resultJD];
                [lunarArray   addObject:itemModel];
            }
        }
        

         self.lunarArray= [lunarArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            LSLunarTermItemModel *item1 = (LSLunarTermItemModel *)obj1;
            LSLunarTermItemModel *item2 = (LSLunarTermItemModel *)obj2;
            if (item1.JD > item2.JD) {
                return NSOrderedDescending;
            } else {
                return NSOrderedAscending;
            }

        }].mutableCopy;
        
        
                LSLunarTermItemModel *anymodel = [self.lunarArray lastObject];
                
                for (int i =0; i < 4; i ++) {
                    double resultJD = [LSMoon nextmoondateWithJd:anymodel.JD+1 K:0.25*i];
                    if (resultJD < endJD) {
                        LSLunarTermItemModel *itemModel = [[LSLunarTermItemModel alloc] initWithType:i JD:resultJD];
                        [self.lunarArray  addObject:itemModel];
                    }
                }
        
                
     
    
        
    }
    return self;
}

@end
