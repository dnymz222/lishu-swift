//
//  LSJapanEra.m
//  lishu
//
//  Created by xueping on 2021/10/22.
//

#import "LSJapanEra.h"
#import <YYModel/YYModel.h>

@interface LSJapanEra ()

@property(nonatomic,copy)NSArray *dataArray;

@end

@implementation LSJapanEra

+ (LSJapanEra *)shareInstance {

    static LSJapanEra *era;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        era  =[[LSJapanEra alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"japanera.json" ofType:nil];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        
        NSArray *dataArray = [NSJSONSerialization  JSONObjectWithData:data options:kNilOptions error:nil];
        
        era.dataArray = [NSArray  yy_modelArrayWithClass:[LSJapanEraItemModel class] json:dataArray ];
        
        for (LSJapanEraItemModel *itemModel in era.dataArray) {
            [itemModel calculateDate];
        }
        
        
        
     
    });

    return era;
}


+ (LSJapanEraItemModel *)filterDate:(LSDate *)date {
    
    NSArray *dataArray  =[LSJapanEra shareInstance].dataArray;
    for (LSJapanEraItemModel *eraitem in dataArray) {
        if (date.JD < eraitem.endDate.JD && date.JD > eraitem.startDate.JD-0.01) {
            return eraitem;
        }
    }
    
    return nil;
}


@end

@implementation LSJapanEraItemModel


- (void)calculateDate {
    
    
    self.startDate = [[LSDate alloc] initWithYear:[self.date[0] intValue] month:[self.date[1] intValue] day:[self.date[2] intValue] timezone:@"Asia/Tokyo"];
    
    
    
    self.endDate = [[LSDate alloc] initWithYear:[self.date[3] intValue] month:[self.date[4] intValue] day:[self.date[5] intValue] timezone:@"Asia/Tokyo"];
    
}

        

@end
