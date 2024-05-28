//
//  LSNetWork.m
//  lishu
//
//  Created by xueping on 2021/3/18.
//

#import "LSNetWork.h"
#import "LSNetWorkHelper.h"



#if DEBUG
//#define URLrootpath @"http://127.0.0.1:5000/api/v2.0"
#define URLrootpath @"https://www.xunquan.shop/api/v3.0"
#else
#define URLrootpath @"https://www.xunquan.shop/api/v3.0"

#endif

@implementation LSNetWork

+ (void)sendGetRequestWithPath:(NSString*)path
                     paramater:(NSDictionary*)paramaters
                       success:(LSSuccessBlock)successBlock
                        failed:(LSFailedBlock)failedBlock
{
    
    NSString *urlString = [LSNetWork transferGetUrlWithpath:path paramaters:paramaters];
#if DEBUG
    NSLog(@"urlstring:%@",urlString);
#endif
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    });
    
    
    NSURL *url  = [NSURL  URLWithString:urlString];
    
    __block  __strong  NSMutableURLRequest *request =  [NSMutableURLRequest requestWithURL:url];
    
#if DEBUG
    request.timeoutInterval = 30;
#else
    request.timeoutInterval = 30;
#endif
    
    
    NSURLSession *session = [LSNetWorkHelper shareInstance].session;
    
    __block NSURLSessionDataTask *task  = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//             [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//        });
       
        
        if (error) {
            failedBlock(error);
            
        }else{
            
            NSDictionary   *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil ];
            
            if (dict) {
                
                NSInteger code = [[dict valueForKey:@"code"] integerValue];
                if (code == 200) {
                    
                    id data = [dict valueForKey:@"data"];
                    
                    successBlock(response,data);
                    
                }else {
                    
                    
                    NSError *error = [NSError errorWithDomain:@"error" code:20001 userInfo:dict];
                    failedBlock(error);
                    
                }
                
               
                
            }else {
                
#if DEBUG
                NSLog(@"error:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
#endif
                
                NSDictionary *dict = @{NSLocalizedDescriptionKey:@"no data"};
                NSError *error = [NSError errorWithDomain:@"error" code:20002 userInfo:dict];
                failedBlock(error);
            }
            
            
            
        }
        
        
    }];
    
    [task resume];
    
    
    
    
}






+ (NSString*)transferGetUrlWithpath:(NSString*)path paramaters:(NSDictionary*)paramaters {
    
    
    NSString *urlString = [URLrootpath stringByAppendingString:path];
    urlString = [urlString stringByAppendingString:@"?"];
    
    if (paramaters) {
        
        NSArray *allkeys = [paramaters allKeys];
        
        for (NSString *key in allkeys) {
            
            NSString *value = [NSString stringWithFormat:@"%@",[paramaters valueForKey:key]];
            
            NSString *keyvalue = [NSString stringWithFormat:@"%@=%@&",key,value ];
            
            urlString  =[urlString stringByAppendingString:keyvalue];
        }
    }
    
    
    
    
   urlString  = [urlString stringByAppendingString:[NSString stringWithFormat:@"appVersion=%@&source=%@&os=iOS",[LSNetWorkHelper shareInstance].sourceVersion,@"lishu"]];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^@,{}\"[]|\\<> "].invertedSet];
    
    return urlString;
    
    
    
    
}


@end
