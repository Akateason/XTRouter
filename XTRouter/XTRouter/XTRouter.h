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
#pragma mark - register
/// Register from class
+ (void)registerVCFromClass:(NSString *)vcName
                     mapped:(NSString *_Nullable)mappedKey;
+ (void)registerVCFromClass:(NSString *)vcName;


/// Register from Xib. (xibname == className)
+ (void)registerVCFromXib:(NSString *)vcName
                   mapped:(NSString *_Nullable)mappedKey;
+ (void)registerVCFromXib:(NSString *)vcName;


/// Register from Storyboard
/// @param vcName               vc ClassName
/// @param storyboardName       name of storyboard   e.g. @"Main"
+ (void)registerVCFromStoryboard:(NSString *)vcName
                  storyboardName:(NSString *)storyboardName
                          mapped:(NSString *_Nullable)mappedKey;
+ (void)registerVCFromStoryboard:(NSString *)vcName
                  storyboardName:(NSString *)storyboardName;


#pragma mark - router
/// Jump to VC ~!
/// @param mappedKey                VC class Name .
/// @param jsonString           a JSon String from Server or web .
/// @param way                  a VC Present way .
/// @param viewDidLoadCallback  callback when view did load .
+ (void)jumpVC:(NSString *)mappedKey
         param:(NSString *_Nullable)jsonString
           way:(XTRouterSkipWay)way
   viewDidLoad:(void(^_Nullable)(void))viewDidLoadCallback ;


/// Jump Back to VC~~
/// @param mappedKey                VC class Name .
/// @return success or failed
- (BOOL)backTo:(NSString *)mappedKey ;

@end











@interface XTRouterRec : NSObject
///ClassName of ViewController , Unique
@property (copy, nonatomic) NSString            *vcName;

///map key, for Router
@property (copy, nonatomic) NSString            *key;

///XTRouterLaunchMode
@property (nonatomic)       int                 launchMode;

///Storyboard Name if needed
@property (copy, nonatomic, nullable) NSString  *storyboardName;

- (instancetype)initWithVCName:(NSString *)name
                           key:(NSString *)key
                          mode:(XTRouterLaunchMode)mode
                     storyName:(NSString *_Nullable)storyName ;
@end

NS_ASSUME_NONNULL_END
