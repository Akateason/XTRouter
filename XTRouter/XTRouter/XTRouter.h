//
//  XTRouter.h
//  XTBase
//
//  Created by teason23 on 2020/3/18.
//  Copyright © 2020 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XTBase/FastCodeHeader.h>
#import "UIViewController+XTRouter.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XTRouterLaunchMode) {
    XTRouterLaunchModeFromClass,
    XTRouterLaunchModeFromXib,
    XTRouterLaunchModeFromStoryboard,
};

typedef NS_ENUM(NSUInteger, XTRouterSkipWay) {
    XTRouterSkipWayPush,
    XTRouterSkipWayModal,
};

@interface XTRouter : NSObject
/// Register from class
+ (void)registerVCFromClass:(NSString *)vcName;
/// Register from Xib. (xibname == className)
+ (void)registerVCFromXib:(NSString *)vcName;
/// Register from Storyboard
/// @param vcName               vc ClassName
/// @param storyboardName       name of storyboard   e.g. @"Main"
+ (void)registerVCFromStoryboard:(NSString *)vcName
                  storyboardName:(NSString *)storyboardName;


/// Jump to VC ~!
/// @param vcKey                VC class Name .
/// @param jsonString           a JSon String from Server or web .
/// @param way                  a VC Present way .
/// @param viewDidLoadCallback  callback when view did load .
+ (void)jumpVC:(NSString *)vcKey
         param:(NSString *_Nullable)jsonString
           way:(XTRouterSkipWay)way
   viewDidLoad:(void(^_Nullable)(void))viewDidLoadCallback ;

@end











@interface XTRouterRec : NSObject

@property (copy, nonatomic) NSString            *name;
@property (nonatomic)       int                 launchMode;  //XTRouterLaunchMode
@property (copy, nonatomic) NSString            *storyboardName;

- (instancetype)initWithVCName:(NSString *)name
                          mode:(XTRouterLaunchMode)mode
                     storyName:(NSString *_Nullable)storyName ;

@end

NS_ASSUME_NONNULL_END
