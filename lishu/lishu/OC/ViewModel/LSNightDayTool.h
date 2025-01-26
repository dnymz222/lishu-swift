//
//  LSNightDayTool.h
//  lishu
//
//  Created by xueping wang on 2025/1/26.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSNightDayTool : NSObject

- (instancetype)initWihDate:(NSDate *)date;

- ( UIImage*)generateImage:(int)scale;

@end

NS_ASSUME_NONNULL_END
