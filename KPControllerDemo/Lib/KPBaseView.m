//
//  KPBaseView.m
//  KPControllerDemo
//
//  Created by jason on 14/11/23.
//  Copyright (c) 2014年 heming. All rights reserved.
//

#import "KPBaseView.h"


/////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - KPBaseView -
/////////////////////////////////////////////////////////////////////////////////////////////////////////

// Thanks to Phil M
// http://stackoverflow.com/questions/1340434/get-to-uiviewcontroller-from-uiview-on-iphone

@interface UIView (KPFindUIViewController)

- (UIViewController *)firstAvailableUIViewController;
- (id)traverseResponderChainForUIViewController;

@end

@implementation UIView (KPFindUIViewController)

- (id)firstAvailableUIViewController {
    // convenience function for casting and to "mask" the recursive function
    return [self traverseResponderChainForUIViewController];
}

- (id)traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}

@end

/////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - KPBaseView -
/////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface KPBaseView () {
    NSArray * observersArray_;
}

@end

@implementation KPBaseView

@synthesize firstViewController = firstViewController_;

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    if (self.superview != nil) {
        [self addKPObservers];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview == nil) {
        [self removeKPObservers];
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
    if (firstViewController_ == nil) {
        firstViewController_ = [self firstAvailableUIViewController];
    }
    
    return firstViewController_;
}

- (void)setFirstViewController:(UIViewController *)firstViewController
{
    firstViewController_ = firstViewController;
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
