//
//  KPBaseView.h
//  KPControllerDemo
//
//  Created by jason on 14/11/23.
//  Copyright (c) 2014年 heming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPObserverObject.h"

@interface KPBaseView : UIView <KPObserverProtocol> {
    
}

@property (nonatomic, weak) UIViewController * firstViewController;

@end
