//
//  LSWorldDay.m
//  lishu
//
//  Created by xueping on 2021/10/25.
//

#import "LSWorldDay.h"
#import "LSDate.h"

@implementation LSWorldDay

- (instancetype)initWithYear:(int)year {
    self = [super init];
    if (self) {
        self.year = year;
        self.type = (int)LSCalendarTypeWorldDay;
        NSMutableArray *dataArray = [NSMutableArray array];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:1 day:14 name:@"World Logic Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:1 day:24 name:@"International Day of Education"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:1 day:24 name:@"World Day for African and Afrodescendant Culture"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:1 day:27 name:@"International Day of Commemoration in Memory of the Victims of the Holocaust"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:2 day:11 name:@"International Day of Women and Girls in Science"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:2 day:13 name:@"World Radio Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:2 day:21 name:@"International Mother Language Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:3 day:4 name:@"World Engineering Day for Sustainable Development"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:3 day:8 name:@"International Women’s Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:3 day:14 name:@"International Day of Mathematics"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:3 day:20 name:@"International Francophonie Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:3 day:21 name:@"World Poetry Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:3 day:21 name:@"International Day for the Elimination of Racial Discrimination"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:3 day:21 name:@"International Day of Nowruz"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:3 day:22 name:@"World Water Day"]];
        
        
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:4 day:6 name:@"International Day of Sport for Development and Peace"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:4 day:15 name:@"World Art Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:4 day:23 name:@"World Book and Copyright Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:4 day:30 name:@"International Jazz Day"]];
        
        
        
        
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:5 day:3 name:@"World Press Freedom Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:5 day:5 name:@"African World Heritage Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:5 day:5 name:@"World Portuguese Language Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:5 day:16 name:@"International Day of Light"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:5 day:16 name:@"International Day of Living Together in Peace"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:5 day:21 name:@"World Day for Cultural Diversity for Dialogue and Development"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:5 day:22 name:@"International Day for Biological Diversity"]];
        
        
        
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:6 day:5 name:@"World Environment Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:6 day:8 name:@"World Oceans Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:6 day:17 name:@"World Day to Combat Desertification and Drought"]];

        
        
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:7 day:18 name:@"Nelson Mandela International Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:7 day:26 name:@"International Day for the Conservation of the Mangrove Ecosystem"]];
        
        
       
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:8 day:9 name:@"International Day of the World's Indigenous People"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:8 day:12 name:@"International Youth Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:8 day:23 name:@"International Day for the Remembrance of the Slave Trade and its Abolition"]];
        
        

        
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:9 day:8 name:@"International Literacy Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:9 day:15 name:@"International Day of Democracy"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:9 day:20 name:@"International Day of University Sport"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:9 day:21 name:@"International Day of Peace"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:9 day:28 name:@"International Day for the Universal Access to Information"]];
        
        
        
        
        
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:10 day:5 name:@"World Teachers' Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:10 day:11 name:@"International Day of the Girl Child"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:10 day:13 name:@"International Day for Disaster Reduction"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:10 day:17 name:@"International Day for the Eradication of Poverty"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:10 day:24 name:@"United Nations Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:10 day:27 name:@"World Day for Audiovisual Heritage"]];
        
        
        
        
        
        LSDate *date = [[LSDate alloc] initWithYear:year month:10 day:31];
        LSDate *firstthursday = [date dateforNearWeekDay:4 before:NO];
        LSDate *secondthursday = [firstthursday dateforNearWeekDay:4 before:NO];
        LSDate *thirdwendsday = [secondthursday dateforNearWeekDay:3 before:NO];
        
        
        
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:firstthursday.localMonth day:firstthursday.localDay name:@"International Day Against Violence and Bullying at School, including Cyberbullying"]];
        
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:11 day:2 name:@"International Day to End Impunity for Crimes against Journalists"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:11 day:5 name:@"World Day of Romani Language"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:11 day:5 name:@"World Tsunami Awareness Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:11 day:10 name:@"World Science Day for Peace and Development"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:thirdwendsday.localMonth   day:thirdwendsday.localDay name:@"World Philosophy Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:11 day:14 name:@"International Day against Illicit Trafficking in Cultural Property"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:11 day:16 name:@"International Day for Tolerance"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:11 day:18 name:@"International Day of Islamic Art"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:11 day:25 name:@"International Day for the Elimination of Violence against Women"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:11 day:26 name:@"World Olive Tree Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:11 day:29 name:@"International Day of Solidarity with the Palestinian People"]];
        
        
        
        
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:12 day:1 name:@"World AIDS Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:12 day:3 name:@"International Day of Persons with Disabilities"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:12 day:10 name:@"Human Rights Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:12 day:10 name:@"International Migrants Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:12 day:18 name:@"United Nations Day"]];
        [dataArray addObject:[[LSWorldDayItem alloc] initWithYear:year month:12 day:18 name:@"World Arabic Language Day"]];
        
        
        self.dataArray = dataArray.copy;
        
        
        
        
    }
    return self;
}

- (NSArray *)filterItemWithLSDate:(LSDate *)lsdate {
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (LSWorldDayItem *dayItem in self.dataArray) {
        if (dayItem.lsdate.localYear ==lsdate.localYear && dayItem.lsdate.localMonth == lsdate.localMonth && dayItem.lsdate.localDay == lsdate.localDay) {
            [dataArray  addObject:dayItem];
        }
    }
    
    return dataArray.copy;
    
}

@end

@implementation LSWorldDayItem

- (instancetype)initWithYear:(int)year month:(int)month day:(int)day name:(NSString *)name {
    self = [super init];
    if (self) {
        self.year = year;
        self.month = month;
        self.day = day;
        self.name = [[NSBundle mainBundle] localizedStringForKey:name value:@"" table:@"lish"];
        
        self.type = (int)LSCalendarTypeWorldDay;
        
        self.lsdate = [[LSDate alloc] initWithYear:year month:month day:day];
        
        self.calendarModel = [[LSCalendarTypeModel alloc] initWithType:LSCalendarTypeWorldDay];
        
    }
    return self;
}



@end
