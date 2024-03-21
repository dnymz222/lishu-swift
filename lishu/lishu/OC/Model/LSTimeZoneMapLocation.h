//
//  LSTimeZoneMapLocation.h
//  lishu
//
//  Created by xueping on 2021/3/8.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


//2004x1195

//纬度为0: 691

NS_ASSUME_NONNULL_BEGIN

@interface LSTimeZoneMapLocation : NSObject

@property(nonatomic,assign)double x;//像素
@property(nonatomic,assign)double y;//单位像素




@property(nonatomic,strong)CLLocation *location;


- (instancetype)initWithX:(double)x Y:(double)y;

- (instancetype)initWithLocation:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
