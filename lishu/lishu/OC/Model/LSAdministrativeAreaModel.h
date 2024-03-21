//
//  LSAdministrativeAreaModel.h
//  lishu
//
//  Created by xueping on 2021/4/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSAdministrativeAreaModel : NSObject

@property(nonatomic,copy)NSString *LocalizedType;
@property(nonatomic,copy)NSString *EnglishType;
@property(nonatomic,copy)NSString *CountryID;
@property(nonatomic,assign)NSInteger Level;
@property(nonatomic,copy)NSString *LocalizedName;
@property(nonatomic,copy)NSString *EnglishName;
@property(nonatomic,copy)NSString *ID;

@end

NS_ASSUME_NONNULL_END
