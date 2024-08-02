//
//  LSWebpTool.h
//  lishu
//
//  Created by xueping wang on 2024/6/9.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSWebpTool : NSObject

+  (nullable NSData *)convertImageToWebP:(UIImage *)image quality:(CGFloat)quality;

@end

NS_ASSUME_NONNULL_END
