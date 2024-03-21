//
//  LSStar.h
//  lishu
//
//  Created by xueping on 2021/5/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSStar : NSObject

@property(nonatomic,copy)NSString *EnglishName;
@property(nonatomic,copy)NSString *ShortName;
@property(nonatomic,copy)NSString *ConsetellationName;
@property(nonatomic,assign)double Magnitude ;
@property(nonatomic,copy)NSString *AbsoluteMagnitude;
@property(nonatomic,copy)NSString *SpectralType;
@property(nonatomic,copy)NSString *RightAscension;
@property(nonatomic,copy)NSString *Declination;
//@property(nonatomic,copy)NSString *L;
@property(nonatomic,copy)NSString *EnglishLink;
@property(nonatomic,copy)NSString *Distance;
//@property(nonatomic,copy)NSString *JapaneseName;
//@property(nonatomic,copy)NSString *ChineseName;

@property(nonatomic,assign)double RA;
@property(nonatomic,assign)double Dec;

- (void)calculateRaAndDec;

@end

NS_ASSUME_NONNULL_END
