//
//  UtilsMacro.h
//  XQJSOCInterface
//
//  Created by LaiXuefei on 2017/3/22.
//  Copyright © 2017年 lxf. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h


#endif /* UtilsMacro_h */


#pragma mark - 方法定义

#ifdef DEBUG
#define DLog(...) NSLog(__VA_ARGS__)
#define dMethod() NSLog(@"%s", __func__)
#else
#define DLog(...)
#define dMethod()
#endif

/*
 *  弱引用&强引用
 */
#define WEAK_SELF_OBJ(obj)   __weak __typeof(obj) weakSelf = obj;
#define STRONG_SELF_OBJ(obj)  __strong __typeof(obj) strongSelf = obj; if (!strongSelf) {DLog(@">>>>> strongSelf = nil >>>>>");return ;}


#define INJECT_JS  @"window.EasyJS = {\
call: function (obj, functionName, args){\
var formattedArgs = [];\
for (var i = 0, l = args.length; i < l; i++){\
if (typeof args[i] == \"function\"){\
formattedArgs.push(\"f\");\
var cbID = \"__cb\" + (+new Date);\
EasyJS.__callbacks[cbID] = args[i];\
formattedArgs.push(cbID);\
}else{\
formattedArgs.push(\"s\");\
formattedArgs.push(encodeURIComponent(args[i]));\
}\
}\
\
var argStr = (formattedArgs.length > 0 ? \":\" + encodeURIComponent(formattedArgs.join(\":\")) : \"\");\
\
var iframe = document.createElement(\"IFRAME\");\
iframe.setAttribute(\"src\", \"easy-js:\" + obj + \":\" + encodeURIComponent(functionName) + argStr);\
document.documentElement.appendChild(iframe);\
iframe.parentNode.removeChild(iframe);\
iframe = null;\
\
var ret = EasyJS.retValue;\
EasyJS.retValue = undefined;\
\
if (ret){\
return decodeURIComponent(ret);\
}\
},\
\
inject: function (obj, methods){\
window[obj] = {};\
var jsObj = window[obj];\
\
for (var i = 0, l = methods.length; i < l; i++){\
(function (){\
var method = methods[i];\
var jsMethod = method.replace(new RegExp(\":\", \"g\"), \"\");\
jsObj[jsMethod] = function (){\
return EasyJS.call(obj, method, Array.prototype.slice.call(arguments));\
};\
})();\
}\
}\
};"

#pragma mark - Str定义
#define INTERFACE_NAME  @"native"
#define NOTIF_JSCONTEXT_CHANGED     @"XQJSContextChanged"
