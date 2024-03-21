//
//  LSStarListViewController.h
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import <UIKit/UIKit.h>
#import "LSStar.h"
#import "LSLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSStarListViewController : UIViewController

@property(nonatomic,strong)LSLocation *location;
@property(nonatomic,strong)LSStar *star;

@end

NS_ASSUME_NONNULL_END
