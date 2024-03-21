//
//  LSPlanetMonthViewController.h
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import <UIKit/UIKit.h>
#import "LSPlanet.h"
#import "LSLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSPlanetMonthViewController : UIViewController

@property(nonatomic,strong)LSPlanet *planet;
@property(nonatomic,strong)LSLocation *selectLocation;

@end

NS_ASSUME_NONNULL_END
