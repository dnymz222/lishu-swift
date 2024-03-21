//
//  LSPlanet.h
//  lishu
//
//  Created by xueping on 2021/3/13.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LSGeoPosition.h"
#import "LSRiseSetTime.h"


typedef NS_ENUM(NSInteger,LSPlanetType) {
    LSPlanetTypeMecury =0,
    LSPlanetTypeVenus,
    LSPlanetTypeMars,
    LSPlanetTypeJupiter,
    LSPlanetTypeSaturn,
    
    LSPlanetTypeUranus,
    LSPlanetTypeNeptune,
    LSPlanetTypePluto,
    
};

NS_ASSUME_NONNULL_BEGIN

@interface LSPlanet : NSObject

@property(nonatomic,assign)double riseJD;
@property(nonatomic,assign)double setJD;
@property(nonatomic,assign)double transitJD;
@property(nonatomic,assign)BOOL nextDay;
@property(nonatomic,assign)BOOL nextTransitDay;


@property(nonatomic,assign)LSPlanetType type;
@property(nonatomic,copy)NSString *name;
//@property(nonatomic,copy)NSString *imageName;


@property(nonatomic,strong)CLLocation *location;

@property(nonatomic,strong)NSDate  *date;


- (instancetype)initWithType:(LSPlanetType)type;

- (LSRiseSetTime *)calculateRiseTransitSetWithZeroJD:(double)zerojd location:(LSGeoPosition *)location ;

@end

NS_ASSUME_NONNULL_END
