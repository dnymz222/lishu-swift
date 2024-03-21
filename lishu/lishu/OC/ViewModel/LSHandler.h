//
//  LSHandler.h
//  lishu
//
//  Created by xueping on 2021/3/30.
//

#import <Foundation/Foundation.h>
#import "LSLocation.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol LSHandlerDelegate <NSObject>

- (void)selectHandlerTableViewSelectLocation:(LSLocation *)location;

@end


@interface LSHandler : NSObject

//@property(nonatomic,strong)LSLocation *currentLocation;
@property(nonatomic,strong,nullable)LSLocation *selectLocation;

@property(nonatomic,copy)NSArray *locationArray;

@property(nonatomic,strong)UITableView *tableView;


//+ (LSHandler *)shareHandler;


- (void)reloadData ;

- (void)reloadSelectData;


@property(nonatomic,weak)id <LSHandlerDelegate>delegate;





@end

NS_ASSUME_NONNULL_END
