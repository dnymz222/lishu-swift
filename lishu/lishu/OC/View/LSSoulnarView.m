//
//  LSSoulnarView.m
//  lishu
//
//  Created by xueping on 2021/4/4.
//

#import "LSSoulnarView.h"
#import <Masonry/Masonry.h>

@interface LSSoulnarView ()

@property(nonatomic,strong)UIImageView *beoverView;
@property(nonatomic,strong)UIImageView *belowView;

@property(nonatomic,strong)UIImageView *sunIconView;
@property(nonatomic,strong)UIImageView *moonIconView;

@end

@implementation LSSoulnarView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self   =[super initWithFrame:frame];
    if (self) {
        
        
        [self addSubview:self.beoverView];
        [self addSubview:self.belowView];
        
        [self addSubview:self.sunIconView];
        [self addSubview:self.moonIconView];
        
        [self.belowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(8);
            make.right.equalTo(self).offset(-8);
            make.bottom.equalTo(self).offset(-8);
            
            make.top.equalTo(self.mas_centerY);
        }];
        
        [self.beoverView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(8);
            make.right.equalTo(self).offset(-8);
            make.top.equalTo(self).offset(8);
            make.bottom.equalTo(self.mas_centerY);
        }];
        
//        [self.sunIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.mas_centerX).offset(-25);
//            make.centerY.equalTo(self.mas_centerY).offset(0);
//            make.width.equalTo(@16);
//            make.height.equalTo(@16);
//        }];
//
//
//        [self.moonIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.mas_centerX).offset(25);
//            make.centerY.equalTo(self.mas_centerY).offset(0);
//            make.width.equalTo(@16);
//            make.height.equalTo(@16);
//        }];
        
        
        
        
        
        
        
    }
    
    return self;
}

- (UIImageView *)belowView {
    if (!_belowView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"below"];
        [imageview setImage:image];
        _belowView =  imageview;
    }
    return _belowView;
}

- (UIImageView *)beoverView {
    if (!_beoverView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"beover"];
        [imageview setImage:image];
        _beoverView =  imageview;
    }
    return _beoverView;
}

- (UIImageView *)sunIconView {
    if (!_sunIconView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"sun"];
        [imageview setImage:image];
        _sunIconView =  imageview;
    }
    return _sunIconView ;
}

- (UIImageView *)moonIconView {
    if (!_moonIconView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"yueliang"];
        [imageview setImage:image];
        _moonIconView =  imageview;
    }
    return _moonIconView;
}

- (void)configSolunarWithSunPosition:(LSAstroPostion *)sunPosition moonPosition:(LSAstroPostion *)moonPostion  {
    
    if (sunPosition.isAbove) {
        
    } else if (sunPosition.isBelow){
        
    } else {
        double sunAzimuth  = sunPosition.fixAzimuth;
        CGFloat sunoffsetx  = -25*sin(sunAzimuth/180.0*M_PI);
    //    if (sunoffsetx -0 < -0.001) {
    //        sunoffsetx = 0;
    //    }
        CGFloat sunoffsety = 25*cos(sunAzimuth/180.0*M_PI);
    //    if (sunoffsety-0 < -0.001) {
    //        sunoffsety  = 0;
    //    }
        
        
    //
        [self.sunIconView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(sunoffsetx);
            make.centerY.equalTo(self.mas_centerY).offset(sunoffsety);
            make.width.equalTo(@16);
            make.height.equalTo(@16);
        }];
    }
    
    
    if (moonPostion.isAbove) {
        
    } else if (moonPostion.isBelow){
        
    }else {
        
        double moonAzimuth  =  moonPostion.fixAzimuth;
        
        CGFloat moonoffsetx  = -25*sin(moonAzimuth/180.0*M_PI);
    //    if (moonoffsetx -0 < -0.001) {
    //        moonoffsetx =  0;
    //    }
        CGFloat moonoffsety = 25*cos(moonAzimuth/180.0*M_PI);
    //    if (moonoffsety -0 < -0.001) {
    //        moonoffsety =  0;
    //    }
        
    //    self.sunIconView .frame  = CGRectMake(30+sunoffsetx-8, 30+sunoffsety-8, 16, 16);
        
    //    self.moonIconView.frame  =CGRectMake(30+moonoffsetx-8, 30+moonoffsety-8, 16, 16);
    //
        
        [self.moonIconView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(moonoffsetx);
            make.centerY.equalTo(self.mas_centerY).offset(moonoffsety);
            make.width.equalTo(@16);
            make.height.equalTo(@16);
        }];
        
    }
    
    
   
    
   
//
    
    
    
    
    
}













/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
