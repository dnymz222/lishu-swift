//
//  LSSolarTermModel.h
//  lishu
//
//  Created by xueping on 2021/9/22.
//

#import <Foundation/Foundation.h>
#import "LSDate.h"
//#import "LSSolarTermItemModel.h"

#import "LSSolarTermItemModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface LSSolarTermModel : NSObject

@property(nonatomic,assign)int year;



@property(nonatomic,copy)NSString *timeZone;

@property(nonatomic,assign)double startJD;
@property(nonatomic,assign)double endJD;

@property(nonatomic,assign)double startLong;
@property(nonatomic,assign)double endLong;

@property(nonatomic,strong)NSMutableArray *solarTermsArray;




- (instancetype)initWithYear:(int)year timeZone:(NSString *)timeZone;


- (void)calculateSolarTermWithHemisType:(NSInteger)hemisType;






@end

NS_ASSUME_NONNULL_END
