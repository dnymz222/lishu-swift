//
//  LSWorkingDayConfig.h
//  lishu
//
//  Created by xueping on 2021/9/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSWorkingDayConfig : NSObject


@property(nonatomic,copy)NSString*  website;//: "https://argentina.workingdays.org/setup.php",
@property(nonatomic,copy)NSString*  code;//: "AR",
@property(nonatomic,copy)NSString*  default_configuration;//: "",
@property(nonatomic,copy)NSString*  flag;//: "",
@property(nonatomic,copy)NSString*  configId;//: "Argentina",
@property(nonatomic,copy)NSArray* configurations;//: "[]"



@property(nonatomic,assign)BOOL is_default;

@property(nonatomic,copy)NSArray *configs;
@property(nonatomic,copy)NSString *config;
@property(nonatomic,assign)BOOL selected;

@property(nonatomic,assign)BOOL is_show;
@property(nonatomic,assign)BOOL is_sub;

@end

NS_ASSUME_NONNULL_END
