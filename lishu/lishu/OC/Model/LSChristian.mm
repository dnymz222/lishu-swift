//
//  LSChristian.m
//  lishu
//
//  Created by xueping on 2021/10/22.
//

#import "LSChristian.h"
#include "AA+.h"


@implementation LSChristian

- (instancetype)initWithYear:(int)year{
    self = [super init];
    if (self) {
        
        //septuagesima sunday
        
        //12.8 Fesast of immaculate Conception
        
        
        
        CAAEasterDetails easter = CAAEaster::Calculate(year, true);
        
        self.type = (int)LSCalendarTypeChristianHolidays;
        
        self.easterDate = [[LSDate alloc] initWithYear:year month:easter.Month day:easter.Day];
        
        NSMutableArray *dataArray  = [NSMutableArray array];
        
        
    
        
        
        [dataArray addObject:[[LSChristianItem alloc] initWithYear:year month:1 day:1 name:@"Solemnity of Mary" ]];
        
        [dataArray addObject:[[LSChristianItem alloc] initWithYear:year month:1 day:6 name:@"Epiphany" ]];
//        [dataArray addObject:[[LSChristianItem alloc] initWithYear:year month:2 day:2 name:@"Purification of Mary"]];
        
        LSDate *PalmSunday = [self.easterDate dateforNearWeekDay:0 before:YES];
        LSDate *ashwendnesday = [PalmSunday dateforDayDelta:-39];//圣灰节
        LSDate *Septuagesima = [self.easterDate dateforDayDelta:-63];//
        LSDate *ShroveTuesday = [ashwendnesday dateforDayDelta:-1];//忏悔节
        LSDate *HolyThursday = [self.easterDate dateforNearWeekDay:4 before:YES];
        LSDate *GoodFriday = [self.easterDate dateforNearWeekDay:5 before:YES];
        LSDate *HolySaturday= [self.easterDate dateforNearWeekDay:6 before:YES];
        LSDate *DivineMercySunday = [self.easterDate dateforNearWeekDay:0 before:NO];
        LSDate *Ascension = [self.easterDate dateforDayDelta:39];
        LSDate *Pentecost = [self.easterDate dateforDayDelta:49];
        LSDate *RogationSunday = [Ascension dateforNearWeekDay:0 before:YES];
        
        LSDate *TrinitySunday = [Pentecost dateforNearWeekDay:0 before:NO];
        LSDate *CorpusChristi = [TrinitySunday dateforNearWeekDay:4 before:NO];
        
        LSDate *christmas = [[LSDate alloc] initWithYear:year month:12 day:25];
        LSDate *firstchristmasbeforesunday = [christmas dateforNearWeekDay:0 before:YES];
        LSDate *secodchristmasbeforesunday = [firstchristmasbeforesunday dateforNearWeekDay:0 before:YES];
        LSDate *thirdchristmasbeforesunday = [secodchristmasbeforesunday dateforNearWeekDay:0 before:YES];
        LSDate *fourthchristmasbeforesunday = [thirdchristmasbeforesunday dateforNearWeekDay:0 before:YES];
        
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:Septuagesima name:@"Septuagesima Sunday"]];
        
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:ashwendnesday name:@"Ash Wednesday"]];
        
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:PalmSunday name:@"Palm Sunday"]];
        
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:HolyThursday name:@"Holy Thursday"]];
        
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:GoodFriday name:@"Good Friday"]];
        
     
        
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:HolySaturday name:@"Holy Saturday"]];
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:self.easterDate name:@"Easter"]];
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:DivineMercySunday name:@"Divine Mercy Sunday"]];
        
        
      
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:RogationSunday name:@"Rogation Sunday"]];
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:Ascension name:@"Ascension"]];
        
        
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:Pentecost name:@"Pentecost"]];
        
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:TrinitySunday name:@"Trinity Sunday"]];
        
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:CorpusChristi name:@"Corpus Christi"]];
        
        
       
        
        
        [dataArray addObject:[[LSChristianItem alloc] initWithYear:year month:8 day:15 name:@"Assumption of Mary"]];
        [dataArray addObject:[[LSChristianItem alloc] initWithYear:year month:11 day:1 name:@"All Saints’Day"]];
        [dataArray addObject:[[LSChristianItem alloc] initWithLSDate:fourthchristmasbeforesunday name:@"First Sunday of Advent" ]];
        
        [dataArray addObject:[[LSChristianItem alloc] initWithYear:year month:12 day:8 name:@"Feast of the Immaculate Conception"]];
        [dataArray addObject:[[LSChristianItem alloc] initWithYear:year month:12 day:25 name:@"Christmas"]];
        
        
        
        self.dataArray = dataArray.copy;
        
        
    
    
        
    }
    return self;
}


- (NSArray *)filterItemWithLSDate:(LSDate *)lsdate {
    
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (LSChristianItem *item in self.dataArray) {
        if (lsdate.localDay == item.lsdate.localDay && lsdate.localMonth == item.lsdate.localMonth && lsdate.localYear == item.lsdate.localYear) {
            [array addObject:item];
        }
    }
    
    return array.copy;
}


@end

@implementation LSChristianItem


- (instancetype)initWithYear:(int)year month:(int)month day:(int)day name:(NSString *)name
{
    self = [super init];
    if (self) {
        self.lsdate = [[LSDate alloc] initWithYear:year month:month day:day];
        self.name = [[NSBundle mainBundle] localizedStringForKey:name value:@"" table:@"lish"];
        self.type = (int)LSCalendarTypeChristianHolidays;
        self.calendarModel = [[LSCalendarTypeModel alloc] initWithType:LSCalendarTypeChristianHolidays];
    }
    return self;
}



- (instancetype)initWithLSDate:(LSDate *)lsdate name:(NSString *)name {
    
    self = [super init];
    if (self) {
        
        
        self.lsdate = lsdate;
        self.name = [[NSBundle mainBundle] localizedStringForKey:name value:@"" table:@"lish"];
        self.type = (int)LSCalendarTypeChristianHolidays;
        self.calendarModel = [[LSCalendarTypeModel alloc] initWithType:LSCalendarTypeChristianHolidays];
        
    }
    return self;
    
}




@end
