//
//  LSEraItemModel.h
//  lishu
//
//  Created by xueping on 2021/10/15.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,LSEraType){
    LSEraTypeGregorian=0,
    LSEraTypeChinese,  //农历
    LSEraTypeJapanese, //日本历
    LSEraTypeBuddhist, //泰历
    LSEraTypeIslamic, // 穆斯林
    LSEraTypeHebrew, //希伯来历
    LSEraTypeIndian, //印度
    LSEraTypePersian ,//波斯
    
    
    
    
};

NS_ASSUME_NONNULL_BEGIN

@interface LSEraItemModel : NSObject

@property(nonatomic,assign)NSInteger year;
@property(nonatomic,copy)NSString *yearname;

@property(nonatomic,copy)NSString *signname;

@property(nonatomic,assign)LSEraType type;

- (instancetype)initWithType:(LSEraType)type year:(int)year;

@end

NS_ASSUME_NONNULL_END
