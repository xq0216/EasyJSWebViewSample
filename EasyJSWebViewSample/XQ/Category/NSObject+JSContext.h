//
//  NSObject+JSContext.h
//  TruckManager
//
//  Created by LaiXuefei on 2017/3/20.
//  Copyright © 2017年 XQ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class JSContext;

@interface NSObject(JSContext)
- (void)webView:(id)webView didCreateJavaScriptContext:(JSContext *)context forFrame:(id)frame;

@end
