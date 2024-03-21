//
//  LSEclipseModel.h
//  lishu
//
//  Created by efc on 2021/9/24.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSEclipseModel : NSObject

@property(nonatomic,strong)NSMutableArray *solarArray;
@property(nonatomic,strong)NSMutableArray *lunarArray;

@property(nonatomic,assign)int year;



@property(nonatomic,copy)NSString *timeZone;

@property(nonatomic,assign)double startJD;
@property(nonatomic,assign)double endJD;

- (instancetype)initWithYear:(int)year timeZone:(NSString *)timeZone;


@end

NS_ASSUME_NONNULL_END
