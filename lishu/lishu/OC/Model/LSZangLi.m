//
//  LSZangLi.m
//  lishu
//
//  Created by xueping on 2021/10/21.
//

#import "LSZangLi.h"

#include "math.h"

@interface LSZangLi ()
@property(nonatomic,copy)NSArray *dataArray;

@property(nonatomic,strong)LSDate *stardate;
@property(nonatomic,strong)LSDate *endDate;

@property(nonatomic,copy)NSArray *hangArray;
@property(nonatomic,copy)NSArray *animalArray;

@end

@implementation LSZangLi

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//
//
//
//    }
//    return self;
//}

+ (LSZangLi *)shareInstance {

    static LSZangLi *zangli;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zangli  =[[LSZangLi alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"zangli.json" ofType:nil];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        
        NSArray *dataArray = [NSJSONSerialization  JSONObjectWithData:data options:kNilOptions error:nil];
        
        zangli.dataArray = dataArray;
        zangli.stardate = [[LSDate alloc] initWithYear:1951 month:1 day:8];
        zangli.endDate  =[[LSDate alloc] initWithYear:2051 month:2 day:11];
        
        zangli.hangArray  =@[@"Iron",@"Water",@"Wood",@"Fire",@"Earth"];
        
        
        zangli.animalArray =@[@"Tiger",@"Hare",@"Dragon",@"Snake",@"Horse",@"Sheep",@"Monkey",@"Bird",@"Dog",@"Boar",@"Rat",@"Ox"];
        
    });

    return zangli;
}



- (void)calculcateYear:(int)year month:(int)month day:(int)day{
    
    LSDate *date  =[[LSDate alloc] initWithYear:year month:month day:day];
    self.lsdate   =date;
    if (self.lsdate.JD < [LSZangLi shareInstance].stardate.JD) {
        return;
    } else if (self.lsdate.JD > [LSZangLi shareInstance].endDate.JD){
        return;
    }
    int days = ([date.date  timeIntervalSinceDate:[LSZangLi shareInstance].stardate.date]+3600)/86400;
    int countingDays=0;
    int countingMonth=0;
    int n =(int) [LSZangLi shareInstance].dataArray.count;
    for(int years=0;years<n;years++){
        int leapMonths=0;//这一年前面闰了几个月
        NSArray *monthArray = [LSZangLi shareInstance].dataArray[years];
        int m = (int) monthArray.count;
        for(int months=0;months<m;months++){
            int tDays=30;
            NSArray *daysArray = monthArray[months];
            int l = (int)daysArray.count;
            for(int i=0;i<l;i++){
                NSInteger value = [daysArray[i] integerValue];
                if(value<0)
                    tDays--;
                else if(value>0)
                    tDays++;
                else  if(value==0)
                    leapMonths++;
            }
            if(countingDays+tDays<=days){ //还没到当前月，直接累加日子
                countingDays+=tDays;
            }else{
                BOOL dayLeap=NO,dayMiss=NO,monthLeap=NO;
                int tDays = days-countingDays;
                for(int i=0;i<l;i++){
                    NSInteger value = [daysArray[i] integerValue];
                    if(value==0){//闰月
                        monthLeap=true;
                    }else{
                        
                        if(value+1==-tDays){//当天缺日
                            dayMiss=true;
                            tDays++;
                        }else if(value == tDays){//当天闰日
                            dayLeap=true;
                            tDays--;
                        }else if(value>0 && value<tDays){//前面出现一个闰日
                                tDays--;
                        }else if(value<0 && -value-1<tDays){//前面出现一个缺日
                                tDays++;
                        }
                    }
                }
                if(years==0){
                    months=12-(int)monthArray.count;
                }
//                var result={};
                
                
                
                NSString *hang = [LSZangLi shareInstance].hangArray[(years/2) % 5];
                NSString *animai = [LSZangLi shareInstance].animalArray[years%12];
                
                
                
                NSString *yearstring = [NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] localizedStringForKey:hang value:@"" table:@"lish"],[[NSBundle mainBundle] localizedStringForKey:animai value:@"" table:@"lish"]];;

                
                self.year  = yearstring;
                
                
                NSString *loclizedmonth = [NSString stringWithFormat:@"tibetan_month_%d",months-leapMonths+1];
                
               
                
                NSString *monthstring=[NSString stringWithFormat:@"%@%@",monthLeap?NSLocalizedString(@"leap", nil):@"",[[NSBundle mainBundle] localizedStringForKey:loclizedmonth value:@"" table:@"lish"]];
//                (monthLeap?"闰":"")+["正","二","三","四","五","六","七","八","九","十","十一","十二"][months-leapMonths];
                NSString *tmonth=[NSString stringWithFormat:@"%@%@",monthLeap?NSLocalizedString(@"leap", nil):@"",@[@"神变月",@"苦行月",@"具香月",@"萨嘎月",@"作净月",@"明净月",@"具醉月",@"具贤月",@"天降月",@"持众月",@"庄严月",@"满意月"][months-leapMonths]];
                self.calendarMonth = months-leapMonths;
                self.month  =  monthstring;
                self.tmonth = tmonth;
//                result.tMonth=(monthLeap?"闰":"")+["神变","苦行","具香","萨嘎","作净","明净","具醉","具贤","天降","持众","庄严","满意"][months-leapMonths]
                
                
                NSString *localizedday = [NSString stringWithFormat:@"chinese_day_%d",tDays+1];
                
                
                NSString *daystring=[NSString stringWithFormat:@"%@%@",dayLeap?NSLocalizedString(@"leap", nil):@"",[[NSBundle mainBundle] localizedStringForKey:localizedday value:@"" table:@"lish"]];
                self.day = daystring;
                self.calendarDay  =tDays+1;
                
//                = (dayLeap?"闰":"")+["初一","初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"][tDays];
                self.dayLeap=dayLeap;
                self.monthLeap=monthLeap;
                self.dayMiss=dayMiss;
//                self.value=[NSString stringWithFormat:@"%@年%@月(%@月)%@",year,month,tmonth,day];
//                result.year+"年"+result.month+"月("+result.tMonth+"月)"+result.day;
                NSString* extraInfo=@"";
                NSString* extraInfo2=@"";
                if(!dayLeap)switch (tDays){
                    case 0:
                        if(months==0) {
                            self.isFestival = YES;
                            
                            extraInfo=@"神变节";
                        }
                        else
                        {
                            self.isFestival = YES;
                            extraInfo=@"禅定胜王佛节日";
                            
                            extraInfo2=@"作何善恶成百倍";
                            
                        }
                        break;
                    case 3:
                        if(months==5)
                        {
                            self.isFestival = YES;
                            extraInfo=@"释迦牟尼佛\n初转法轮日";
                        }
                        break;
                    case 6:
                        if(months==3){
                            self.isFestival = YES;
                            extraInfo=@"释迦牟尼佛诞辰";
                        }
                    
                        break;
                    case 7:{
                        self.isFestival = YES;
                        extraInfo=@"药师佛节日";extraInfo2=@"作何善恶成千倍";
                    }
                        break;
                    case 9:{
                        self.isFestival = YES;
                        extraInfo=@"莲师荟供日";extraInfo2=@"作何善恶成十万倍";
                    }
                        break;
                    case 14:
                        if(months==3){
                            self.isFestival = YES;
                            extraInfo=@"释迦牟尼佛\n成道日涅槃日";
                        }
                        else if(months==5){
                            self.isFestival = YES;
                            extraInfo=@"释迦牟尼佛入胎日";
                        }
                        else {
                            self.isFestival = YES;
                            extraInfo=@"阿弥陀佛节日";extraInfo2=@"作何善恶成百万倍";
                        }
                        break;
                    case 17:{
                        self.isFestival = YES;
                        extraInfo=@"观音菩萨节日";extraInfo2=@"作何善恶成千万倍";
                    }
                        break;
                    case 19:
                        if(months==8) {
                            self.isFestival = YES;
                            extraInfo=@"释迦牟尼佛天降日";
                            
                        }
                        break;
                    case 20:{
                        self.isFestival = YES;
                        extraInfo=@"地藏王菩萨节日";
                        extraInfo2=@"作何善恶成亿倍";
                    }
                        break;
                    case 24:
                        self.isFestival = YES;
                        extraInfo=@"空行母荟供日";
                        
                        break;
                    case 29:
                        self.isFestival = YES;
                        extraInfo=@"释迦牟尼佛节日";
                        extraInfo2=@"作何善恶成九亿倍";
                        break;
                }
                self.extraInfo=extraInfo;
                self.extraInfo2=extraInfo2;
                
                return;
              
                
                
            }
        }
    }

    
}




@end
