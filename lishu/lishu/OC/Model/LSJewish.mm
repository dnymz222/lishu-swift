//
//  LSJewish.m
//  lishu
//
//  Created by xueping on 2021/10/24.
//

#import "LSJewish.h"
#include "AA+.h"
#import "LSCalendarTypeModel.h"

@implementation LSJewish

- (instancetype)initWithYear:(int)year {
    
    self = [super init];
    if (self) {
        
        self.year = year;
        self.type = (int)LSCalendarTypeHebrew;
    
        CAACalendarDate Pessah = CAAJewishCalendar::DateOfPesach(year);
        
        
        //新年 1月1-2 Rosh Hashanah
        //赎罪日  1月-10 Yom Kippur
        //住棚节  1月15-21 Sukkot
        //       1-22 Shemini Atzeret
        //       1-23 Simchat Torah
        //光明节   9月25-（八天）Hanukkah
        //普珥节   12-14,15  Purim
        //逾越节   Pessah  Passover
        
        
        //五旬节                 Shavuot
        
//        self.Pessah = [[LSJewishItem alloc] initWithYear:Pessah.Year month:Pessah.Month day:Pessah.Day name:@"Pessah"];
        
        
        LSDate *pessashdate = [[LSDate alloc] initWithYear:year month:Pessah.Month day:Pessah.Day timezone:@"Asia/Jerusalem"];
        LSDate *pessashdate1 = [pessashdate dateforDayDelta:1];
        LSDate *pessashdate2 = [pessashdate dateforDayDelta:2];
        LSDate *pessashdate3 = [pessashdate dateforDayDelta:3];
        LSDate *pessashdate4 = [pessashdate dateforDayDelta:4];
        LSDate *pessashdate5 = [pessashdate dateforDayDelta:5];
        LSDate *pessashdate6 = [pessashdate dateforDayDelta:6];
        LSDate *pessashdate7 = [pessashdate dateforDayDelta:7];
        
        LSDate *shavoutdate1 = [pessashdate dateforDayDelta:50];
        LSDate *shavoutdate2 = [pessashdate dateforDayDelta:51];
        
        NSMutableArray *dataArray = [NSMutableArray array];
        
//        [dataArray addObject:self.Pessah];
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year month:7 day:14 name:@"Purim" ]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:pessashdate name:@"Passover"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:pessashdate1 name:@"Passover"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:pessashdate2 name:@"Passover"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:pessashdate3 name:@"Passover"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:pessashdate4 name:@"Passover"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:pessashdate5 name:@"Passover"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:pessashdate6 name:@"Passover"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:pessashdate7 name:@"Passover"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:shavoutdate1 name:@"Shavuot"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:shavoutdate2 name:@"Shavuot"]];
        
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year month:11 day:9 name:@"Tisha B'Av" ]];
       
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:1 name:@"Rosh Hashanah" ]];
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:2 name:@"Rosh Hashanah" ]];
        
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:10 name:@"Yom Kippur" ]];
        
        
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:15 name:@"Sukkot" ]];
        
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:16 name:@"Sukkot" ]];
        
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:17 name:@"Sukkot" ]];
        
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:18 name:@"Sukkot" ]];
        
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:19 name:@"Sukkot" ]];
        
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:20 name:@"Sukkot" ]];
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:21 name:@"Sukkot" ]];
        
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:22 name:@"Shemini Atzeret" ]];
        [dataArray addObject:[[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:1 day:23 name:@"Simchat Torah" ]];
        
        
        
        LSJewishItem  *HanukkahItem = [[LSJewishItem alloc] initWithYear:Pessah.Year+1 month:3 day:25 name:@"Hanukkah" ];
        LSDate *Hanukkahdate =HanukkahItem.lsdate;
        LSDate *Hanukkahdate1 = [Hanukkahdate  dateforDayDelta:1];
        LSDate *Hanukkahdate2 = [Hanukkahdate  dateforDayDelta:2];
        LSDate *Hanukkahdate3 = [Hanukkahdate  dateforDayDelta:3];
        LSDate *Hanukkahdate4 = [Hanukkahdate  dateforDayDelta:4];
        LSDate *Hanukkahdate5 = [Hanukkahdate  dateforDayDelta:5];
        LSDate *Hanukkahdate6 = [Hanukkahdate  dateforDayDelta:6];
        LSDate *Hanukkahdate7 = [Hanukkahdate  dateforDayDelta:7];
        
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:Hanukkahdate name:@"Hanukkah"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:Hanukkahdate1 name:@"Hanukkah"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:Hanukkahdate2 name:@"Hanukkah"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:Hanukkahdate3 name:@"Hanukkah"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:Hanukkahdate4 name:@"Hanukkah"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:Hanukkahdate5 name:@"Hanukkah"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:Hanukkahdate6 name:@"Hanukkah"]];
        [dataArray addObject:[[LSJewishItem alloc] initWithLSDate:Hanukkahdate7 name:@"Hanukkah"]];
   
        
        
        
        
        
        
        
        self.dataArray   = dataArray.copy;
       
        
        
    }
    return self;
}

- (NSArray *)filterItemWithLSDate:(LSDate *)lsdate   {
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (LSJewishItem *item in self.dataArray) {
        if (item.lsdate.localYear == lsdate.localYear && item.lsdate.localMonth == lsdate.localMonth && item.lsdate.localDay == lsdate.localDay) {
            [dataArray addObject:item];
        }
    }
    
    return dataArray.copy;
    
}

@end

@implementation LSJewishItem

- (instancetype)initWithYear:(int)year month:(int)month day:(int)day name:(NSString*)name
{
    self = [super init];
    if (self) {
        
        NSDateComponents    *datecompent = [[NSDateComponents alloc] init];
        
        self.jewishYear = year;
        self.jewishMonth = month;
        self.jewishDay  =day;
        
        NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierHebrew];
        [calendar setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Jerusalem"]];
        
        [datecompent setValue:year forComponent:NSCalendarUnitYear];
        [datecompent setValue:month forComponent:NSCalendarUnitMonth];
        [datecompent setValue:day forComponent:NSCalendarUnitDay];
        
        NSDate *date  = [calendar dateFromComponents:datecompent ];
        
        LSDate *lsdate = [[LSDate alloc] initWithDate:date timezoneName:@"Asia/Jerusalem"];
        
        LSCalendarTypeModel *model = [[LSCalendarTypeModel alloc] initWithType:LSCalendarTypeHebrew timezone:@"Asia/Jerusalem"];
        [model calculcateYear:lsdate.localYear month:lsdate.localMonth day:lsdate.localDay];
        self.calendarModel = model;
        
        self.lsdate = lsdate;
        
        self.name = [[NSBundle mainBundle] localizedStringForKey:name value:@"" table:@"lish"];
        
        self.type = (int)LSCalendarTypeHebrew;
        
        
        
        
        
        
        
        
        
        
    }
    return self;
}

- (instancetype)initWithLSDate:(LSDate *)lsdate name:(NSString *)name {
    self  =[super init];
    if (self) {
        self.lsdate = lsdate;
        self.name = [[NSBundle mainBundle] localizedStringForKey:name value:@"" table:@"lish"];
        LSCalendarTypeModel *model = [[LSCalendarTypeModel alloc] initWithType:LSCalendarTypeHebrew timezone:@"Asia/Jerusalem"];
        [model calculcateYear:lsdate.localYear month:lsdate.localMonth day:lsdate.localDay];
        self.calendarModel = model;
        self.jewishYear = model.calendarYear;
        self.jewishMonth  =  model.calendarMonth;
        self.jewishDay =  model.calendarDay;
        self.type =  (int)LSCalendarTypeHebrew;
        
    }
    return self;
}



@end
