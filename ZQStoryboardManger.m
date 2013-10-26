//
//  ZQStoryboardManger.m
//  VcTest
//
//  Created by Admin on 13-10-21.
//  Copyright (c) 2013年 Admin. All rights reserved.
//

#import "ZQStoryboardManger.h"

#define ZQStoryboardNameKey @"storyboard"
#define ZQControllersOfStoryboardKey @"viewControllers"
#define ZQStoryboardInitialViewControllerKey @"initialViewController"

@interface ZQStoryboardManger ()
{
    NSMutableDictionary *storyboardsAndControllers;
}

@end

static ZQStoryboardManger *storyboardManger = nil;
@implementation ZQStoryboardManger

+ (ZQStoryboardManger *)sharedStoryboardManger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (storyboardManger == nil) {
            storyboardManger = [[[self class] alloc] init];
        }
    });
    return storyboardManger;
}

- (id)init
{
    self = [super init];
    if (self) {
        if (!storyboardsAndControllers) {
            storyboardsAndControllers = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

- (UIStoryboard *)storyboardWithName:(NSString *)storyboardName bundle:(NSBundle *)bundle;
{
    NSMutableDictionary *dictionary = [storyboardsAndControllers objectForKey:storyboardName];
    if (dictionary == nil) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    UIStoryboard *storyboard = [dictionary objectForKey:ZQStoryboardNameKey];
    if (!storyboard) {
        storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
        [dictionary setObject:storyboard forKey:ZQStoryboardNameKey];
        [storyboardsAndControllers setObject:dictionary forKey:storyboardName];
    }
    dictionary = nil;
    return storyboard;
}

- (UIViewController *)instantiateInitialViewControllerInStoryboard:(NSString *)storyboardName
{
    return [self instantiateInitialViewControllerInStoryboard:storyboardName bundle:[NSBundle mainBundle]];
}

- (UIViewController *)instantiateInitialViewControllerInStoryboard:(NSString *)storyboardName bundle:(NSBundle *)bundle
{
    NSMutableDictionary *dictionary = [storyboardsAndControllers objectForKey:storyboardName];
    if (dictionary == nil) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    UIStoryboard *storyboard = [dictionary objectForKey:ZQStoryboardNameKey];
    if (!storyboard) {
        storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
        [dictionary setObject:storyboard forKey:ZQStoryboardNameKey];
        [storyboardsAndControllers setObject:dictionary forKey:storyboardName];
    }
    
    UIViewController *viewController = [dictionary objectForKey:ZQStoryboardInitialViewControllerKey];
    if (!viewController) {
        viewController = [storyboard instantiateInitialViewController];
        [dictionary setObject:viewController forKey:ZQStoryboardInitialViewControllerKey];
        [storyboardsAndControllers setObject:dictionary forKey:storyboardName];
    }
    dictionary = nil;
    return viewController;
}

- (UIViewController *)viewControllerWithIndenifier:(NSString *)indentifier inStoryboardWithName:(NSString *)storyboardName
{
    return [self viewControllerWithIndenifier:indentifier inStoryboardWithName:storyboardName bundle:[NSBundle mainBundle]];
}

- (UIViewController *)viewControllerWithIndenifier:(NSString *)indentifier inStoryboardWithName:(NSString *)storyboardName bundle:(NSBundle *)bundle
{
    NSMutableDictionary *dictionary = [storyboardsAndControllers objectForKey:storyboardName];
    if (dictionary == nil) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    UIStoryboard *storyboard = [dictionary objectForKey:ZQStoryboardNameKey];
    if (!storyboard) {
        storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:bundle];
        [dictionary setObject:storyboard forKey:ZQStoryboardNameKey];
        [storyboardsAndControllers setObject:dictionary forKey:storyboardName];
    }
    NSMutableDictionary *viewControllers = [dictionary objectForKey:ZQControllersOfStoryboardKey];
    if (viewControllers == nil) {
        viewControllers = [[NSMutableDictionary alloc] init];
    }
    UIViewController *controller = [viewControllers objectForKey:indentifier];
    if (!controller) {
        controller = [storyboard instantiateViewControllerWithIdentifier:indentifier];
        [viewControllers setObject:controller forKey:indentifier];
        [dictionary setObject:viewControllers forKey:ZQControllersOfStoryboardKey];
        [storyboardsAndControllers setObject:dictionary forKey:storyboardName];
        viewControllers = nil;
    }
    return controller;
}

- (void)dealloc
{
    storyboardsAndControllers = nil;
}


@end
