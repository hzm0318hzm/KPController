//
//  KPBaseViewController.h
//  KPControllerDemo
//
//  Created by jason on 14/11/23.
//  Copyright (c) 2014年 heming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPObserverObject.h"

@interface KPBaseViewController : UIViewController <KPObserverProtocol>

@property (nonatomic, assign) BOOL observerParentViewController;

@end
