//
//  LSNetWork.h
//  lishu
//
//  Created by xueping on 2021/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



typedef void(^LSSuccessBlock)(NSURLResponse *response ,id data);

typedef void(^LSFailedBlock)(NSError *error);


@interface LSNetWork : NSObject


+ (void)sendGetRequestWithPath:(NSString*)path
                    paramater:(NSDictionary*)paramaters
                      success:(LSSuccessBlock)successBlock
                       failed:(LSFailedBlock)failedBlock;


@end

NS_ASSUME_NONNULL_END
