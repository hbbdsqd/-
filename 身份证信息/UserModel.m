//
//  UserModel.m
//  身份证信息
//
//  Created by 苏秋东 on 16/4/1.
//  Copyright © 2016年 com.hyde.carelink. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (NSString*)description
{
    return [NSString stringWithFormat:@"状态码：%@\n地址：%@\n生日：%@\n证件号：%@\n描述：%@\n姓名：%@\n国籍：%@\n性别：%@\n图片%@", _httpStatusCode, _addr, _birthday, _idNo, _detail, _name, _nation, _sex, _photo];
}

@end
