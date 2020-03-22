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

+ (void)registerVCFromClass:(NSString *)vcName {
    XTRouterRec *rec = [[XTRouterRec alloc] initWithVCName:vcName mode:XTRouterLaunchModeFromClass storyName:nil];
    [rec xt_insertOrIgnore];
}

+ (void)registerVCFromXib:(NSString *)vcName {
    XTRouterRec *rec = [[XTRouterRec alloc] initWithVCName:vcName mode:XTRouterLaunchModeFromXib storyName:nil];
    [rec xt_insertOrIgnore];
}

+ (void)registerVCFromStoryboard:(NSString *)vcName
                storyboardName:(NSString *)storyboardName {
    XTRouterRec *rec = [[XTRouterRec alloc] initWithVCName:vcName mode:XTRouterLaunchModeFromStoryboard storyName:storyboardName];
    [rec xt_insertOrIgnore];
}

+ (void)jumpVC:(NSString *)vcKey
         param:(NSString *)jsonString
           way:(XTRouterSkipWay)way
   viewDidLoad:(void(^)(void))viewDidLoadCallback {
        
    XTRouterRec *rec = [XTRouterRec xt_findFirstWhere:XT_STR_FORMAT(@"name == '%@'",vcKey)];
    
    UIViewController *vc = nil;
    Class cls = NSClassFromString(rec.name);
    
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
            vc = ((id (*)(id, SEL, id, id))objc_msgSend)(cls, func, rec.storyboardName, rec.name);
        }
            break;
        default:
            break;
    }
        
    vc.xt_param_jsonStr = jsonString;
    
    [[vc rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"🦌🏊‍♀️ %@ : DidLoad ", [rec yy_modelToJSONString]);
        if (viewDidLoadCallback) viewDidLoadCallback();
    }];
        
    switch (way) {
        case XTRouterSkipWayPush: [[UIViewController xt_topViewController].navigationController pushViewController:vc animated:YES]; break;
        case XTRouterSkipWayModal: [[UIViewController xt_topViewController] presentViewController:vc animated:YES completion:nil]; break;
        default: break;
    }
}


- (BOOL)backTo:(NSString *)vcKey {
    XTRouterRec *rec = [XTRouterRec xt_findFirstWhere:XT_STR_FORMAT(@"name == '%@'",vcKey)];
    UINavigationController *currentNavVC = [UIViewController xt_topViewController].navigationController;
    if (currentNavVC) {
        for (UIViewController *aVC in currentNavVC.viewControllers) {
            if ([aVC.className isEqualToString:rec.name]) {
                [currentNavVC popToViewController:aVC animated:YES];
                NSLog(@"backTo (%@) VC Success",vcKey);
                return YES;
            }
        }
        NSLog(@"backTo VC Faild: Wrong VC Key (%@)",vcKey);
        return NO;
    } else {
        NSLog(@"backTo VC Faild: rootVC is not a UINavigationController !");
        return NO;
    }
}

@end











@implementation XTRouterRec

- (instancetype)initWithVCName:(NSString *)name
                          mode:(XTRouterLaunchMode)mode
                     storyName:(NSString *)storyName
{
    self = [super init];
    if (self) {
        _name = name;
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
