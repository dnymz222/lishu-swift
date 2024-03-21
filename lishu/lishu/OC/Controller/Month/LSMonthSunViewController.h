//
//  LSMonthSunViewController.h
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import <UIKit/UIKit.h>
#import "LSMonth.h"
#import "LSLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSMonthSunViewController : UIViewController

- (void)configMonth:(LSMonth *)month location:(LSLocation *)location;

@end

NS_ASSUME_NONNULL_END
