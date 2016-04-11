//
//  MartinCustomLabel.h
//  身份证信息
//
//  Created by 苏秋东 on 16/4/11.
//  Copyright © 2016年 com.hyde.carelink. All rights reserved.
//

#import<Foundation/Foundation.h>
#import<UIKit/UIKit.h>

@interface MartinCustomLabel : UILabel
{
@private
    CGFloat characterSpacing_;       //字间距
    long    linesSpacing_;           //行间距
}
@property(nonatomic,assign) CGFloat characterSpacing;
@property(nonatomic,assign) long    linesSpacing;

/*
 *绘制前获取label高度
 */
- (int)getAttributedStringHeightWidthValue:(int)width;

@end