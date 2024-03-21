//
//  LSConstellationListViewController.h
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import <UIKit/UIKit.h>
#import "LSConstellation.h"
#import "LSLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSConstellationListViewController : UIViewController

@property(nonatomic,strong)LSConstellation *constellation;
@property(nonatomic,strong)LSLocation *location;

@end

NS_ASSUME_NONNULL_END
