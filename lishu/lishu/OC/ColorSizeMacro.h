//
//  ColorSizeMacro.h
//  lishu
//
//  Created by xueping on 2021/2/28.
//

#ifndef ColorSizeMacro_h
#define ColorSizeMacro_h


#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define KIsiPhoneX ({\
    BOOL isBangsScreen = NO; \
    if (@available(iOS 11.0, *)) { \
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
    isBangsScreen = window.safeAreaInsets.bottom > 0; \
    } \
    isBangsScreen; \
})



#define kScreenHeight    [[UIScreen mainScreen]bounds].size.height

#define kScreenWidth     [[UIScreen mainScreen]bounds].size.width


#define Themecolor 0xf2f2e2

#define navColor 0xf8f8e6

#define ViewBackGroundColor 0xeeeedd


#define TextHeaderColor 0xcccccc

#define TextHighLightColor 0xbbbbbb

#define TextLightColor  0xaaaaaa


#define TextFadeColor 0x999999

#define TextDarkColor 0x222222


#define TextNormalColor 0x666666

#define TextblackColor 0x111111

#define TextSelectColor 0x338eff


#define cellbackGroundColor 0xe6e6c6



#endif /* ColorSizeMacro_h */
