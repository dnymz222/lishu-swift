//
//  LSAstroSectionModel.m
//  lishu
//
//  Created by xueping on 2021/5/30.
//

#import "LSAstroSectionModel.h"
#import "LSPlanet.h"
#import "LSStar.h"
#import "LSConstellation.h"
#import <YYModel/YYModel.h>


@interface LSAstroSectionModel ()


@end

@implementation LSAstroSectionModel

- (instancetype)initWithType:(NSInteger)type {
    self  = [super init];
    
    
    if (self) {
        self.type  = type;
        if (1 == self.type) {
            self.title   =NSLocalizedString(@"planet", nil);
            self.isOpen =  YES;
            NSMutableArray *array = [NSMutableArray array];
            for (int i = 0; i< 8;i++ ) {
                LSPlanet *planet  =[[LSPlanet alloc] initWithType:i];
                [array addObject:planet];
            }
            self.astroArray =  array;
            
        } else if (2 == self.type){
            self.title  =NSLocalizedString(@"constellation", nil);
            self.isOpen = NO;
            NSString *path   =[[NSBundle mainBundle] pathForResource:@"lsconstellation.json" ofType:nil];
            NSData *data  = [[NSData alloc] initWithContentsOfFile:path];
            NSArray *array = [NSJSONSerialization  JSONObjectWithData:data options:kNilOptions error:nil];
            self.astroArray =  [NSArray yy_modelArrayWithClass:[LSConstellation class] json:array];
            
            
        } else {
            self.title  =NSLocalizedString(@"star", nil);
            self.isOpen =  NO;
            NSString *path   =[[NSBundle mainBundle] pathForResource:@"lsstar.json" ofType:nil];
            NSData *data  = [[NSData alloc] initWithContentsOfFile:path];
            NSArray *array = [NSJSONSerialization  JSONObjectWithData:data options:kNilOptions error:nil];
            self.astroArray =  [NSArray yy_modelArrayWithClass:[LSStar class] json:array];
            
            
        }
        
    }
    return self;
}


@end
