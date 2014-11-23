//
//  KPObserverObject.m
//  KPControllerDemo
//
//  Created by jason on 14/11/23.
//  Copyright (c) 2014年 heming. All rights reserved.
//

#import "KPObserverObject.h"

@implementation KPObserverObject

- (instancetype)initWithKeyPath:(NSString*)keyPath
                         target:(id)target
                       selector:(SEL)selector
{
    self = [super init];
    if (self) {
        self.target = target;
        self.keyPath = keyPath;
        self.selector = selector;
    }
    
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[KPObserverObject class]]) {
        return NO;
    }
    
    KPObserverObject * observer = (KPObserverObject *)object;
    
    if ([[observer keyPath] isEqualToString:[self keyPath]]
        && [observer target] == [self target]
        && [observer selector] == [self selector]) {
        return YES;
    }
    
    return NO;
}

@end
