//
//  LSAstroSectionModel.h
//  lishu
//
//  Created by xueping on 2021/5/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSAstroSectionModel : NSObject

@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)BOOL isOpen;
@property(nonatomic,assign)NSInteger type;

@property(nonatomic,copy)NSArray *astroArray;

- (instancetype)initWithType:(NSInteger)type; //1.行星 2.星座 3.行星



@end

NS_ASSUME_NONNULL_END
