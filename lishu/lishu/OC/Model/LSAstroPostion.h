//
//  LSAstroPostion.h
//  lishu
//
//  Created by xueping on 2021/3/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSAstroPostion : NSObject

@property(nonatomic,assign)double Height;
@property(nonatomic,assign)double Azimuth;


@property(nonatomic,assign)double RiseAzimuth;
@property(nonatomic,assign)double SetAzimuth;

@property(nonatomic,assign)double fixAzimuth;


@property(nonatomic,assign)BOOL isAbove;//永昼
@property(nonatomic,assign)BOOL isBelow;//永夜



- (instancetype)initWithHeight:(double)height azimuth:(double)azimuth;


- (void)calculateDec:(double)dec latitude:(double)latitude;

@end

NS_ASSUME_NONNULL_END
