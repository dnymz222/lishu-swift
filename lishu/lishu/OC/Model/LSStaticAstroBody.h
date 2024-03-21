//
//  LSStaticAstroBody.h
//  lishu
//
//  Created by xueping on 2021/3/13.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LSRiseSetTime.h"
#import "LSGeoPosition.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSStaticAstroBody : NSObject

@property(nonatomic,assign)double RA;
@property(nonatomic,assign)double Dec;

@property(nonatomic,strong)LSRiseSetTime *riseSetTime;

- (instancetype)initWithRA:(double)RA dec:(double)Dec;

- (LSRiseSetTime *)calculaterisesetWithZeroJd:(double)zerojd location:(LSGeoPosition *)location;

@end

NS_ASSUME_NONNULL_END
