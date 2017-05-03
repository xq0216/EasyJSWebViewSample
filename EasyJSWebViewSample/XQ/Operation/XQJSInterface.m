//
//  XQJSInterface.m
//  XQJSOCInterface
//
//  Created by LaiXuefei on 2017/3/22.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import "XQJSInterface.h"

@implementation XQJSInterface

- (void)jsCallOC{
    DLog(@"JS Call OC : 无参无返回");
}


- (NSString *)jsCallOCWithParam:(NSString *)aStr{
    DLog(@"JS Call OC : 有参数为 %@", aStr);

    NSString *result = @"我是 OC 的返回";
    return result;
}

@end
