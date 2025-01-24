//
//  LSCalendarTypeModel.h
//  lishu
//
//  Created by xueping on 2021/9/20.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"
#import "LSSolarTermModel.h"
#import "LSZangLi.h"
#import "LSLunar.h"
#import "LSJulianCalendar.h"
#import "LSTaiLiModel.h"


NS_ASSUME_NONNULL_BEGIN


@class LSYear;

@interface LSCalendarTypeModel : NSObject


//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierGregorian  API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0)); // the common calendar in Europe, the Western Hemisphere, and elsewhere
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierBuddhist            API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierChinese             API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierCoptic              API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierEthiopicAmeteMihret API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierEthiopicAmeteAlem   API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierHebrew              API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierISO8601             API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierIndian              API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierIslamic             API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierIslamicCivil        API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierJapanese            API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierPersian             API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierRepublicOfChina     API_AVAILABLE(macos(10.6), ios(4.0), watchos(2.0), tvos(9.0));
//// A simple tabular Islamic calendar using the astronomical/Thursday epoch of CE 622 July 15
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierIslamicTabular      API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0));
//// The Islamic Umm al-Qura calendar used in Saudi Arabia. This is based on astronomical calculation, instead of tabular behavior.
//FOUNDATION_EXPORT NSCalendarIdentifier const NSCalendarIdentifierIslamicUmmAlQura    API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0));


typedef NS_ENUM(NSInteger,LSCalendarType){
    
      LSCalendarTypeGregorian=0,
      LSCalendarTypeChinese,  //农历
      LSCalendarTypeJapanese, //日本历
      LSCalendarTypeBuddhist, //泰历
      LSCalendarTypeIslamicCivil, // 伊斯兰民用
      
      LSCalendarTypeHebrew, //希伯来历
      LSCalendarTypeIndian, //印度
      LSCalendarTypePersian ,//波斯历 (伊朗)
      LSCalendarTypeJulian,//儒略历
      LSCalendarTypeWorldDay,//世界节日
      
      
      
     
      
      
      
      
      
      LSCalendarTypeChineseHuangli,//黄历
      LSCalendarTypeChineseBuddhist,//农历佛教
      LSCalendarTypeZangli,//藏历
    
      
      LSCalendarTypeIslamic, // 伊斯兰教日历
      LSCalendarTypeIslamicUmmAlQura,//沙特
      LSCalendarTypeIslamicTabular,//表格
    
      LSCalendarTypePersianAhuhan,//波斯历（阿富汗)
     

     LSCalendarTypeChristianHolidays,//基督教节日
     LSCalendarTypeOrthodoxHolidays,//东正教节日


    LSCalendarTypeThaiLunar,//泰阴历

  
    LSCalendarTypeCoptic,//科普特历
    LSCalendarTypeEthiopic,//埃塞俄比亚

    
    
};


typedef NS_ENUM(NSInteger,LSCalendarGroupType){
    LSCalendarGroupTypeGregorian=0,
    LSCalendarGroupTypeChinese,  //中国历
    LSCalendarGroupTypeJapanese, //日本历
    LSCalendarGroupTypeBuddhist, //佛历
    LSCalendarGroupTypeIslamic, // 伊斯兰
    LSCalendarGroupTypeHebrew, //希伯来历
    LSCalendarGroupTypeIndian, //印度国历
    LSCalendarGroupTypePersian ,//波斯历 (伊朗)
    LSCalendarGroupTypeJulian,//儒略历
    LSCalendarGroupTypeCopticAndEthiopic,//

};















@property(nonatomic,assign)LSCalendarType type;
@property(nonatomic,assign)LSCalendarGroupType groupType;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *lishuname;
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,assign)BOOL hasFestival;

@property(nonatomic,strong)NSCalendar *calendar;

@property(nonatomic,assign)int calendarEra;
@property(nonatomic,assign)int calendarYear;
@property(nonatomic,assign)int calendarMonth;
@property(nonatomic,assign)int calendarDay;

@property(nonatomic,assign)int calendarYearDays;//该历法当年多少天
@property(nonatomic,assign)int calendarMonthDays;//该历法当月多少天
@property(nonatomic,assign)int calendarDayLocationInYear;//该历法当年第多少天
@property(nonatomic,assign)int calendarDayLocationInMonth;//该历法当月第多少天
@property(nonatomic,assign)BOOL calendarLeapMonth;

@property(nonatomic,strong)NSDate *date;
@property(nonatomic,strong)LSDate *lsdate;



@property(nonatomic,copy)NSString *dayString;
@property(nonatomic,copy)NSString *monthString;
@property(nonatomic,copy)NSString *yearString;

@property(nonatomic,copy)NSString *eraString;

@property(nonatomic,copy)NSString *displayDayString;//日历中第一天显示月份


@property(nonatomic,copy)NSString *fullString;



@property(nonatomic,strong)NSMutableDictionary *calendarHolidayDict;

@property(nonatomic,copy)NSString *timeZone;

@property(nonatomic,copy)NSArray*localDaysArray;
@property(nonatomic,copy)NSArray *localMonthsArray;

@property(nonatomic,assign)BOOL is_default;//是否默认
//@property(nonatomic,assign)BOOL selected;

@property(nonatomic,assign)BOOL isFestival;//是否传统节日
@property(nonatomic,assign)BOOL isSolarTerm;//二十四节气
@property(nonatomic,copy)NSString *festivalString;
@property(nonatomic,copy)NSString *solarTermString;

@property(nonatomic,copy)NSString *localizedMonthString;//
@property(nonatomic,copy)NSString *locallizedDayString;


@property(nonatomic,strong)LSLunar *huangli;
@property(nonatomic,strong)LSZangLi *zangli;
@property(nonatomic,strong)LSTaiLiModel *taili;
@property(nonatomic,strong)LSJulianCalendar *julianCalendar;





- (instancetype)initWithType:(LSCalendarType)type;

- (instancetype)initWithType:(LSCalendarType)type timezone:(NSString *)timezoneName;

//- (void)calculateDate:(NSDate *)date;

- (void)calculcateYear:(int)year month:(int)month day:(int)day;


- (void)calculateFestivalWithLSYear:(LSYear *)lsyear;

- (void)calculateSolorTerm:(LSSolarTermModel *)model;




- (void)calulateCalendarHolidayDictWithYear:(int)year;










@end

NS_ASSUME_NONNULL_END
