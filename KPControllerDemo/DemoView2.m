//
//  DemoView2.m
//  KPControllerDemo
//
//  Created by jason on 14/11/23.
//  Copyright (c) 2014年 heming. All rights reserved.
//

#import "DemoView2.h"
#import "ViewController.h"

@interface DemoView2 () {
    NSArray * colorsArray_;
}

@end


@implementation DemoView2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        colorsArray_ = @[[UIColor grayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor]];
        self.backgroundColor = colorsArray_[0];
    }
    
    return self;
}


- (NSArray *)getKPObserversArray
{
    KPObserverObject * obj = [[KPObserverObject alloc] initWithKeyPath:@"demoModel.status" target:self selector:@selector(observerStatus)];
    return @[obj];
}


- (void)observerStatus
{
    if ([self.firstViewController isKindOfClass:[ViewController class]]) {
        ViewController * vc = (ViewController *)self.firstViewController;
        if (vc.demoModel.status >= 0 && vc.demoModel.status < colorsArray_.count - 1) {
            self.backgroundColor = colorsArray_[vc.demoModel.status];
            NSLog(@"--%s--status--: %ld", __FUNCTION__, vc.demoModel.status);
        }
    }
}

@end
