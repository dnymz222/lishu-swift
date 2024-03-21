//
//  LSSolarTermItemModel.m
//  lishu
//
//  Created by xueping on 2021/9/22.
//

#import "LSSolarTermItemModel.h"
#import "LSSun.h"
#import "LSSolarTermModel.h"

@implementation LSSolarTermItemModel

- (instancetype)initWithType:(NSInteger)type hemisType:(NSInteger)hemisType {
    self  =[super init];
    if (self) {
        
        self.type =  type;
        self.hemisType = hemisType;
        
        self.targetLong = 15*type;
        
        NSString *name;
        
        if (0 == hemisType) {
            
            
            
            switch (type) {
                case 0:
                    self.startNowYear = YES;
                    
                    name =@"solar_term_1";
                    
                    break;
                case 1:
                    self.startNowYear = YES;
                    
                    name =@"solar_term_2";
                    self.isFestival = YES;
                    self.festivalString  = [[NSBundle mainBundle] localizedStringForKey:@"Qingming Festival" value:nil table:@"lish"];
                    
                    break;
                case 2:
                    self.startNowYear = YES;
                    
                    name =@"solar_term_3";
                    
                    break;
                case 3:
                    self.startNowYear = YES;
                    name =@"solar_term_4";;
                    
                    break;
                    
                case 4:
                    self.startNowYear = YES;
                    
                    name =@"solar_term_5";;
                    
                    break;
                case 5:
                    self.startNowYear = YES;
                    name =@"solar_term_6";;
                    
                    break;
                case 6:
                    self.startNowYear = YES;
                    
                    name =@"solar_term_7";
                    
                    break;
                case 7:
                    self.startNowYear = YES;
                    
                    name  =@"solar_term_8";;
                    
                    break;
                    
                case 8:
                    self.startNowYear = YES;
                    
                    name  =@"solar_term_9";;
                    break;
                    
                case 9:
                    self.startNowYear = YES;
                    name  =@"solar_term_10";;
                    
                    break;
                    
                case 10:
                    self.startNowYear = YES;
                    
                    name  =@"solar_term_11";;
                    
                    break;
                    
                case 11:
                    self.startNowYear = YES;
                    name  =@"solar_term_12";
                    
                    break;
                    
                case 12:
                    self.startNowYear = YES;
                    name  =@"solar_term_13";
                    
                    break;
                case 13:
                    self.startNowYear = YES;
                    
                    name  =@"solar_term_14";;
                    
                    break;
                case 14:
                    self.startNowYear = YES;
                    
                    name  =@"solar_term_15";;
                    
                    break;
                    
                case 15:
                    self.startNowYear = YES;
                    
                    name  = @"solar_term_16";;
                    
                    break;
                    
                case 16:
                    self.startNowYear = YES;
                    
                    name  =@"solar_term_17";;
                    
                    break;
                    
                case 17:
                    self.startNowYear = YES;
                    
                    name  =@"solar_term_18";;
                    
                    break;
                    
                case 18:
                    self.startNowYear = YES;
                    
                    name  =@"solar_term_19";;
                    self.isFestival = YES;
                    self.festivalString  = [[NSBundle mainBundle] localizedStringForKey:@"Dongzhi Festival" value:nil table:@"lish"];
                    
                    break;
                    
                case 19:
                    self.startNowYear = NO;
                    
                    name  =@"solar_term_20";;
                    
                    break;
                    
                case 20:
                    self.startNowYear = NO;
                    
                    name  =@"solar_term_21";;
                    
                    break;
                    
                case 21:
                    self.startNowYear = NO;
                    
                    name =@"solar_term_22";;
                    
                    break;
                case 22:
                    self.startNowYear = NO;
                    name  =@"solar_term_23";;
                    
                    break;
                case 23:
                    self.startNowYear = NO;
                    name  =@"solar_term_24";;
                    
                    break;
            
                    
                default:
                    break;
            }
            
        } else{
            
            switch (type) {
                case 0:
                    self.startNowYear = YES;
                    name =@"solar_term_13";
                    
                    break;
                case 1:
                    self.startNowYear = YES;
                    name =@"solar_term_14";
                    
                    break;
                case 2:
                    self.startNowYear = YES;
                    name =@"solar_term_15";
                    
                    break;
                case 3:
                    self.startNowYear = YES;
                    name =@"solar_term_16";
                    
                    break;
                    
                case 4:
                    self.startNowYear = YES;
                    name =@"solar_term_17";
                    
                    break;
                case 5:
                    self.startNowYear = YES;
                    name =@"solar_term_18";
                    
                    break;
                case 6:
                    self.startNowYear = YES;
                    name =@"solar_term_19";
                    
                    break;
                case 7:
                    self.startNowYear = YES;
                    name =@"solar_term_20";
                    
                    break;
                    
                case 8:
                    self.startNowYear = YES;
                    name =@"solar_term_21";
                    break;
                    
                case 9:
                    self.startNowYear = YES;
                    name =@"solar_term_22";
                    
                    break;
                    
                case 10:
                    self.startNowYear = YES;
                    name =@"solar_term_23";
                    
                    break;
                    
                case 11:
                    self.startNowYear = YES;
                    name =@"solar_term_24";
                    
                    break;
                    
                case 12:
                    self.startNowYear = YES;
                    name =@"solar_term_1";
                    
                    break;
                case 13:
                    self.startNowYear = YES;
                    name =@"solar_term_2";
                    
                    break;
                case 14:
                    self.startNowYear = YES;
                    name =@"solar_term_3";
                    
                    break;
                    
                case 15:
                    self.startNowYear = YES;
                    name =@"solar_term_4";
                    
                    break;
                    
                case 16:
                    self.startNowYear = YES;
                    name =@"solar_term_5";
                    
                    break;
                    
                case 17:
                    self.startNowYear = YES;
                    name =@"solar_term_6";
                    
                    break;
                    
                case 18:
                    self.startNowYear = YES;
                    name =@"solar_term_7";
                    break;
                    
                case 19:
                  
                    self.startNowYear = NO;
                    name =@"solar_term_8";
                    
                    break;
                    
                case 20:
                    self.startNowYear = NO;
                    name =@"solar_term_9";
                    
                    break;
                    
                case 21:
                    self.startNowYear = NO;
                    name =@"solar_term_10";
                    
                    break;
                case 22:
                    self.startNowYear = NO;
                    name =@"solar_term_11";
                    
                    break;
                case 23:
                    self.startNowYear = NO;
                    name =@"solar_term_12";
                    
                    break;
            
                    
                default:
                    break;
            }
            
            
        }
        
        self.name = [[NSBundle mainBundle] localizedStringForKey:name value:@"" table:@"lish"];
        
    }
    return self;
}

- (void)calculateSolorTerm:(LSSolarTermModel *)solarTerm {
    
    
    self.resultJD = [LSSun calculateSunLongWithStartJd:solarTerm.startJD endJd:solarTerm.endJD startLong:solarTerm.startLong endLong:solarTerm.endLong targetSunLong:self.targetLong];
    
    self.resultDate = [[LSDate alloc] initWithJD:self.resultJD timezone:solarTerm.timeZone];
    
    
}

@end
