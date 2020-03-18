//
//  ViewController.m
//  XTRouter
//
//  Created by teason23 on 2020/3/18.
//  Copyright © 2020 teason23. All rights reserved.
//

#import "ViewController.h"

#import "XTRouter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        
    [XTRouter registerVCFromClass:@"OneViewController"];
    [XTRouter registerVCFromXib:@"TwoViewController"];
    [XTRouter registerVCFromStoryboard:@"ThreeViewController" storyboardName:@"Main"];
    
}

- (IBAction)action1:(id)sender {
    [XTRouter jumpVC:@"OneViewController"
               param:@"{'a':'我是现实来的数据'}"
                 way:(XTRouterSkipWayPush)
         viewDidLoad:^{
        
    }];
}

- (IBAction)action2:(id)sender {
    [XTRouter jumpVC:@"TwoViewController"
               param:nil
                 way:(XTRouterSkipWayPush)
         viewDidLoad:^{
        
    }];
}

- (IBAction)action3:(id)sender {
    [XTRouter jumpVC:@"ThreeViewController"
               param:nil
                 way:(XTRouterSkipWayModal)
         viewDidLoad:^{
        
    }];
}


@end
