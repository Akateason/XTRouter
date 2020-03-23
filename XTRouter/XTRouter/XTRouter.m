//
//  XTRouter.m
//  XTBase
//
//  Created by teason23 on 2020/3/18.
//  Copyright © 2020 teason23. All rights reserved.
//

#import "XTRouter.h"
#import <XTFMDB/XTFMDB.h>
#import <XTBase/XTBase.h>
#import <objc/message.h>
#import <objc/runtime.h>


@interface XTRouter ()
@property (nonatomic, strong) NSString *pathForPlist;
@end


@implementation XTRouter

+ (void)registerVCFromClass:(NSString *)vcName
                     mapped:(NSString *)mappedKey {
    XTRouterRec *rec = [[XTRouterRec alloc] initWithVCName:vcName key:mappedKey mode:XTRouterLaunchModeFromClass storyName:nil];
    [rec xt_insertOrIgnore];
}

+ (void)registerVCFromClass:(NSString *)vcName {
    [self registerVCFromClass:vcName mapped:nil];
}

+ (void)registerVCFromXib:(NSString *)vcName
                   mapped:(NSString *)mappedKey {
    XTRouterRec *rec = [[XTRouterRec alloc] initWithVCName:vcName key:mappedKey mode:XTRouterLaunchModeFromXib storyName:nil];
    [rec xt_insertOrIgnore];
}

+ (void)registerVCFromXib:(NSString *)vcName {
    [self registerVCFromXib:vcName mapped:nil];
}

+ (void)registerVCFromStoryboard:(NSString *)vcName
                  storyboardName:(NSString *)storyboardName
                          mapped:(NSString *)mappedKey {
    XTRouterRec *rec = [[XTRouterRec alloc] initWithVCName:vcName key:mappedKey mode:XTRouterLaunchModeFromStoryboard storyName:storyboardName];
    [rec xt_insertOrIgnore];
}

+ (void)registerVCFromStoryboard:(NSString *)vcName
                storyboardName:(NSString *)storyboardName {
    [self registerVCFromStoryboard:vcName storyboardName:storyboardName mapped:nil];
}



+ (void)jumpVC:(NSString *)mappedKey
         param:(NSString *)jsonString
           way:(XTRouterSkipWay)way
   viewDidLoad:(void(^)(void))viewDidLoadCallback {
        
    XTRouterRec *rec = [XTRouterRec xt_findFirstWhere:XT_STR_FORMAT(@"key == '%@'",mappedKey)];
    
    UIViewController *vc = nil;
    Class cls = NSClassFromString(rec.vcName);
    
    switch (rec.launchMode) {
        case XTRouterLaunchModeFromClass: {
            SEL func = NSSelectorFromString(@"new");
            vc = ((id (*)(id, SEL, id))objc_msgSend)(cls, func, nil);
        }
            break;
        case XTRouterLaunchModeFromXib: {
            SEL func = NSSelectorFromString(@"getCtrllerFromNIB");
            vc = ((id (*)(id, SEL, id))objc_msgSend)(cls, func, nil);
        }
            break;
        case XTRouterLaunchModeFromStoryboard: {
            SEL func = NSSelectorFromString(@"getCtrllerFromStory:controllerIdentifier:");
            vc = ((id (*)(id, SEL, id, id))objc_msgSend)(cls, func, rec.storyboardName, rec.vcName);
        }
            break;
        default:
            break;
    }
        
    vc.xt_param_jsonStr = jsonString;
    
    [[[vc rac_signalForSelector:@selector(viewDidLoad)] takeUntil:vc.rac_willDeallocSignal]
     subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"🦌🏊‍♀️ (%@) %@ : DidLoad ", rec.key,rec.vcName);
        if (viewDidLoadCallback) viewDidLoadCallback();
    }];
        
    switch (way) {
        case XTRouterSkipWayPush: [[UIViewController xt_topViewController].navigationController pushViewController:vc animated:YES]; break;
        case XTRouterSkipWayModal: [[UIViewController xt_topViewController] presentViewController:vc animated:YES completion:nil]; break;
        default: break;
    }
}


- (BOOL)backTo:(NSString *)mappedKey {
    XTRouterRec *rec = [XTRouterRec xt_findFirstWhere:XT_STR_FORMAT(@"key == '%@'",mappedKey)];
    UINavigationController *currentNavVC = [UIViewController xt_topViewController].navigationController;
    if (currentNavVC) {
        for (UIViewController *aVC in currentNavVC.viewControllers) {
            if ([aVC.className isEqualToString:rec.vcName]) {
                [currentNavVC popToViewController:aVC animated:YES];
                NSLog(@"backTo (%@) VC Success",mappedKey);
                return YES;
            }
        }
        NSLog(@"backTo VC Faild: Wrong VC Key (%@)",mappedKey);
        return NO;
    } else {
        NSLog(@"backTo VC Faild: rootVC is not a UINavigationController !");
        return NO;
    }
}

@end











@implementation XTRouterRec

- (instancetype)initWithVCName:(NSString *)name
                           key:(NSString *)key
                          mode:(XTRouterLaunchMode)mode
                     storyName:(NSString *_Nullable)storyName {
    self = [super init];
    if (self) {
        _vcName = name;
        _key = key ?: name;
        _launchMode = (int)mode;
        _storyboardName = storyName?:@"Main";
    }
    return self;
}

+ (NSDictionary *)modelPropertiesSqliteKeywords {
    return @{
        @"vcName" : @"unique",
    };
}

@end
