//
//  LSAccuFooterView.h
//  lishu
//
//  Created by xueping on 2021/11/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LSAccuFooterViewDelegate <NSObject>

- (void)accuFooterViewTapLink;

@end

@interface LSAccuFooterView : UITableViewHeaderFooterView

@property(nonatomic,weak)id <LSAccuFooterViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
