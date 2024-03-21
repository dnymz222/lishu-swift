//
//  LSBuddhistFestival.m
//  lishu
//
//  Created by xueping on 2021/12/30.
//

#import "LSBuddhistFestival.h"

@implementation LSBuddhistFestival



@end


@implementation  LSBuddhistFestivalItem

- (instancetype)initWithCalendarModel:(LSCalendarTypeModel *)calendarModel {
    
    self = [super init];
    if (self) {
        
        self.type = (int)LSCalendarTypeBuddhist;
        self.calendarModel   = calendarModel;
        
        self.lsdate = calendarModel.lsdate;
        self.name = calendarModel.festivalString;
        
        
        
    }
    return self;
}




@end
