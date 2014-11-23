//
//  KPObserverObject.h
//  KPControllerDemo
//
//  Created by jason on 14/11/23.
//  Copyright (c) 2014年 heming. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KPObserverProtocol <NSObject>

@optional
- (NSArray *)getKPObserversArray;

@end

@interface KPObserverObject : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic) SEL selector;
@property (nonatomic, copy) NSString* keyPath;

- (instancetype)initWithKeyPath:(NSString*)keyPath
                         target:(id)target
                       selector:(SEL)selector;

@end
