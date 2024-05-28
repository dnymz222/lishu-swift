//
//  LSCalendarGroup.m
//  lishu
//
//  Created by xueping on 2021/10/17.
//

#import "LSCalendarGroup.h"
#import "LSDataBaseTool.h"


//"calendar_group_gregorian"  = "Gregorian Calender";
//"calendar_group_japanese"  = "Japannese Calendar";
//"calendar_group_indian"  = "Indial Calendar";
//"calendar_group_tailand" = "Thai calendar";
//"calendar_group_hebrew" = "Hebrew calendar";
//"calendar_group_julian" = "Julian Calendar";
//"calendar_group_islamic"  = "Islamic Calendar";
//"calendar_group_persian" = "Persian Calendar";


@implementation LSCalendarGroup

- (instancetype)initWithType:(NSInteger)type {
    
    self = [super init];
    self.type = type;
   
    if (self) {
        switch (type) {
                
            case 0:
                
                self.name = NSLocalizedStringFromTable(@"calendar_group_gregorian", @"lish", nil);
                
                break;
            case 1:
                
                self.name  = NSLocalizedStringFromTable(@"calendar_group_chinese", @"lish", nil);
              
                
                break;
            case 2:
                self.name  =NSLocalizedStringFromTable(@"calendar_group_japanese", @"lish", nil);
                
                break;
            case 3:
                self.name  =NSLocalizedStringFromTable(@"calendar_group_buddhist", @"lish", nil);
                
                break;
            case 4:
                self.name  =NSLocalizedStringFromTable(@"calendar_group_islamic", @"lish", nil);
                
                break;
            case 5:
                self.name  = NSLocalizedStringFromTable(@"calendar_group_hebrew", @"lish", nil);
                break;
            case 6:
                self.name  = NSLocalizedStringFromTable(@"calendar_group_indian", @"lish", nil);
                
                break;
            case 7:
                self.name  = NSLocalizedStringFromTable(@"calendar_group_persian", @"lish", nil);
                
                break;
                
         
            case 8:
                self.name = NSLocalizedStringFromTable(@"calendar_group_julian", @"lish", nil);
                
                break;
            case 9:
                self.name = NSLocalizedStringFromTable(@"calendar_group_coptic", @"lish", nil);
                
                break;
                
                
                
            default:
                break;
        }
    
        
        
        
    }
    
    return self;
    
}

- (void)createData {
    
    self.dataArray = [LSDataBaseTool excuteCaledarConfigArrayGrouptype:self.type];
}

@end
