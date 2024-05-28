//
//  LSTaiLiModel.m
//  lishu
//
//  Created by xueping wang on 2024/5/23.
//

#import "LSTaiLiModel.h"

#include "ThaiCalendar.hpp"

@implementation LSTaiLiModel


- (instancetype)initWithYear:(int)year month:(int)month day:(int)day {
    self = [super init];
    if (self) {
        LSDate *lsdate = [[LSDate alloc] initWithYear:year month:month day:day timezone:@"Asia/Bangkok"];
        
        double dt = [lsdate.date timeIntervalSinceReferenceDate] / 86400.0 + lsdate.offset / 86400.0;
        
        self.lsdate = lsdate;
        
        ThaiCalendar thai = ThaiCalendar(dt);
        self.calendarYear = thai.year;
        self.calendarMonth = thai.month;
        self.calendarLeap = thai.leap;
        self.calendarDay = thai.day;
        
        switch (self.calendarMonth) {
            case 3:
                if (15 == self.calendarDay){
                    self.isFestival = YES;
                    self.Festival = NSLocalizedStringFromTable(@"magha_puja",@"lish", nil);
                }
                break;
            case 6:
                if (15 == self.calendarDay) {
                    self.isFestival = YES;
                    self.Festival = NSLocalizedStringFromTable(@"vesak",@"lish", nil);
                }
                break;
            case  8:{
                if (self.calendarLeap) {
                    if (15 == self.calendarDay) {
                        self.isFestival = YES;
                        self.Festival = NSLocalizedStringFromTable(@"asalha_puja",@"lish", nil);
                    }
                    
                    if (16 == self.calendarDay){
                        self.isFestival = YES;
                        self.Festival = NSLocalizedStringFromTable(@"wan_khao_phansa",@"lish", nil);
                    }
                } else {
                    if (15 == self.calendarDay) {
                        self.isFestival = YES;
                        self.Festival = NSLocalizedStringFromTable(@"asalha_puja",@"lish", nil);
                    }
                    
                    if (16 == self.calendarDay){
                        self.isFestival = YES;
                        self.Festival = NSLocalizedStringFromTable(@"wan_khao_phansa",@"lish", nil);
                    }
                }
            }
                break;
            case 11: {
                if (15 == self.calendarDay) {
                    self.isFestival = YES;
                    self.Festival = NSLocalizedStringFromTable(@"wan_ok_phansa",@"lish", nil);
                }
                
                if (16 == self.calendarDay){
                    self.isFestival = YES;
                    self.Festival = NSLocalizedStringFromTable(@"thot_kathin",@"lish", nil);
                }
            }
                break;
            case 12:
                if (15 == self.calendarDay) {
                    self.Festival = NSLocalizedStringFromTable(@"loi_krathong",@"lish", nil);
                    self.isFestival = YES;
                }
                break;
                
            default:
                break;
        }
        
    }
    return self;
}


@end
