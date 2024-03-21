//
//  LSLunar.m
//  lishu
//
//  Created by xueping on 2021/10/22.
//

#import "LSLunar.h"
#include "lunar.h"

@implementation LSLunar

- (instancetype)initWithYear:(int)year month:(int)month day:(int)day {
    self  =[super init];
    if (self) {
        
        Lunar *lunar =new Lunar();
        
        LunarObj  *obj  =  lunar->solar2lunar(year,month,day);
        
        self.animal = [NSString stringWithUTF8String:obj->animal.c_str()];
        self.lunarDayInChinese = [NSString stringWithUTF8String:obj->lunarDayChineseName.c_str()];
        self.lunarMonthInChinese = [NSString stringWithUTF8String:obj->lunarMonthChineseName.c_str()];
        
        self.lunarDay = obj->lunarDay;
        self.lunarYear = obj->lunarYear;
        self.lunarMonth = obj->lunarMonth;
        
        self.solarDay = obj->solarDay;
        self.solarYear = obj->solarYear;
        self.solarMonth = obj->solarMonth;
        
        NSString *ganzhiDay = [NSString stringWithUTF8String: obj->ganzhiDay.c_str()];
        
        self.ganzhiDay = [self localizeStringWithGanzhiString:ganzhiDay];
        NSString *ganzhiYear = [NSString stringWithUTF8String: obj->ganzhiYear.c_str()];
        self.ganzhiYear = [self localizeStringWithGanzhiString:ganzhiYear];
        NSString*ganzhiMonth =[NSString stringWithUTF8String: obj->ganzhiMonth.c_str()];
        
        self.ganzhiMonth = [self localizeStringWithGanzhiString:ganzhiMonth];
        
        
        
        
        self.isLeap = obj->isLeap;
        self.isTerm = obj->isTerm;
        
        
        
        
    }
    return self;
}


- (NSString *)localizeStringWithGanzhiString:(NSString *)string {
    
    NSArray *arrays = [string componentsSeparatedByString:@"_"];
    
    NSString *localizestring =[NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] localizedStringForKey:arrays[0] value:@"" table:@"lish"],[[NSBundle mainBundle] localizedStringForKey:arrays[1] value:@"" table:@"lish"]];
    return localizestring   ;
}



@end
