//
//  LSDataBaseTool.m
//  lishu
//
//  Created by xueping on 2021/3/27.
//

#import "LSDataBaseTool.h"
#import <fmdb/FMDB.h>
#import <YYModel/YYModel.h>
#import "LSLocation.h"
#import "LSHolidayRegion.h"

static FMDatabase *__db;



@implementation LSDataBaseTool


+ (void)initialize {
    
    
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath = [docuPath stringByAppendingPathComponent:@"lishu.db"];
    __db = [[FMDatabase alloc] initWithPath:dbPath];
    
//    NSLog(@"path:%@",dbPath);
    
    if ([__db open]) {
        
        BOOL   result1 =   [__db executeUpdate:@"CREATE TABLE IF NOT EXISTS LocationTable (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,KEY TEXT UNIQUE ,LocalizedName TEXT,EnglishName TEXT,TimeZone TEXT,CountryOrDistrict TEXT,GeoPosition TEXT,AdministrativeArea Text,sortIndex INTEGER,selected INTEGER)"];
        
       
//        BOOL   result2 =   [__db executeUpdate:@"CREATE TABLE IF NOT EXISTS HolidayRegion (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,name TEXT,code TEXT,flag TEXT,languages TEXT,selected INTEGER)"];
        
        
        BOOL   result2 =   [__db executeUpdate:@"CREATE TABLE IF NOT EXISTS WorkingConfig (config_id TEXT PRIMARY KEY UNIQUE,country TEXT,code TEXT,flag TEXT,website TEXT,is_sub INTEGER,default_configuration TEXT,config TEXT,is_default INTEGER,  selected INTEGER)"];
        
        
        BOOL   result3 =   [__db executeUpdate:@"CREATE TABLE IF NOT EXISTS CalendarConfig (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE,name TEXT,type INTEGER, groupType INTEGER,is_default INTEGER, selected INTEGER,has_festival INTEGER)"];
        
        
        
     
       
        
        
    } else {
        
        
    }
    
    [__db setShouldCacheStatements:YES];
    
    
    
}

+ (void)clearTable {
    
    [__db executeUpdate:@"delete from LocationTable"];
    [__db executeUpdate:@"update sqlite_sequence set seq=0 where name='LocationTable'"];
    
  
    
//    [__db executeUpdate:@"delete from HolidayRegion"];
//    [__db executeUpdate:@"update sqlite_sequence set seq=0 where name='HolidayRegion'"];
    
}

+ (void)addLocation:(LSLocation *)location {
        
    
      FMResultSet *set = [__db executeQuery:@"SELECT count(*) FROM LocationTable"];
    
      int count = 0;
    
     while ([set next]) {
         count = [set intForColumnIndex:0];
     }
    
        
      BOOL result =    [__db executeUpdate:@"INSERT INTO LocationTable (KEY ,LocalizedName ,EnglishName,TimeZone  ,CountryOrDistrict ,GeoPosition,AdministrativeArea ,sortIndex,selected )VALUES(?,?,?,?,?,?,?,?,?)",location.Key,location.LocalizedName,location.EnglishName,[location.TimeZone yy_modelToJSONString],[location.CountryOrDistrict yy_modelToJSONString],[location.GeoPosition yy_modelToJSONString],[location.AdministrativeArea yy_modelToJSONString],@(count+1),@(0)];
        
        if (result) {
            NSLog(@"insertSuccess");
        }
            
}



    
+ (void)updateLocalLocation:(LSLocation *)location {
            

        
         [__db executeUpdate:@"DELETE FROM LocationTable WHERE sortIndex = ?",@(0)];
        
        
        
            
          BOOL result =    [__db executeUpdate:@"INSERT INTO LocationTable (KEY ,LocalizedName,EnglishName,TimeZone,CountryOrDistrict ,GeoPosition,AdministrativeArea ,sortIndex,selected)VALUES(?,?,?,?,?,?,?,?,?)",location.Key,location.LocalizedName,location.EnglishName,[location.TimeZone yy_modelToJSONString],[location.CountryOrDistrict yy_modelToJSONString],[location.GeoPosition yy_modelToJSONString],[location.AdministrativeArea yy_modelToJSONString],@(0),@(0)];
            
            if (result) {
                NSLog(@"insertSuccess");
            }
                
}
        
        

    
+ (void)addLocation:(LSLocation *)location index:(NSInteger)index {
    
    
  BOOL result =    [__db executeUpdate:@"INSERT INTO LocationTable (KEY ,LocalizedName ,EnglishName,TimeZone,CountryOrDistrict,GeoPosition,AdministrativeArea,sortIndex,selected)VALUES(?,?,?,?,?,?,?,?,?)",location.Key,location.LocalizedName,location.EnglishName,[location.TimeZone yy_modelToJSONString],[location.CountryOrDistrict yy_modelToJSONString],[location.GeoPosition yy_modelToJSONString],[location.AdministrativeArea yy_modelToJSONString],@(index),@(0)];
    
    if (result) {
        NSLog(@"insertSuccess");
    }
        
        
        
}
    

+ (BOOL)deleteLocation:(LSLocation *)location {
    
   BOOL result    = [__db executeUpdate:@"DELETE FROM LocationTable WHERE key = ?",location.Key];
    return result;
}
    
    
    

+ (NSArray *)excuteLocationArray {
    
    NSMutableArray *array = [NSMutableArray array];
    
    FMResultSet *set = [__db executeQuery:@"SELECT * FROM LocationTable ORDER BY sortIndex ASC"];
    
    while ([set next]) {
        LSLocation *location= [[LSLocation alloc] init ];
        
        location.Key   =[set stringForColumn:@"key"];
        location.LocalizedName = [set stringForColumn:@"LocalizedName"];
        location.EnglishName   =[set stringForColumn:@"EnglishName"];
        NSString *timezone  = [set stringForColumn:@"TimeZone"];
        location.TimeZone  = [LSTimeZone yy_modelWithJSON:timezone];
       
        NSString *CountryOrDistrict   = [set stringForColumn:@"CountryOrDistrict"];
        location.CountryOrDistrict = [LSCountryOrDistrictModel yy_modelWithJSON:CountryOrDistrict];
        
        NSString *GeoPosition  = [set stringForColumn:@"GeoPosition"];
        
        location.GeoPosition =  [LSGeoPosition yy_modelWithJSON:GeoPosition];
        
        NSString *AdministrativeArea =  [set stringForColumn:@"AdministrativeArea"];
        location.AdministrativeArea   = [LSAdministrativeAreaModel yy_modelWithJSON:AdministrativeArea];
        
        location.isCurrent = (0 == [set intForColumn:@"sortIndex"]);
        
    
        [array addObject:location];
    }
    [set close];
    
    return array.copy;
    
}

+ (void)addHolidayRegion:(LSHolidayRegion *)region{
    
    
  BOOL result =    [__db executeUpdate:@"INSERT INTO HolidayRegion (name,code,flag ,languages ,selected  )VALUES(?,?,?,?,?)",region.name,region.code,region.flag,[region.languages yy_modelToJSONString],@(1)];
    
    if (result) {
        NSLog(@"insertSuccess");
    }
        
        
        
}


+ (NSArray *)excuteRegionArray {
    
    NSMutableArray *array = [NSMutableArray array];
    
    FMResultSet *set = [__db executeQuery:@"SELECT * FROM HolidayRegion"];
    
    while ([set next]) {
        LSHolidayRegion *region= [[LSHolidayRegion alloc] init ];
        
        region.name   =[set stringForColumn:@"name"];
        region.code = [set stringForColumn:@"code"];
        region  .flag  =[set stringForColumn:@"flag"];
//        NSString *languages  = [set stringForColumn:@"languages"];
//        region.languages = [NSArray yy_modelWithJSON:languages];
        
       
        region.selected = [set intForColumn:@"selected"];
        
   
        
        
        [array addObject:region];
    }
    [set close];
    
    return array.copy;
    
}


- (void)updateAllRegionsSelected {
    
    FMResultSet *set = [__db executeQuery:@"UPDATE HolidayRegion SET selected = ? WHERE selected = ?",@1,@0];
}


- (void)updateAllRegionsUnselected {
    FMResultSet *set = [__db executeQuery:@"UPDATE HolidayRegion SET selected = ? WHERE selected = ?",@1,@0];
    
}

- (void)updateRegion:(LSHolidayRegion *)region selected:(NSInteger)selected {
    FMResultSet *set = [__db executeQuery:@"UPDATE HolidayRegion SET selected = ? WHERE code = ?",@(selected),region.code];
    
}


+ (NSArray *)excuteSelectedRegionArray {
    
    NSMutableArray *array = [NSMutableArray array];
    
    FMResultSet *set = [__db executeQuery:@"SELECT * FROM HolidayRegion WHERE selected = ?",@1];
    
    while ([set next]) {
        LSHolidayRegion *region= [[LSHolidayRegion alloc] init ];
        
        region.name   =[set stringForColumn:@"name"];
        region.code = [set stringForColumn:@"code"];
        region  .flag  =[set stringForColumn:@"flag"];
//        NSString *languages  = [set stringForColumn:@"languages"];
//        region.languages = [NSArray yy_modelWithJSON:languages];
        
       
        region.selected = [set intForColumn:@"selected"];
        
   
        
        
        [array addObject:region];
    }
    [set close];
    
    return array.copy;
    
}

    
+ (void)updateLocationSelected:(LSLocation *)location {
        
    FMResultSet *set = [__db executeQuery:@"UPDATE LocationTable SET selected = ? WHERE selected = ?",@0,@1];
    
    FMResultSet *set1 = [__db executeQuery:@"UPDATE LocationTable SET selected = ? WHERE key= ?",@1,location.Key];
}


+ (void)addWorkingDayConfig:(LSWorkingDayConfig *)config {
    
    NSString *defauleConfig = config.default_configuration;
    NSString *code = config.code;
    
    
  BOOL result =    [__db executeUpdate:@"INSERT INTO WorkingConfig(config_id,country,code,flag,website,is_sub,default_configuration,config,is_default,selected)VALUES(?,?,?,?,?,?,?,?,?,?)",code,config.configId,code,config.flag,config.website,@(0),config.default_configuration,@"",@(0),@(1)];
    
    for (NSString *subConfig in config.configurations) {
        
        NSInteger is_default = [subConfig isEqualToString:defauleConfig]?1:0;
        
        NSString *config_id = [NSString stringWithFormat:@"%@_%@",code,subConfig];
        if (!is_default) {
            
            BOOL result1 =    [__db executeUpdate:@"INSERT INTO WorkingConfig(config_id,country,code,flag,website,is_sub,default_configuration,config,is_default,selected)VALUES(?,?,?,?,?,?,?,?,?,?)",config_id,config.configId,code,config.flag,config.website,@(1),config.default_configuration,subConfig,@(is_default),@(0)];
            
        }
        
    }
    
    
}

+ (NSArray *)excuteWorkingdaysconfig {
    
    NSMutableArray *configArray = [NSMutableArray array];
    FMResultSet *set = [__db executeQuery:@"SELECT * FROM WorkingConfig WHERE is_sub = ? ORDER BY country ASC",@(0)];
    
    while ([set next]) {
        
        LSWorkingDayConfig *config = [[LSWorkingDayConfig alloc] init];
        config.code = [set stringForColumn:@"code"];
        config.selected = [set intForColumn:@"selected"];
        config.configId = [set stringForColumn:@"country"];
        config.default_configuration = [set stringForColumn:@"default_configuration"];
        
        NSMutableArray *configs = [NSMutableArray array];
        
        
        LSWorkingDayConfig *defulatConfig = [[LSWorkingDayConfig alloc] init];
        defulatConfig.code  = config.code;
        defulatConfig.selected = config.selected;
        defulatConfig.config = config.default_configuration;
        defulatConfig.is_sub = YES;
        defulatConfig.is_default = YES;
        
        
        [configs addObject:defulatConfig];
        
        FMResultSet *subset = [__db executeQuery:@"SELECT * FROM WorkingConfig WHERE is_sub=? AND code = ?  ORDER BY country ASC",@(1),config.code];
        
       
        
        while ([subset next]) {
            LSWorkingDayConfig *subconfig = [[LSWorkingDayConfig alloc] init];
            subconfig.code = [subset stringForColumn:@"code"];
            subconfig.selected = [subset intForColumn:@"selected"];
            subconfig.config = [subset stringForColumn:@"config"];
            subconfig.is_default = [subset   intForColumn:@"is_default"];
            subconfig.is_sub  =YES;
//            if (!subconfig.is_default) {
//                [configs addObject:subconfig];
//            }
            [configs addObject:subconfig];
        }
        
        config.configs = configs.copy;
        
        
        [configArray addObject:config];
        
        
    }
    
    
    return configArray.copy;
    
}



+ (NSArray *)excuteWorkingdaysconfigSelected:(BOOL)selected {
    
    NSMutableArray *configArray = [NSMutableArray array];
    FMResultSet *set = [__db executeQuery:@"SELECT * FROM WorkingConfig WHERE selected = ? ORDER BY country ASC",selected?@1:@0];
    
    while ([set next]) {
        
        LSWorkingDayConfig *config = [[LSWorkingDayConfig alloc] init];
        config.code = [set stringForColumn:@"code"];
        config.selected = [set intForColumn:@"selected"];
        config.configId = [set stringForColumn:@"country"];
        config.default_configuration = [set stringForColumn:@"default_configuration"];
        config.is_default = [set   intForColumn:@"is_default"];
        config.is_sub = [set intForColumn:@"is_sub"];
        
        config.config = [set stringForColumn:@"config"];
        
        
        [configArray addObject:config];
        
        
    }
    
    
    return configArray.copy;
    
}

    
+ (BOOL)updateWorkingDayConfigWithCongifId:(NSString *)config_id selected:(BOOL)selected
{
    
    BOOL result = [__db executeUpdate:@"UPDATE WorkingConfig SET selected = ? WHERE config_id = ?",selected?@1:@0,config_id];
    
    return result;
    
}




+ (BOOL)addCalendarType:(LSCalendarTypeModel *)model {
    
//    name TEXT,type INTEGER, groupType INTEGER,is_default INTEGER, selected INTEGER
    
    
    BOOL result =    [__db executeUpdate:@"INSERT INTO CalendarConfig(name,type , groupType ,is_default , selected,has_festival )VALUES(?,?,?,?,?,?)",model.lishuname,@(model.type),@(model.groupType),model.is_default?@1:@0,model.selected?@1:@0,model.hasFestival?@1:@0];
    
    return result;
}

+ (BOOL)updateCalendarConfigWithType:(NSInteger)type selected:(BOOL)selected
{
    
    BOOL result = [__db executeUpdate:@"UPDATE CalendarConfig SET selected = ? WHERE type = ?",selected?@1:@0,@(type)];
    
    return result;
    
}


+ (BOOL)updateCalendarGroupWithType:(LSCalendarTypeModel *)model
{
    
    BOOL result = [__db executeUpdate:@"UPDATE CalendarConfig SET groupType = ? WHERE type = ?",@(model.groupType),@(model.type)];
    
    return result;
    
}
    
+ (NSArray *)excuteCaledarConfigArraySelected:(BOOL )selected {
    
    NSMutableArray *configArray = [NSMutableArray array];
    FMResultSet *set = [__db executeQuery:@"SELECT * FROM CalendarConfig WHERE selected = ? ORDER BY type ASC",selected?@1:@0];
    
    while ([set next]) {
        
        LSCalendarTypeModel *config = [[LSCalendarTypeModel alloc] init];
        config.lishuname = [set stringForColumn:@"name"];
        config.selected = [set intForColumn:@"selected"];
        config.groupType = [set intForColumn:@"groupType"];
        config.is_default = [set intForColumn:@"is_default"];
        config.hasFestival = [set intForColumn:@"has_festival"];
        config.type = [set intForColumn:@"type"];
        
      
        
        
        [configArray addObject:config];
        
        
    }
    
    
    return configArray.copy;
    
}

+ (NSArray *)excuteCaledarConfigArrayGrouptype:(NSInteger)groupType {
    
    NSMutableArray *configArray = [NSMutableArray array];
    FMResultSet *set = [__db executeQuery:@"SELECT * FROM CalendarConfig WHERE groupType = ? ORDER BY type ASC",@(groupType)];
    
    while ([set next]) {
        
        LSCalendarTypeModel *config = [[LSCalendarTypeModel alloc] init];
        config.lishuname = [set stringForColumn:@"name"];
        config.selected = [set intForColumn:@"selected"];
        config.groupType = [set intForColumn:@"groupType"];
        config.is_default = [set intForColumn:@"is_default"];
        config.hasFestival  = [set intForColumn:@"has_festival"];
        config.type = [set intForColumn:@"type"];
        
      
        
      
        
        
        [configArray addObject:config];
        
        
    }
    
    
    return configArray.copy;
    
}


+ (NSArray *)excuteCaledarConfigArrayHasFestival {
    
    NSMutableArray *configArray = [NSMutableArray array];
    FMResultSet *set = [__db executeQuery:@"SELECT * FROM CalendarConfig WHERE has_festival = ? ORDER BY groupType ASC",@(1)];
    
    while ([set next]) {
        
        LSCalendarTypeModel *config = [[LSCalendarTypeModel alloc] init];
        config.lishuname = [set stringForColumn:@"name"];
        config.selected = [set intForColumn:@"selected"];
        config.groupType = [set intForColumn:@"groupType"];
        config.is_default = [set intForColumn:@"is_default"];
        config.hasFestival  = [set intForColumn:@"has_festival"];
        config.type = [set intForColumn:@"type"];
        
      
        
      
        
        
        [configArray addObject:config];
        
        
    }
    
    
    return configArray.copy;
    
}

+ (void)vipExpiredResetConfig {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"workingconfig.json" ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSArray *dataArray = [NSJSONSerialization  JSONObjectWithData:data options:kNilOptions error:nil];
    
    
    NSArray *data_configs = [NSArray  yy_modelArrayWithClass:[LSWorkingDayConfig class] json:dataArray ];
    for (LSWorkingDayConfig *config in data_configs) {
//        [LSDataBaseTool addWorkingDayConfig:config];
        
        NSString *defauleConfig = config.default_configuration;
        NSString *code = config.code;
        
        
        [LSDataBaseTool updateWorkingDayConfigWithCongifId:code selected:1];
        
        
            
          
          for (NSString *subConfig in config.configurations) {
              
              NSInteger is_default = [subConfig isEqualToString:defauleConfig]?1:0;
              
              NSString *config_id = [NSString stringWithFormat:@"%@_%@",code,subConfig];
              if (!is_default) {
                  
                  [LSDataBaseTool updateWorkingDayConfigWithCongifId:config_id selected:0];
                 
                  
              }
              
          }
    }
    
    for (int i = 1; i < 19; i++) {
        LSCalendarTypeModel *calendarModel = [[LSCalendarTypeModel alloc] initWithType:(LSCalendarType)i];
//        [LSDataBaseTool addCalendarType:calendarModel];
        [LSDataBaseTool updateCalendarConfigWithType:calendarModel.type selected:calendarModel.selected];
    }
    
//    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"config_store"];
    
    
    
}










@end
