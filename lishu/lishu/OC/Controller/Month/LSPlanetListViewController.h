//
//  LSPlanetListViewController.h
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import <UIKit/UIKit.h>
#import "LSPlanet.h"
#import "LSLocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface LSPlanetListViewController : UIViewController
@property(nonatomic,strong)LSPlanet *planet;
@property(nonatomic,strong)LSLocation *location;

@end

NS_ASSUME_NONNULL_END
