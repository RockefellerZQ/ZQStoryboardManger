//
//  ZQStoryboardManger.h
//  VcTest
//
//  Created by Admin on 13-10-21.
//  Copyright (c) 2013年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZQStoryboardManger : NSObject

+ (ZQStoryboardManger *)sharedStoryboardManger;

- (UIStoryboard *)storyboardWithName:(NSString *)storyboardName bundle:(NSBundle *)bundle;

- (UIViewController *)viewControllerWithIndenifier:(NSString *)indentifier inStoryboardWithName:(NSString *)storyboardName;

- (UIViewController *)viewControllerWithIndenifier:(NSString *)indentifier inStoryboardWithName:(NSString *)storyboardName bundle:(NSBundle *)bundle;

- (UIViewController *)instantiateInitialViewControllerInStoryboard:(NSString *)storyboardName;

- (UIViewController *)instantiateInitialViewControllerInStoryboard:(NSString *)storyboardName bundle:(NSBundle *)bundle;

@end
