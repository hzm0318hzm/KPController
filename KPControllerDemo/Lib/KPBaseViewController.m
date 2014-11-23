//
//  KPBaseViewController.m
//  KPControllerDemo
//
//  Created by jason on 14/11/23.
//  Copyright (c) 2014年 heming. All rights reserved.
//

#import "KPBaseViewController.h"

@interface KPBaseViewController () {
    NSMutableArray * keyPathObjectsArray_;
    NSArray * observersArray_;
}

@end

@implementation KPBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.observerParentViewController = YES;
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self addKPObservers];
}

- (void)dealloc
{
    [self removeKPObservers];
    [self removeAllObservers_];
}

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - add observer key path methods -
//////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    [super addObserver:observer forKeyPath:keyPath options:options context:context];
    
    NSDictionary * observerDic = @{@"observer": observer, @"keypath": keyPath};
    [keyPathObjectsArray_ addObject:observerDic];
}

- (void)removeAllObservers_
{
    for (NSDictionary * observerDic in keyPathObjectsArray_) {
        NSObject * object = [observerDic objectForKey:@"observer"];
        NSString * keyPath = [observerDic objectForKey:@"keypath"];
        [self removeObserver:object forKeyPath:keyPath];
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - observer key path methods -
/////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == (__bridge void *)(self)) {
        for (KPObserverObject * observerObj in observersArray_) {
            if ([observerObj.keyPath isEqualToString:keyPath]) {
                id strongTarget = observerObj.target;
                if ([strongTarget respondsToSelector:observerObj.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    [strongTarget performSelector:observerObj.selector];
#pragma clang diagnostic pop
                }
            }
        }
    }
}

- (UIViewController *)firstViewController
{
    if (self.observerParentViewController) {
        return [self parentViewController];
    } else {
        return self;
    }
}

- (void)addKPObservers
{
    if ([self respondsToSelector:@selector(getKPObserversArray)]) {
        NSArray * observers = [self getKPObserversArray];
        
        if (observers != nil && observers.count > 0) {
            observersArray_ = observers;
            for (KPObserverObject * observer in observers) {
                [[self firstViewController] addObserver:self forKeyPath:observer.keyPath options:0 context:(__bridge void *)(self)];
            }
        }
    }
}

- (void)removeKPObservers
{
    for (KPObserverObject * observerObj in observersArray_) {
        [[self firstViewController] removeObserver:self forKeyPath:observerObj.keyPath];
    }
}

@end
