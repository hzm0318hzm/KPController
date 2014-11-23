//
//  DemoSubViewController1.m
//  KPControllerDemo
//
//  Created by jason on 14/11/23.
//  Copyright (c) 2014年 heming. All rights reserved.
//

#import "DemoSubViewController1.h"
#import "ViewController.h"

@interface DemoSubViewController1 () {
     NSArray * colorsArray_;
}

@end

@implementation DemoSubViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    colorsArray_ = @[[UIColor blueColor], [UIColor grayColor], [UIColor redColor], [UIColor greenColor]];
    self.view.backgroundColor = colorsArray_[0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)getKPObserversArray
{
    KPObserverObject * obj = [[KPObserverObject alloc] initWithKeyPath:@"demoModel.status" target:self selector:@selector(observerStatus)];
    return @[obj];
}

- (void)observerStatus
{
    if ([self.parentViewController isKindOfClass:[ViewController class]]) {
        ViewController * vc = (ViewController *)self.parentViewController;
        if (vc.demoModel.status >= 0 && vc.demoModel.status < colorsArray_.count - 1) {
            self.view.backgroundColor = colorsArray_[vc.demoModel.status];
            NSLog(@"--%s--status--: %ld", __FUNCTION__, vc.demoModel.status);
        }
    }
}
@end
