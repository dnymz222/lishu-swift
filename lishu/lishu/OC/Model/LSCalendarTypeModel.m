//
//  LSCalendarTypeModel.m
//  lishu
//
//  Created by xueping on 2021/9/20.
//

#import "LSCalendarTypeModel.h"
#import "LSJapanEra.h"
#import "LSYear.h"
#import "LSMoselm.h"




//"calendar_gregorian"  = "Gregorian Calender";
//"calendar_chinese"  = "Chinese Calendar";
//"calendar_chinese_old" = "Old Chinese Calendar";
//"calendar_chinese_buddhism" = "Chinese Calendar(for Buddhism)";
//"calendar_zangli" = "Tibetan calendar";
//
//
//"calendar_japanese"  = "Japannese Calendar";
//"calendar_indian"  = "Indial Calendar";
//"calendar_tailand" = "Thai calendar";
//"calendar_hebrew" = "Hebrew calendar";
//"calendar_julian" = "Julian Calendar";
//"calendar_islamic"  = "Islamic Calendar";
//"calendar_islamic_civil"  = "IslamicCivil Calendar";
//"calendar_islamic_ummalqura" = "IslamicUmmAlQura Calendar";
//"calendar_islamic_tabular" = "IslamicTabular Calendar";
//
//"calendar_holiday_international" = "International Day";
//"calendar_holiday_christian" = "Christian Holiday";
//"calendar_holiday_Orthodox" = "Orthodox Church Holiday";
//
//
//"calendar_persian_iran" = "Persian Calendar (Iran)";
//"calendar_persian_afghan" = "Persian Calendar (Afghan)";



@interface LSCalendarTypeModel ()

@property(nonatomic,strong)LSJapanEraItemModel *japanEraItemModel;

@end



@implementation LSCalendarTypeModel


- (instancetype)initWithType:(LSCalendarType)type {
    self = [super init];
    if (self) {
        
        self.type =type;
        
        [self createDataWithType:type];
        
        NSTimeZone *timezone = [NSTimeZone systemTimeZone];
        [self.calendar setTimeZone:timezone];
        self.is_default  = (int)type < 10 ;
        self.selected   = (int)type < 10;
        
        
        
    }
    return self;
}

- (void)createDataWithType:(LSCalendarType)type {
    
    switch (type) {
        case LSCalendarTypeGregorian:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            self.name  =NSLocalizedStringFromTable(@"calendar_gregorian",@"lish", nil);
            self.lishuname =@"calendar_gregorian";
            self.groupType = LSCalendarGroupTypeGregorian;
            
            break;
            
        case LSCalendarTypeChinese:
            
            self.calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
            self.name = NSLocalizedStringFromTable(@"calendar_chinese",@"lish", nil);
            self.lishuname = @"calendar_chinese";
            self.groupType = LSCalendarGroupTypeChinese;
            self.hasFestival = YES;
            
            
            break;
            
        case LSCalendarTypeJapanese:
            self.calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierJapanese];
            self.name = NSLocalizedStringFromTable(@"calendar_japanese",@"lish", nil);
            self.lishuname =@"calendar_japanese";
            self.groupType = LSCalendarGroupTypeJapanese;
            break;
            
        case LSCalendarTypeHebrew:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierHebrew];
            self.name = NSLocalizedStringFromTable(@"calendar_hebrew",@"lish", nil);
            self.lishuname =@"calendar_hebrew";
            self.groupType = LSCalendarGroupTypeHebrew;
            self.hasFestival = YES;
            
            
            break;
        case LSCalendarTypeIndian:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIndian];
            self.name = NSLocalizedStringFromTable(@"calendar_indian",@"lish", nil);
            self.lishuname =@"calendar_indian";
            self.groupType  =LSCalendarGroupTypeIndian;
            self.hasFestival = YES;
            
            break;
            
        case LSCalendarTypeHinduSolar:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIndian];
            self.name = NSLocalizedStringFromTable(@"calendar_hindu_solar",@"lish", nil);
            self.lishuname =@"calendar_hindu";
            self.groupType  = LSCalendarGroupTypeIndian;
            self.hasFestival = NO;
            
            
            break;
        case LSCalendarTypeHinduLunar:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIndian];
            self.name = NSLocalizedStringFromTable(@"calendar_hindu_solar",@"lish", nil);
            self.lishuname =@"calendar_hindu";
            self.groupType  = LSCalendarGroupTypeIndian;
            self.hasFestival = NO;
            
            break;
            
        case LSCalendarTypeIslamic:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamic];
            self.name  =  NSLocalizedStringFromTable(@"calendar_islamic",@"lish", nil);
            self.lishuname = @"calendar_islamic";
            self.groupType = LSCalendarGroupTypeIslamic;
            self.hasFestival = YES;
            
            break;
        case LSCalendarTypePersian:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierPersian];
            self.name = NSLocalizedStringFromTable(@"calendar_persian_iran",@"lish", nil);
            self.lishuname = @"calendar_persian_iran";
            self.groupType = LSCalendarGroupTypePersian;
            
            break;
            
       
        case LSCalendarTypeBuddhist:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierBuddhist];
            self.name = NSLocalizedStringFromTable(@"calendar_tailand",@"lish", nil);
            self.lishuname =@"calendar_tailand";
            self.groupType = LSCalendarGroupTypeBuddhist;
            self.hasFestival = YES;
       
            
            break;
            
        case LSCalendarTypeThaiLunar:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierBuddhist];
            self.name = NSLocalizedStringFromTable(@"calendar_tailand_lunar",@"lish", nil);
            self.lishuname =@"calendar_tailand_lunar";
            self.groupType = LSCalendarGroupTypeBuddhist;
            self.hasFestival = YES;
            
            break;
            
        case LSCalendarTypeChineseHuangli:
            self.calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
            self.name = NSLocalizedStringFromTable(@"calendar_chinese_old",@"lish", nil);
            self.lishuname = @"calendar_chinese_old";
            self.groupType  =LSCalendarGroupTypeChinese;
            
            
            
            break;
        case LSCalendarTypeChineseBuddhist:
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
            self.name  =NSLocalizedStringFromTable(@"calendar_chinese_buddhism",@"lish", nil);
            self.lishuname = @"calendar_chinese_buddhism";
            self.groupType  = LSCalendarGroupTypeBuddhist;
            self.hasFestival = YES;
            
            break;
            
        case LSCalendarTypeZangli:
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
            self.name  =NSLocalizedStringFromTable(@"calendar_zangli",@"lish", nil);
            self.lishuname =@"calendar_zangli";
            self.groupType  = LSCalendarGroupTypeBuddhist;
            self.hasFestival = YES;
            
           
            break;
            
        case LSCalendarTypeIslamicCivil:
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicCivil];
            self.name = NSLocalizedStringFromTable(@"calendar_islamic_civil",@"lish", nil);
            self.lishuname =@"calendar_islamic_civil";
            self.groupType = LSCalendarGroupTypeIslamic;
            break;
        case LSCalendarTypeIslamicUmmAlQura:
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicUmmAlQura];
            self.name   = NSLocalizedStringFromTable(@"calendar_islamic_ummalqura",@"lish", nil);
            self.lishuname = @"calendar_islamic_ummalqura";
            self.groupType = LSCalendarGroupTypeIslamic;
            break;
        case LSCalendarTypeIslamicTabular:
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierIslamicTabular];
            self.name = NSLocalizedStringFromTable(@"calendar_islamic_tabular",@"lish", nil);
            self.lishuname = @"calendar_islamic_tabular";
            self.groupType = LSCalendarGroupTypeIslamic;
            
            break;
        case LSCalendarTypePersianAhuhan:
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierPersian];
            self.name = NSLocalizedStringFromTable(@"calendar_persian_afghan",@"lish", nil);
            self.lishuname = @"calendar_persian_afghan";
            self.groupType = LSCalendarGroupTypePersian;
            break;
            
        case LSCalendarTypeWorldDay:

            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            self.name = NSLocalizedStringFromTable(@"calendar_holiday_international",@"lish", nil);
            self.lishuname = @"calendar_holiday_international";
            self.groupType  = LSCalendarGroupTypeGregorian;
            self.hasFestival = YES;

            break;
        case LSCalendarTypeChristianHolidays:
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            self.name =  NSLocalizedStringFromTable(@"calendar_holiday_christian",@"lish", nil);
            self.lishuname = @"calendar_holiday_christian";
            self.groupType  = LSCalendarGroupTypeGregorian;
            self.hasFestival    = YES;
            
            break;
        case LSCalendarTypeJulian:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            self.name =NSLocalizedStringFromTable(@"calendar_julian",@"lish", nil) ;
            self.lishuname = @"calendar_julian";
            self.groupType  = LSCalendarGroupTypeJulian;
            
            
            break;
        case LSCalendarTypeOrthodoxHolidays:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            self.name = NSLocalizedStringFromTable(@"calendar_holiday_orthodox",@"lish", nil);
            self.lishuname = @"calendar_holiday_orthodox";
            self.groupType  = LSCalendarGroupTypeJulian;
            self.hasFestival = YES;
            
            break;
        case LSCalendarTypeCoptic:

            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierCoptic];
            self.name = NSLocalizedStringFromTable(@"calendar_coptic",@"lish", nil);
            self.lishuname = @"calendar_coptic";
            self.groupType  = LSCalendarGroupTypeCopticAndEthiopic;
            self.hasFestival = NO;
            
            
            break;
        case LSCalendarTypeEthiopic:
            
            self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierEthiopicAmeteMihret];
            self.name = NSLocalizedStringFromTable(@"calendar_ethiopic",@"lish", nil);
            self.lishuname = @"calendar_ethiopic";
            self.groupType  = LSCalendarGroupTypeCopticAndEthiopic;
            self.hasFestival = NO;
            
 
            
            break;
        case LSCalendarTypeChineseKorean:
            
            self.calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
            self.name = NSLocalizedStringFromTable(@"calendar_chinese_korean",@"lish", nil);
            self.lishuname = @"calendar_chinese_korean";
            self.groupType  =LSCalendarGroupTypeChinese;
            
            
            break;
        case LSCalendarTypeChineseJapanese:
            self.calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
            self.name = NSLocalizedStringFromTable(@"calendar_chinese_japanese",@"lish", nil);
            self.lishuname = @"calendar_chinese_japanese";
            self.groupType  =LSCalendarGroupTypeChinese;
            break;
            
        case LSCalendarTypeChineseVietnamese:
            self.calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
            self.name = NSLocalizedStringFromTable(@"calendar_chinese_vietnamese",@"lish", nil);
            self.lishuname = @"calendar_chinese_vietnamese";
            self.groupType  =LSCalendarGroupTypeChinese;
            
            break;

            
            
            
            
            
        default:
            break;
    }
    
    
    
}

- (NSString *)name {
    if (!_name) {
        _name = [[NSBundle mainBundle] localizedStringForKey:self.lishuname value:@"" table:@"lish"];
    }
    return _name;
}

- (instancetype)initWithType:(LSCalendarType)type timezone:(NSString *)timezoneName{
    self = [super init];
    if (self) {
        
        self.type =  type;
        
        [self createDataWithType:type];
        switch (type) {
         
            case LSCalendarTypeChinese:
                
              
                self.timeZone = @"Asia/Shanghai";
                
                break;
            case LSCalendarTypeChineseHuangli:
             
                self.timeZone = @"Asia/Shanghai";
                break;
            case LSCalendarTypeChineseBuddhist:
            
                self.timeZone = @"Asia/Shanghai";
                break;
            case LSCalendarTypeZangli:
               
                self.timeZone = @"Asia/Shanghai";
                break;
           
            case LSCalendarTypeJapanese:
           
                self.timeZone = @"Asia/Tokyo";
                break;
                
            case LSCalendarTypeHebrew:
            
                self.timeZone = @"Asia/Jerusalem";
                
                break;
            case LSCalendarTypeIndian:
                
            
                self.timeZone = @"Asia/Kolkata";
                
                break;
                
            case LSCalendarTypeIslamic:
                
//                self.timeZone =@"Asia/Riyadh";
                self.timeZone = @"Asia/Jerusalem";
                
                
                break;
            case LSCalendarTypeIslamicCivil:
                
//                self.timeZone =@"Asia/Riyadh";
                self.timeZone = @"Asia/Jerusalem";
            
                break;
            case LSCalendarTypeIslamicUmmAlQura:
//                self.timeZone =@"Asia/Riyadh";
                self.timeZone = @"Asia/Jerusalem";
               
                break;
            case LSCalendarTypeIslamicTabular:
                
//                self.timeZone =@"Asia/Riyadh";
                self.timeZone = @"Asia/Jerusalem";
                
              
                break;
            
            case LSCalendarTypePersian:
                
               
//                self.timeZone  = @"Asia/Tehran";
              
                
                break;
                
           
            case LSCalendarTypeBuddhist:
                
           
                self.timeZone = @"Asia/Bangkok";
                
                break;
            case LSCalendarTypeJulian:
            
                
                break;
            case LSCalendarTypeWorldDay:
             
                break;
            case LSCalendarTypeOrthodoxHolidays:
                
                
                break;
            case LSCalendarTypeChristianHolidays:
                
                
                break;
            
                
           
                
                
                
                
                
            default:
                break;
        }
        
        if (!self.timeZone) {
            self.timeZone = timezoneName;
        }
        
        NSTimeZone *timezone = [NSTimeZone timeZoneWithName:self.timeZone];
        [self.calendar setTimeZone:timezone];
       
        
    }
    
    return self;
}

- (void)calculcateYear:(int)year month:(int)month day:(int)day{
    
//    self.date = date;
    
    LSDate *lsdate = [[LSDate alloc] initWithYear:year month:month day:day timezone:self.timeZone];
    self.lsdate = lsdate;
    
    self.date = lsdate.date;
    
    
    
    
    unsigned unitFlags =NSCalendarUnitEra |NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
        
    NSDateComponents *localeComp = [self.calendar components:unitFlags fromDate:self.date];
    

    
    
    self.calendarEra =  localeComp.era;
    self.calendarYear = localeComp.year;
    self.calendarMonth =  localeComp.month;
    self.calendarDay = localeComp.day;
    self.calendarLeapMonth = localeComp.isLeapMonth;
    
//    if (self.type == LSCalendarTypeChinese) {
        
        NSRange range = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self.date];
        self.calendarYearDays = (int)range.length;
        self.calendarDayLocationInYear  =[self.calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self.date];
        
        self.calendarMonthDays = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self.date].length;
        
        self.calendarDayLocationInMonth  =[self.calendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:self.date];
        
        
        
        
//        NSLog(@"yeardays:%@ month:%d,yearday:%d",NSStringFromRange(range),self.calendarMonthDays,self.calendarDayLocationInYear);
        
    if ( LSCalendarTypeChineseHuangli  ==self.type ) {
        if (year < 2100 && year > 1900) {
            self.huangli = [[LSLunar alloc] initWithYear:year month:month day:day];
        }
       

        
    } else if (LSCalendarTypeZangli == self.type){
        if (year < 2050 && year > 1950) {
            self.zangli = [[LSZangLi alloc] init];
            [self.zangli calculcateYear:year month:month day:day];
            self.calendarMonth = self.zangli.calendarMonth;
            self.calendarDay = self.zangli.calendarDay;
        }
        
     
       
    } else if(LSCalendarTypeJulian == self.type || LSCalendarTypeOrthodoxHolidays == self.type){
        self.julianCalendar = [[LSJulianCalendar alloc] initWithYear:year month:month day:day];
        self.calendarDay = self.julianCalendar.day;
        self.calendarMonth = self.julianCalendar.month;
        self.calendarYear = self.julianCalendar.year;
        
    }
    else if (LSCalendarTypeJapanese== self.type){
        LSJapanEraItemModel *itemmodel = [LSJapanEra filterDate:self.lsdate];
        if (itemmodel) {
            self.japanEraItemModel = itemmodel;
            self.calendarYear = year-itemmodel.startDate.localYear+1;
        }
    }
 
    
    
    
    
}

- (void)calculateFestivalWithLSYear:(LSYear *)lsyear{
    
    switch (self.type) {
        case LSCalendarTypeChinese:
            
            
//            for (LSSolarTermItemModel *solarItem in lsyear.solarTermFestivalArray) {
//                if (self.lsdate.localMonth == solarItem.resultDate.localMonth && self.lsdate.localDay == solarItem.resultDate.localDay) {
//                    self.isFestival = YES;
//                    self.festivalString = solarItem.festivalString;
//                }
//            }
            
            [self calculateSolorTerm:lsyear.solarTerm];
            
            
            if (self.calendarLeapMonth) {
                return;
            }
            
            
        
            
            switch (self.calendarMonth) {
                case 1:
                    if (1 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Chinese New Year" value:nil table:@"lish"];
                        
                    }else if (15 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Lantern Festival" value:nil table:@"lish"];
                    }
                    break;
                case 2:
                    if (2 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Longtaitou Festival" value:nil table:@"lish"];
                    }
                    
                    break;
                case 3:
                    if (3 == self.calendarDay) {
                        self.isFestival  =YES;
                        self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Shangsi Festival" value:nil table:@"lish"];
                    }
                    
                    break;
                case 4:
                    
                    if (8 == self.calendarDay) {
                        self.isFestival  =YES;
                        self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Buddha's Birthday" value:nil table:@"lish"];
                    }
                    
                    break;
                case 5:
                  
                        if (5 == self.calendarDay) {
                            self.isFestival  =YES;
                            self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Duanwu Festival" value:nil table:@"lish"];
                        }
                   
                    
                    break;
                case 7:
                    if (7 == self.calendarDay) {
                        self.isFestival  =YES;
                        self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Qixi Festival" value:nil table:@"lish"];
                    } else if (15 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Ghost Festival" value:nil table:@"lish"];
                    }
                    break;
                case 8:
                    if (15 == self.calendarDay) {
                        self.isFestival =YES;
                        self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Mid-Autumn Festival" value:nil table:@"lish"];
                    }
                    break;
                    
                case 9:
                    if (9 == self.calendarDay) {
                        self.isFestival  =YES;
                        self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Double Ninth Festival" value:nil table:@"lish"];
                    }
                    
                    break;
                    
//                case 10:
//                    if (15 == self.calendarDay) {
//                        self.festivalString = @"下元节";
//                        self.isFestival = YES;
//                    }
//
//
//                    break;
           
                case 11:
                    break;
                case 12:
                    if (8 == self.calendarDay) {
                        self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Laba Festival" value:nil table:@"lish"];
                        self.isFestival = YES;
                    }
//                    else if(23 == self.calendarDay){
//                        self.festivalString = @"北方小年";
//                        self.isFestival = YES;
//                    } else if(24 == self.calendarDay){
//                        self.festivalString = @"南方小年";
//                        self.isFestival = YES;
//                    }
                    else if (29 == self.calendarDay){
                        
                        if (29 == self.calendarMonthDays) {
                            self.isFestival = YES;
                            self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Chinese New Year’s Eve" value:nil table:@"lish"];
                        }
                        
                    } else if (30 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = [[NSBundle mainBundle] localizedStringForKey:@"Chinese New Year’s Eve" value:nil table:@"lish"];
                    }
                    
                    break;
                    
                default:
                    break;
            }
            break;
        case LSCalendarTypeChineseBuddhist:
            switch (self.calendarMonth) {
                case 1:
                    
                    if (1 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = @"弥勒佛圣诞";
                    } else if (6 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = @"定光佛圣诞";
                    }
                    
                    break;
                    
                case 2:
                    if (8 == self.calendarDay  ) {
                        self.isFestival = YES;
                        self.festivalString = @"释迦牟尼佛出家";
                    } else if (15 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = @"释迦牟尼佛涅槃";
                       
                    } else if (19 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = @"观世音菩萨圣诞";
                    } else if (21 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = @"普贤菩萨圣诞";
                    }
                    
                    break;
                    
                case 3:
                {
                    if (16 ==  self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = @"准提菩萨圣诞";
                    }
                }
                    
                    break;
                    
                case 4:
                    if (4 == self.calendarDay) {
                        self.isFestival  =YES;
                        self.festivalString = @"文殊菩萨圣诞";
                    } else if (8 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = @"释迦牟尼佛圣诞";
                        
                      
                    }
                    
                    else if (15 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = @"佛吉祥日";
                    }
                    
                    break;
                case 5:
                    if (13 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = @"伽蓝菩萨圣诞";
                    }
                    
                    break;
                    
                case 6:
                    if (3 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = @"护法韦驮尊天菩萨圣诞";
                    } else if (19 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = @"观世音菩萨成道";
                    }
                    
                    break;
                case 7:
                {
                    if (13 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = @"大势至菩萨圣诞";
                    } else if (24 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = @"龙树菩萨圣诞";
                    } else if (29 == self.calendarDay){
                        if (29 ==self.calendarMonthDays) {
                            self.isFestival = YES;
                            self.festivalString = @"地藏菩萨圣诞";
                        }
                    } else if (30 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = @"地藏菩萨圣诞";
                    }
                }
                    
                    break;
                case 8:
                    if (22 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = @"燃灯佛圣诞";
                    }
                    break;
                case 9:
                    if (19 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = @"观世音菩萨出家纪念日";
                    } else if (29 == self.calendarDay   ){
                        if (29 == self.calendarMonthDays) {
                            self.isFestival = YES;
                            self.festivalString = @"药师琉璃光如来圣诞";
                        }
                    } else if (30 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = @"药师琉璃光如来圣诞";
                    }
                    
                    break;
                case 10:
                    if (5 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = @"达摩祖师圣诞";
                    }
               
                    break;
                case 11:
                {
                    if (17 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = @"阿弥陀佛圣诞";
                    }
                }
                    
                    break;
                case 12:
                    if (8 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = @"释迦如来成道日";
                    } else if (29 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = @"华严菩萨圣诞";
                    }
                    break;
            
                default:
                    break;
            }
            
            break;
        case LSCalendarTypeJapanese:
            
            
            break;
        case LSCalendarTypeIslamic:
            switch (self.calendarMonth) {
                    //新年 1.1
                    //阿舒拉日 1.10
                    //圣纪节 3.12  ,3.17
                    //登霄夜 7.27
                    //拜拉特夜 8.15
                    //盖德尔夜 9.27
                    //开斋节 10.1
                    //古尔邦节 12.10
                case 1:
                    if (1 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = NSLocalizedStringFromTable(@"islamic_holiday_1",@"lish", nil);
                    }else if (10 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = NSLocalizedStringFromTable(@"islamic_holiday_2",@"lish", nil);
                    }
                    break;
                case 3:
                    if (12 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = NSLocalizedStringFromTable(@"islamic_holiday_3",@"lish", nil);
                    } else if (17 == self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = NSLocalizedStringFromTable(@"islamic_holiday_4",@"lish", nil);
                    }
                    
                    break;
                case 7:
                    if (27 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = NSLocalizedStringFromTable(@"islamic_holiday_5",@"lish", nil);
                    }
                    
                    break;
                case 8:
                    if (15 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = NSLocalizedStringFromTable(@"islamic_holiday_6",@"lish", nil);
                    }
                    
                    break;
                case 9 :
                    
                    if (27 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = NSLocalizedStringFromTable(@"islamic_holiday_7",@"lish", nil);
                    } else if (1 ==self.calendarDay){
                        self.isFestival = YES;
                        self.festivalString = NSLocalizedStringFromTable(@"islamic_holiday_10",@"lish", nil);
                    }
                    
                    break;
                case 10:
                    if (1 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = NSLocalizedStringFromTable(@"islamic_holiday_8",@"lish", nil);
                    }
                    
                    
                    break;
                case 12:
                    if (10 == self.calendarDay) {
                        self.isFestival = YES;
                        self.festivalString = NSLocalizedStringFromTable(@"islamic_holiday_9",@"lish", nil);
                    }
                    
                    break;
                    
                default:
                    break;
            }
            
            break;
        case LSCalendarTypeHebrew:
        case LSCalendarTypeWorldDay:
        
        case LSCalendarTypeChristianHolidays:
        case LSCalendarTypeOrthodoxHolidays:
        {
            for (id<LSFetival> festival in lsyear.festivalArray) {
                if (festival.type == self.type) {
                    
                    NSArray *festivalitemArray = [festival filterItemWithLSDate:self.lsdate];
                    if (festivalitemArray.count) {
                        self.isFestival = YES;
                        int n  = festivalitemArray.count;
                        NSString *name = @"";
                        for (int i = 0; i < n; i++) {
                            id<LSFetivalItem> festivalitem = festivalitemArray[i];
                            if (i < n-1) {
                                name = [name stringByAppendingString:[NSString stringWithFormat:@"%@\n",festivalitem.name]];
                            } else {
                                name = [name stringByAppendingString:[NSString stringWithFormat:@"%@",festivalitem.name]];
                            }
                        }
                        
                        self.festivalString =  name;
                    }
                }
            }
            
        }
            
            break;
            
            
            
            break;
        case LSCalendarTypeJulian:
            
            break;
            
        case LSCalendarTypeZangli:
            if (self.zangli) {
                self.isFestival = self.zangli.isFestival;
                self.festivalString = self.zangli.extraInfo;
            }
            break;
            
       
            
        default:
            break;
    }
    
    
}

- (void)calculateSolorTerm:(LSSolarTermModel *)model {
    
    for (LSSolarTermItemModel *itemModel in model.solarTermsArray) {
        if (self.lsdate.localDay == itemModel.resultDate.localDay && self.lsdate.localMonth == itemModel.resultDate.localMonth && self.lsdate.localYear == itemModel.resultDate.localYear) {
            self.isSolarTerm = YES;
            self.solarTermString = itemModel.name;
            if (itemModel.isFestival) {
                self.isFestival = YES;
                self.festivalString = itemModel.name;
            }
        }
    }
    
}

- (NSString *)dayString {
    if (!_date) {
        return nil;
    }
    if (!_dayString) {
        switch (self.type) {
            case LSCalendarTypeGregorian:
                _dayString = [NSString  stringWithFormat:@"%d",self.calendarDay];
                break;
            case LSCalendarTypeBuddhist:
                
            {
                _dayString = [NSString  stringWithFormat:@"%d",self.calendarDay];
            
            }
                
                break;
                
            case LSCalendarTypeChinese:
            case LSCalendarTypeChineseBuddhist:
            {
                
//                NSArray *chineseDays=[NSArray arrayWithObjects:
//                                         @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
//                                         @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
//                                         @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
                NSString *string = [NSString stringWithFormat:@"chinese_day_%d",self.calendarDay];
                
                _dayString =[[NSBundle mainBundle] localizedStringForKey:string value:nil table:@"lish"];
                
//                _dayString = chineseDays[self.calendarDay-1];
//                _locallizedDayString = [NSString stringWithFormat:@"%d",self.calendarDay];
            }
                   
                
                break;
            case LSCalendarTypeChineseHuangli:
                if (self.huangli) {
//                    _dayString = self.huangli.ganzhiDay;
//                    _locallizedDayString = [NSString stringWithFormat:@"%d",self.calendarDay];
                    
                    _dayString =self.huangli.ganzhiDay;
                }
                
                
                break;
            case LSCalendarTypeZangli:
                if (self.zangli) {
                    _dayString = self.zangli.day;
                    _locallizedDayString = [NSString stringWithFormat:@"%d",self.calendarDay];
                }
                
                
                break;
            case LSCalendarTypeIslamic:
            case LSCalendarTypeIslamicCivil:
            case LSCalendarTypeIslamicUmmAlQura:
            case LSCalendarTypeIslamicTabular:
            {
                _dayString = [NSString  stringWithFormat:@"%d",self.calendarDay];
            }
                
                break;
                
            case LSCalendarTypeHebrew:
            {
                _dayString = [NSString  stringWithFormat:@"%d",self.calendarDay];
            }
                
                break;
            case LSCalendarTypeIndian:
            {
                _dayString = [NSString  stringWithFormat:@"%d",self.calendarDay];
            }
                break;
                
            case LSCalendarTypePersian:
            case LSCalendarTypePersianAhuhan:
            {
                _dayString = [NSString  stringWithFormat:@"%d",self.calendarDay];
            }
                
                break;
            case LSCalendarTypeJapanese:
            {
                _dayString = [NSString  stringWithFormat:@"%d",self.calendarDay];
            }
                
                break;
            case LSCalendarTypeJulian:
            case LSCalendarTypeWorldDay:
            case LSCalendarTypeOrthodoxHolidays:
            case LSCalendarTypeChristianHolidays:
                
            {
                _dayString = [NSString  stringWithFormat:@"%d",self.calendarDay];
            }
                
                break;
           
                
            default:
                break;
        }
    }
    
    return _dayString;
}





- (NSString *)monthString {
    if (!_date) {
        return nil;
    }
    if (!_monthString) {
        
        switch (self.type) {
                
            case LSCalendarTypeGregorian:
            case LSCalendarTypeWorldDay:
            case LSCalendarTypeOrthodoxHolidays:
            case LSCalendarTypeChristianHolidays:
            case LSCalendarTypeJulian:
            case LSCalendarTypeJapanese:
            case LSCalendarTypeBuddhist:
                
                
                
            {
               
                NSString *string = [NSString  stringWithFormat:@"month_%d_f",self.calendarMonth];
                
                _monthString = [[NSBundle mainBundle] localizedStringForKey:string value:@"" table:@"lish"];
            }
                
                break;
            
       
            case LSCalendarTypeChinese:
            case LSCalendarTypeChineseBuddhist:
            {
                
//                NSArray *chineseMonths=[NSArray arrayWithObjects:
//                                           @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
//                                           @"九月", @"十月", @"冬月", @"腊月", nil];
                
                NSString *string = [NSString stringWithFormat:@"chinese_month_%d",self.calendarMonth];
                
                _monthString =[NSString stringWithFormat:@"%@%@",self.calendarLeapMonth?NSLocalizedString(@"leap", nil):@"" ,[[NSBundle mainBundle] localizedStringForKey:string value:nil table:@"lish"]];
//                _localizedMonthString    =[NSString  stringWithFormat:@"%d",self.calendarMonth];
               
            }
                   
                
                break;
                
            case LSCalendarTypeZangli:
                if (self.zangli) {
//                    _localizedMonthString = self.zangli.month;
                    _monthString = self.zangli.month;
                }
                
                
                break;
            case LSCalendarTypeChineseHuangli:
                if (self.huangli) {
                    _monthString =[NSString stringWithFormat:@"%@%@", self.huangli.ganzhiMonth,NSLocalizedString(@"tab_month", nil)];
                }
                
                break;
           
            case LSCalendarTypeIslamic:
            case LSCalendarTypeIslamicCivil:
            case LSCalendarTypeIslamicUmmAlQura:
            case LSCalendarTypeIslamicTabular:
            {
                
                NSString *string = [NSString stringWithFormat:@"islamic_month_%d",self.calendarMonth];
                
                _monthString =[[NSBundle mainBundle] localizedStringForKey:string value:@"" table:@"lish"];
//                switch (self.calendarMonth) {
//                    case 1:
//                        _monthString = @"ٱلمحرم";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_1", nil);
//                        break;
//                    case 2:
//                        _monthString  =@"صفر";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_2", nil);
//                        break;
//                    case 3:
//                        _monthString = @"ربيعٱلأول";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_3", nil);
//                        break;
//                    case 4:
//                        _monthString = @"ربيعٱلثاني";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_4", nil);
//                        break;
//                    case 5:
//                        _monthString = @"جمادىٱلأولى";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_5", nil);
//                        break;
//                    case 6:
//                        _monthString = @"جمادىٱلثانية";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_6", nil);
//                        break;
//                    case 7:
//                        _monthString = @"رجب";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_7", nil);
//                        break;
//                    case 8:
//                        _monthString = @"شعبان";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_8", nil);
//                        break;
//                    case 9:
//                        _monthString = @"رمضان";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_9", nil);
//                        break;
//                    case 10:
//                        _monthString  =@"شوال";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_10", nil);
//                        break;
//                    case 11:
//                        _monthString = @"ذوٱلقعدة";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_11", nil);
//                        break;
//                    case 12:
//                        _monthString = @"ذوٱلقعدة";
//                        _localizedMonthString = NSLocalizedString(@"islamic_month_12", nil);
//                        break;
//
//
//                    default:
//                        break;
//                }
            }
                
                break;
                
            case LSCalendarTypeHebrew:
            {
                
                
                NSString *string = [NSString stringWithFormat:@"hebrew_month_%d",self.calendarMonth];
                
                _monthString =[[NSBundle mainBundle] localizedStringForKey:string value:@"" table:@"lish"];;
               
            }
                
                break;
            case LSCalendarTypeIndian:
            {
               NSString *monthString= [NSString  stringWithFormat:@"indian_month_%d",self.calendarMonth];
                
                _monthString = [[NSBundle mainBundle] localizedStringForKey:monthString value:@"" table:@"lish"];
                
                
            }
                break;
                
            case LSCalendarTypePersian:
                
            {
                
                NSString *string = [NSString stringWithFormat:@"iran_month_%d",self.calendarMonth];
                
                _monthString =[[NSBundle mainBundle] localizedStringForKey:string value:@"" table:@"lish"];
//                switch (self.calendarMonth) {
//                    case 1:
//                        _monthString = @"فروردین";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_1", nil);
//                        break;
//                    case 2:
//                        _monthString  =@"اردیبهشت";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_2", nil);
//                        break;
//                    case 3:
//                        _monthString = @"خرداد";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_3", nil);
//                        break;
//                    case 4:
//                        _monthString = @"تیر";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_4", nil);
//                        break;
//                    case 5:
//                        _monthString = @"مرداد";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_5", nil);
//                        break;
//                    case 6:
//                        _monthString = @"شهریور";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_6", nil);
//                        break;
//                    case 7:
//                        _monthString = @"مهر";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_7", nil);
//                        break;
//                    case 8:
//                        _monthString = @"آبان";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_8", nil);
//                        break;
//                    case 9:
//                        _monthString =@"آذر";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_9", nil);
//                        break;
//                    case 10:
//                        _monthString  = @"دی";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_10", nil);
//                        break;
//                    case 11:
//                        _monthString = @"بهمن";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_11", nil);
//                        break;
//                    case 12:
//                        _monthString = @"اسفند";
//                        _localizedMonthString = NSLocalizedString(@"iran_month_12", nil);
//                        break;
//
//
//                    default:
//                        break;
//                }
            }
                
                break;
            case LSCalendarTypePersianAhuhan:
                {
                    NSString *string = [NSString stringWithFormat:@"afhan_month_%d",self.calendarMonth];
                    
                    _monthString =[[NSBundle mainBundle] localizedStringForKey:string value:@"" table:@"lish"];
                    
//                    switch (self.calendarMonth) {
//                        case 1:
//                            _monthString = @"حمل";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_1", nil);
//                            break;
//                        case 2:
//                            _monthString  =@"ثور";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_2", nil);
//                            break;
//                        case 3:
//                            _monthString = @"جوزا";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_3", nil);
//                            break;
//                        case 4:
//                            _monthString = @"سرطان";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_4", nil);
//                            break;
//                        case 5:
//                            _monthString = @"اسد";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_5", nil);
//                            break;
//                        case 6:
//                            _monthString = @"سنبله";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_6", nil);
//                            break;
//                        case 7:
//                            _monthString = @"میزان";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_7", nil);
//                            break;
//                        case 8:
//                            _monthString = @"عقرب";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_8", nil);
//                            break;
//                        case 9:
//                            _monthString =@"قوس";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_9", nil);
//                            break;
//                        case 10:
//                            _monthString  = @"جدی";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_10", nil);
//                            break;
//                        case 11:
//                            _monthString = @"دلو";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_11", nil);
//                            break;
//                        case 12:
//                            _monthString = @"حوت";
//                            _localizedMonthString = NSLocalizedString(@"afhan_month_12", nil);
//                            break;
//                            
//                            
//                        default:
//                            break;
//                    }
                }
                
                break;
         
                
             
           
                
            default:
                break;
        }
        
    }
    return _monthString ;
}


- (NSString *)yearString {
    if (!_date) {
        return nil;
    }
    if (!_yearString) {
        
        switch (self.type) {
      
            case LSCalendarTypeGregorian:
                _yearString= [NSString  stringWithFormat:@"%d",self.calendarYear];
                
                break;
            case LSCalendarTypeBuddhist:
                
            {
                _yearString= [NSString  stringWithFormat:@"%d",self.calendarYear];
            }
                
                break;
            case LSCalendarTypeChineseBuddhist:
            case LSCalendarTypeChinese:{
                
                NSArray *chineseYears = [NSArray arrayWithObjects:
                                             @"Jia_zi", @"Yi_chou", @"Bing_yin", @"Ding_mao",  @"Wu_chen",  @"Ji_si",  @"Gen_gwu",  @"Xin_wei",  @"Ren_shen",  @"Gui_you",
                                             @"Jia_xu",   @"Yi_hai",  @"Bing_zi",  @"Ding_chou", @"Wu_yin",   @"Ji_mao",  @"Geng_chen",  @"Xin_Ji",  @"Ren_wu",  @"Gui_wei",
                                             @"Jia_shen",   @"Yi_you",  @"Bing_xu",  @"Ding_hai",  @"Wu_zi",  @"Ji_chou",  @"Geng_yin",  @"Xin_mao",  @"Ren_chen",  @"Gui_si",
                                             @"Jia_wu",   @"Yi_wei",  @"Bing_shen",  @"Ding_you",  @"Wu_xu",  @"Ji_hai",  @"Geng_zi",  @"Xin_chou",  @"Ren_yin",  @"Gui_mou",
                                             @"Jia_chen",   @"Yi_si",  @"Bing_wu",  @"Ding_wei",  @"Wu_shen",  @"Ji_you",  @"Geng_xu",  @"Xin_hai",  @"Ren_zi",  @"Gui_chou",
                                             @"Jia_yin",   @"Yi_mao",  @"Bing_chen",  @"Ding_si",  @"Wu_wu",  @"Ji_wei",  @"Geng_shen",  @"Xin_you",  @"Ren_xu",  @"Gui_hai", nil];
                    
               NSString *string  = chineseYears[self.calendarYear-1];
                NSArray *arrays = [string componentsSeparatedByString:@"_"];
                
                _yearString =[NSString stringWithFormat:@"%@%@", [[NSBundle mainBundle] localizedStringForKey:arrays[0] value:@"" table:@"lish"],[[NSBundle mainBundle] localizedStringForKey:arrays[1] value:@"" table:@"lish"]];
                   
            }
                   
                
                break;
            case LSCalendarTypeZangli:
                if (self.zangli) {
                    _yearString = self.zangli.year;
                }
                
                break;
            case LSCalendarTypeChineseHuangli:
                if (self.huangli) {
                    _yearString =self.huangli.ganzhiYear;
                }
                
                break;
            case LSCalendarTypeIslamic:
            case LSCalendarTypeIslamicCivil:
            case LSCalendarTypeIslamicUmmAlQura:
            case LSCalendarTypeIslamicTabular:
            {
                _yearString = [NSString  stringWithFormat:@"%d",self.calendarYear];
            }
                
                break;
                
            case LSCalendarTypeHebrew:
            {
                _yearString = [NSString  stringWithFormat:@"%d",self.calendarYear];
            }
                
                break;
            case LSCalendarTypeIndian:
            {
                _yearString= [NSString  stringWithFormat:@"%d",self.calendarYear];
            }
                break;
                
            case LSCalendarTypePersian:
            case LSCalendarTypePersianAhuhan:
            {
                _yearString = [NSString  stringWithFormat:@"%d",self.calendarYear];
            }
                
                break;
            case LSCalendarTypeJapanese:
                
            {
                _yearString = [NSString  stringWithFormat:@"%d",self.calendarYear];
            
                
            }
                break;
            case LSCalendarTypeJulian:
            case LSCalendarTypeWorldDay:
            case LSCalendarTypeOrthodoxHolidays:
            case LSCalendarTypeChristianHolidays:
                
            {
                _yearString = [NSString  stringWithFormat:@"%d",self.calendarYear];
            }
                
                break;
           
                
            default:
                break;
        }
        
    }
    return _yearString ;
}

- (NSString *)eraString {
    if (!_eraString) {
        
        switch (self.type) {
            case LSCalendarTypeJapanese:{
//                LSJapanEraItemModel *itemmodel = [LSJapanEra filterDate:self.lsdate];
                if (self.japanEraItemModel) {
                    _eraString = [[NSBundle mainBundle] localizedStringForKey:self.japanEraItemModel.english value:nil table:@"lish"];
                } else {
                    _eraString = @"";
                }
                
                
            }
                break;
                
            case LSCalendarTypeIslamic:
            case LSCalendarTypeIslamicCivil:
            case LSCalendarTypeIslamicTabular:
            case LSCalendarTypeIslamicUmmAlQura:
                _eraString  =@"AH";
                break;
            case LSCalendarTypeJulian:
            case LSCalendarTypeGregorian:
            case LSCalendarTypeWorldDay:
            case LSCalendarTypeChristianHolidays:
            case LSCalendarTypeOrthodoxHolidays:
                if (0 == self.calendarEra) {
                    _eraString = @"B.C.";
                } else {
                    _eraString = @"A.D.";
                }
                break;
                
                
            case LSCalendarTypeBuddhist:
                _eraString  =@"BE";
                break;
            case LSCalendarTypeZangli:
                _eraString = @"";
                break;
            case LSCalendarTypeHebrew:
                _eraString = @"";
                break;
            case LSCalendarTypePersian:
            case LSCalendarTypePersianAhuhan:
                _eraString = @"AP";
                break;
            case LSCalendarTypeIndian:
                
                _eraString = @"";
                
                break;
                
                
                
                
            default:
                _eraString = [NSString stringWithFormat:@"%d",self.calendarEra];
                break;
        }
       
        
        
    }
    return _eraString;
}

- (NSString *)fullString {
    if (!_fullString) {
        
        switch (self.type) {
                
            case LSCalendarTypeChinese:
            case LSCalendarTypeZangli:
            case LSCalendarTypeChineseHuangli:
            case LSCalendarTypeChineseBuddhist:
                _fullString = [NSString stringWithFormat:@"%@%@%@ %@ %@",self.eraString,self.yearString,NSLocalizedString(@"tab_year", nil),self.monthString,self.dayString];
                break;
                
            
           
                
            default:
                _fullString = [NSString stringWithFormat:@"%@ %d-%02d-%02d",self.eraString,self.calendarYear,self.calendarMonth,self.calendarDay];
                break;
        }
        
    }
    return _fullString;
}


- (NSString *)displayDayString {
    if (!_date) {
        return nil;
    }
    if (!_displayDayString) {
        if (self.isFestival) {
            _displayDayString = self.festivalString;
        } else if (self.isSolarTerm){
            _displayDayString = self.solarTermString;
        }
        else if (1 == self.calendarDay) {
            
            _displayDayString = self.monthString;
            
//            if (_type == LSCalendarTypeChineseHuangli) {
//                _isFestival = YES;
//                _displayDayString = [NSString stringWithFormat:@"%@ %@",self.monthString,NSLocalizedString(@"tab_month", nil)];
//            }
//
            
            
            if (self.localizedMonthString) {
                if (LSCalendarTypeChinese == self.type || LSCalendarTypeChineseBuddhist== self.type) {
                    
                }else{
                    _displayDayString = self.localizedMonthString;
                }
            } 
        }
        
        else {
            _displayDayString = self.dayString;
        }
    }
    
    return _displayDayString;
    
}



- (void)calulateCalendarHolidayDictWithYear:(int)year {
    
    
    switch (self.type) {
        case LSCalendarTypeChinese:
            
            break;
            
        
            
        default:
            break;
    }
    
}







@end
