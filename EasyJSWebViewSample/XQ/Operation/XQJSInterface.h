//
//  XQJSInterface.h
//  XQJSOCInterface
//
//  Created by LaiXuefei on 2017/3/22.
//  Copyright © 2017年 lxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XQJSInterface : NSObject

- (void)jsCallOC;

- (NSString *)jsCallOCWithParam:(NSString *)aStr;

@end
