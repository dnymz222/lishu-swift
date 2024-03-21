//
//  LSUinitTool.h
//  lishu
//
//  Created by xueping on 2021/10/14.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSUinitTool : NSObject

+ (NSString *)temperatureFormFahrenheit:(double)F isMertic:(BOOL)isMetric;

+ (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
