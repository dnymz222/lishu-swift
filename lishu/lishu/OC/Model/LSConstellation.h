//
//  LSConstellation.h
//  lishu
//
//  Created by xueping on 2021/5/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSConstellation : NSObject

@property(nonatomic,copy)NSString *shortname;
@property(nonatomic,copy)NSString *englishName;
//@property(nonatomic,copy)NSString *chinesename;
//@property(nonatomic,copy)NSString *japanesename;
@property(nonatomic,copy)NSString *latinname;
@property(nonatomic,copy)NSString *nasashortname;
@property(nonatomic,copy)NSString *RightAscension;
@property(nonatomic,copy)NSString *Declination;
@property(nonatomic,copy)NSString *size;
@property(nonatomic,copy)NSString *quadrant;
@property(nonatomic,copy)NSString *family;
@property(nonatomic,copy)NSString *englishLink;

@property(nonatomic,assign)double RA;
@property(nonatomic,assign)double Dec;

- (void)calculateRaAndDec;

@end

NS_ASSUME_NONNULL_END
