//
//  LSWebpTool.m
//  lishu
//
//  Created by xueping wang on 2024/6/9.
//

#import "LSWebpTool.h"
#import <libwebp/encode.h>
#import <libwebp/decode.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreImage/CoreImage.h>


@implementation LSWebpTool

+ (nullable NSData *)convertImageToWebP:(UIImage *)image quality:(CGFloat)quality {
    // Convert UIImage to CGImageRef
    CGImageRef cgImage = [image CGImage];
    
    // Get image dimensions
    size_t width = CGImageGetWidth(cgImage);
    size_t height = CGImageGetHeight(cgImage);
    // Create a WebP config object
    WebPConfig config;
    WebPConfigInit(&config);
    config.lossless = 0; // Set to 1 for lossless compression
    
    // Encode the image to WebP format
    NSData *webpData;
    WebPMemoryWriter writer;
    WebPMemoryWriterInit(&writer);
    
    CGDataProviderRef provider = CGImageGetDataProvider(cgImage);

    // Get the raw data bytes from the data provider
    CFDataRef data = CGDataProviderCopyData(provider);
    UInt8 *bytes = (UInt8 *)CFDataGetBytePtr(data);
    CFRelease(data);
    
    uint8_t *webp =   WebPEncodeRGBA(bytes, width, height, width * 4, quality, &writer);
    

    
    webpData = [NSData dataWithBytesNoCopy:webp length:writer.size freeWhenDone:YES];;
                    
    
    WebPMemoryWriterClear(&writer);
    
    return webpData;
}

@end
