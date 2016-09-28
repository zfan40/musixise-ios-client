//
//  MYDubugLog.h
//  Pods
//
//  Created by wmy on 16/6/3.
//
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/DDLog.h>

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DDLog.h"
#import <CocoaLumberjack/DDTTYLogger.h>
#import <CocoaLumberjack/DDASLLogger.h>
#endif

#ifdef DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_WARN;
#endif


#if defined (DEBUG) || defined(MONKEY)
#   define DebugLog(fmt, ...) DDLogInfo((@" 💚 %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DebugLog(...)
#endif
#if defined (DEBUG) || defined(MONKEY)
#   define DebugMusicLog(fmt, ...) DDLogInfo((@" 💚 核心音乐引擎 %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DebugMusicLog(...)
#endif

#if defined (DEBUG) || defined(MONKEY)
#   define DebugMessageLog(moduleName,fmt, ...) DDLogInfo((@" 💚 " moduleName " %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DebugMessageLog(...)
#endif


#if defined (DEBUG) || defined(MONKEY)
#   define InfoLog(fmt, ...) DDLogInfo((@" 💙 %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define InfoLog(...) 
#endif

#if defined (DEBUG) || defined(MONKEY)
#   define WarnLog(fmt, ...) DDLogWarn((@" 💛 %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define WarnLog(...) 
#endif

#if defined (DEBUG) || defined(MONKEY)
#   define ErrorLog(fmt, ...) DDLogError((@" ❤️ %s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define ErrorLog(...)
#endif
