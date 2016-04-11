//
//  UIImage+QD.m
//  身份证信息
//
//  Created by 苏秋东 on 16/4/5.
//  Copyright © 2016年 com.hyde.carelink. All rights reserved.
//

#import "UIImage+QD.h"

@implementation UIImage (QD)

/**
 *  @brief  取图片某一点的颜色
 *
 *  @param point 某一点
 *
 *  @return 颜色
 */
- (CGFloat)colorAtPoint:(CGPoint)point
{
    if (point.x < 0 || point.y < 0)
        return 0;

    CGImageRef imageRef = self.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    if (point.x >= width || point.y >= height)
        return 0;

    unsigned char* rawData = malloc(height * width * 4);
    if (!rawData)
        return 0;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData,
        width,
        height,
        bitsPerComponent,
        bytesPerRow,
        colorSpace,
        kCGImageAlphaPremultipliedLast
            | kCGBitmapByteOrder32Big);
    if (!context) {
        free(rawData);
        return 0;
    }
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);

    int byteIndex = (bytesPerRow * point.y) + point.x * bytesPerPixel;
    CGFloat red = (rawData[byteIndex] * 1.0);
    CGFloat green = (rawData[byteIndex + 1] * 1.0);
    CGFloat blue = (rawData[byteIndex + 2] * 1.0);
    CGFloat alpha = (rawData[byteIndex + 3] * 1.0);
    NSLog(@"%f%f%f", red, green, blue);
    return [self RGBtoH:red g:green b:blue];
}

- (CGFloat)RGBtoH:(CGFloat)r g:(CGFloat)g b:(CGFloat)b
{
    CGFloat l;
    CGFloat s;
    CGFloat h;
    CGFloat v;
    CGFloat m;
    CGFloat vm;
    CGFloat r2, g2, b2;

    //    r /= 255;
    //    g /= 255;
    //    b /= 255;

    v = MAX(r, g);
    v = MAX(v, b);
    m = MIN(r, g);
    m = MIN(m, b);

    NSLog(@"%f---------%f", v, m);

    if ((l = (m + v) / 2.0) <= 0.0) {
        NSLog(@"=======%f", (l = (m + v) / 2.0));
        return 0;
    }
    if ((s = vm = v - m) > 0.0) {
        s /= (l <= 0.5) ? (v + m) : (2.0 - v - m);
    }
    else {
        return 0;
    }

    r2 = (v - r) / vm;
    g2 = (v - g) / vm;
    b2 = (v - b) / vm;

    if (r == v)
        h = (g == m ? 5.0 + b2 : 1.0 - g2);
    else if (g == v)
        h = (b == m ? 1.0 + r2 : 3.0 - b2);
    else
        h = (r == m ? 3.0 + g2 : 5.0 - r2);

    h /= 6;

    NSLog(@"h:%f", h);

    return h;
}

//颜色替换

- (UIImage*)imageToTransparent:(UIImage*)image

{

    // 分配内存

    const int imageWidth = image.size.width;

    const int imageHeight = image.size.height;

    size_t bytesPerRow = imageWidth * 4;

    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);

    // 创建context

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,

        kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);

    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);

    // 遍历像素

    int pixelNum = imageWidth * imageHeight;

    uint32_t* pCurPtr = rgbImageBuf;

    double base = 0.0;

    for (int i = 0; i < pixelNum; i++, pCurPtr++)

    {
        if (i == 0) {
            base = (*pCurPtr & 0x65815A00);
        }

        if ( (*pCurPtr & 0x65815A00) > base - 5000000) // 将背景变成透明

        {
            uint8_t* ptr = (uint8_t*)pCurPtr;

            ptr[0] = 0;
        }
        //
        //        else if ((*pCurPtr & 0x00FF0000) == 0x00ff0000)    // 将绿色变成黑色
        //
        //        {
        //
        //            uint8_t* ptr = (uint8_t*)pCurPtr;
        //
        //            ptr[3] = 0; //0~255
        //
        //            ptr[2] = 0;
        //
        //            ptr[1] = 0;
        //
        //        }

        //        else if ((*pCurPtr & 0xFFFFFF00) == 0xffffff00)    // 将白色变成透明
        //
        //        {
        //
        //            uint8_t* ptr = (uint8_t*)pCurPtr;
        //
        //            ptr[0] = 0;
        //
        //        }

        //        else
        //
        //        {
        //            // 改成下面的代码，会将图片转成想要的颜色
        //
        //            uint8_t* ptr = (uint8_t*)pCurPtr;
        //
        //            ptr[3] = 0; //0~255
        //
        //            ptr[2] = 0;
        //
        //            ptr[1] = 0;
        //
        //        }
    }

    // 将内存转成image

    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);

    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,

        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,

        NULL, true, kCGRenderingIntentDefault);

    CGDataProviderRelease(dataProvider);

    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];

    // 释放

    CGImageRelease(imageRef);

    CGContextRelease(context);

    CGColorSpaceRelease(colorSpace);

    // free(rgbImageBuf) 创建dataProvider时已提供释放函数，这里不用free

    return resultUIImage;
}

/** 颜色变化 */

void ProviderReleaseData(void* info, const void* data, size_t size)

{
    free((void*)data);
}

@end
