//
//  LSEclipseModel.m
//  lishu
//
//  Created by efc on 2021/9/24.
//

#import "LSEclipseModel.h"
#include "AA+.h"
#import "LSSun.h"
#import "LSEclipseItemModel.h"


@implementation LSEclipseModel

- (instancetype)initWithYear:(int)year timeZone:(NSString *)timeZone {
    
    self = [super init];
    if (self) {
        
        self.year = year;
        
        self.timeZone = timeZone;
        
        LSDate *startDate = [[LSDate alloc] initWithYear:year month:1 day:1 timezone:timeZone];
        
        self.startJD = startDate.JD;
        
        CAADate  aadate  =CAADate(startDate.JD, true);

         double fraction =aadate.FractionalYear();
        

         int kvalue = floor(CAAMoonPhases::K(fraction));
        
        
        LSDate *endDate = [[LSDate alloc] initWithYear:year+1 month:1 day:1 timezone:timeZone];
        self.endJD = endDate.JD;
        
        CAADate  bbdate  =CAADate(endDate.JD, true);

         double bfraction =bbdate.FractionalYear();
        

         int bkvalue = floor(CAAMoonPhases::K(bfraction))+1;
        self.solarArray = [NSMutableArray array];
        self.lunarArray = [NSMutableArray array];
        
        
        for (int i = kvalue; i < bkvalue; i ++) {
            
            CAASolarEclipseDetails  EclipseDetails = CAAEclipses::CalculateSolar(i);
            if (EclipseDetails.Flags)
            {
             CAADate date_time = CAADate(EclipseDetails.TimeOfMaximumEclipse, (EclipseDetails.TimeOfMaximumEclipse >= 2299160.5));
                
                int type = 0;
                
                NSString *name;
        
                if (EclipseDetails.Flags & CAASolarEclipseDetails::TOTAL_ECLIPSE){
                    type =1;
                    name  = NSLocalizedString(@"solar_eclipse_total", nil);
                }
        
                if (EclipseDetails.Flags & CAASolarEclipseDetails::ANNULAR_ECLIPSE){
                   type =2;
                    name = NSLocalizedString(@"solar_eclipse_hybrid", nil);
                    
                }
                if (EclipseDetails.Flags & CAASolarEclipseDetails::ANNULAR_TOTAL_ECLIPSE){
                  type =3;
                    name = NSLocalizedString(@"solar_eclipse_annular", nil);
                }
              if (EclipseDetails.Flags & CAASolarEclipseDetails::CENTRAL_ECLIPSE)
                  type  =4;
              if (EclipseDetails.Flags & CAASolarEclipseDetails::NON_CENTRAL_ECLIPSE)
                  type =5;
              if (EclipseDetails.Flags & CAASolarEclipseDetails::PARTIAL_ECLIPSE)
              {
                  type = 6;
                  name  = NSLocalizedString(@"solar_eclipse_partical", nil);
              }
          
                LSEclipseItemModel *solormodel = [[LSEclipseItemModel alloc] initWithType:type JD:date_time.Julian()];
                solormodel.lsdate = [[LSDate alloc] initWithJD:date_time.Julian() timezone:self.timeZone];
                solormodel.name = name;
                if (self.year == solormodel.lsdate.localYear) {
                    [self.solarArray addObject:solormodel];
                }
               
                
            }
            
            CAALunarEclipseDetails  lunarDetails = CAAEclipses::CalculateLunar(i+0.5);
            if (lunarDetails.bEclipse)
            {
             CAADate date_time = CAADate(lunarDetails.TimeOfMaximumEclipse, (EclipseDetails.TimeOfMaximumEclipse >= 2299160.5));
                
                int type = 0;
                NSString *name;
        
                if (lunarDetails.TotalPhaseSemiDuration > 0) {
                    type = 3;
                    name  = NSLocalizedString(@"lunar_eclipse_total", );
                } else if (lunarDetails.PartialPhaseSemiDuration > 0){
                    type =2;
                    name  = NSLocalizedString(@"lunar_eclipse_partial", nil);
                } else {
                    type =1;
                    name = NSLocalizedString(@"lunar_eclipse_penumbral", nil);
                }
                LSEclipseItemModel *lunarmodel = [[LSEclipseItemModel alloc] initWithType:type JD:date_time.Julian()];
                lunarmodel.lsdate = [[LSDate alloc] initWithJD:date_time.Julian() timezone:self.timeZone];
                lunarmodel.name = name;
                if (self.year  == lunarmodel.lsdate.localYear  ) {
                    [self.lunarArray addObject:lunarmodel];
                }
                
                
                
            }
            
            
            
        }
        
        
        
        
    }
    return self;
    
}

@end
