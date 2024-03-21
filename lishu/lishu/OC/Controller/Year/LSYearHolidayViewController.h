//
//  LSYearHolidayViewController.h
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LSLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSYearHolidayViewController : UIViewController

- (void)configYear:(int)year location:(LSLocation *)location;

@end

NS_ASSUME_NONNULL_END
