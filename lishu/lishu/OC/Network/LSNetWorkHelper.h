//
//  LSNetWorkHelper.h
//  lishu
//
//  Created by xueping on 2021/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSNetWorkHelper : NSObject

@property(nonatomic,strong,readonly)NSURLSession *session;

//@property(nonatomic,copy)NSString *dateString;

@property(nonatomic,copy)NSString *sourceVersion;
//
//@property(nonatomic,copy)NSString *sysVersion;

+ (instancetype)shareInstance;


+ (NSInteger)cacluteTotalWithLat:(NSString *)latitude lon:(NSString *)longtitude time:(NSInteger)timstamp ;

@end

NS_ASSUME_NONNULL_END
