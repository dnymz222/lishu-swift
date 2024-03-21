//
//  LSStarMonthViewController.h
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import <UIKit/UIKit.h>
#import "LSStar.h"
#import "LSLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSStarMonthViewController : UIViewController

@property(nonatomic,strong)LSStar *star;
@property(nonatomic,strong)LSLocation *selectLocation;

@end

NS_ASSUME_NONNULL_END
