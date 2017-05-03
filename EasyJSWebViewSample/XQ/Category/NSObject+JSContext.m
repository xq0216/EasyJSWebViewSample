//
//  NSObject+JSContext.m
//  TruckManager
//
//  Created by LaiXuefei on 2017/3/20.
//  Copyright © 2017年 XQ. All rights reserved.
//

#import "NSObject+JSContext.h"

@implementation NSObject(JSContext)
- (void)webView:(id)webView didCreateJavaScriptContext:(JSContext *)context forFrame:(id)frame{
    DLog(@"didCreateJavaScriptContext");
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIF_JSCONTEXT_CHANGED object:context];
}
@end
