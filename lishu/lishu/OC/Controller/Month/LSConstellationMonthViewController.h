//
//  LSConstellationMonthViewController.h
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import <UIKit/UIKit.h>
#import "LSConstellation.h"
#import "LSLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSConstellationMonthViewController : UIViewController

@property(nonatomic,strong)LSConstellation *constellation;
@property(nonatomic,strong)LSLocation *selectLocation;

@end

NS_ASSUME_NONNULL_END
