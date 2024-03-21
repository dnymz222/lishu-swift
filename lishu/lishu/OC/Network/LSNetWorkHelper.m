//
//  LSNetWorkHelper.m
//  lishu
//
//  Created by xueping on 2021/3/18.
//

#import "LSNetWorkHelper.h"
#import <UIKit/UIKit.h>


@interface LSNetWorkHelper ()<NSURLSessionDelegate>

@end

@implementation LSNetWorkHelper

+ (instancetype)shareInstance {
    
    static  LSNetWorkHelper *network ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[LSNetWorkHelper alloc] init];
    });
    
    return network;
    
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
        config.requestCachePolicy =  NSURLRequestUseProtocolCachePolicy;
        
        _session  = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
//        NSDateFormatter *datefomter = [[NSDateFormatter alloc] init];
//        [datefomter setDateFormat:@"yyyy-MM-dd"];
//        _dateString = [datefomter stringFromDate:[NSDate date]];
//
        _sourceVersion =[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
        
//        _sysVersion = [@"iOS" stringByAppendingString:[UIDevice currentDevice].systemVersion];
        
    
    }
    
    return self;
    
}


- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    
    
    // 如果使用默认的处置方式，那么 credential 就会被忽略
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod
         isEqualToString:
         NSURLAuthenticationMethodServerTrust]) {
        
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
        }
        
    }
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
    
}




+ (NSInteger)cacluteTotalWithLat:(NSString *)latitude lon:(NSString *)longtitude time:(NSInteger)timstamp {
    
    NSInteger a1 =(NSInteger) ([latitude floatValue] *100 * [longtitude floatValue] *100);
    
    NSInteger a2 = (NSInteger)(pow(fabs([latitude floatValue]), 2.71828) + pow(fabs([longtitude floatValue]), 3.14159));
    NSInteger a3 = (NSInteger)(pow(timstamp, 0.68619));
    NSInteger total = a3 + a1 + a2 + arc4random() % 10;
    
    return total;
}



@end
