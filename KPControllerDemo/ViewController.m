//
//  ViewController.m
//  KPControllerDemo
//
//  Created by jason on 14/11/23.
//  Copyright (c) 2014年 heming. All rights reserved.
//

#import "ViewController.h"
#import "DemoView1.h"
#import "DemoView2.h"
#import "DemoSubViewController1.h"
#import "DemoSubViewController2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.demoModel = [[DemoModel alloc] init];
    self.demoModel.status = 0;
    
    CGFloat viewWidth = 160;
    CGFloat viewHeight = 200;
    
    DemoView1 * demoview1 = [[DemoView1 alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
    [self.view addSubview:demoview1];
    
    DemoView2 * demoview2 = [[DemoView2 alloc] initWithFrame:CGRectMake(viewWidth, 0, viewWidth, viewHeight)];
    [self.view addSubview:demoview2];
    
    
    DemoSubViewController1 * vc1 = [[DemoSubViewController1 alloc] init];
    [self addChildViewController:vc1];
    [self.view addSubview:vc1.view];
    vc1.view.frame = CGRectMake(0, viewHeight, viewWidth, viewHeight);
    
    
    DemoSubViewController2 * vc2 = [[DemoSubViewController2 alloc] init];
    [self addChildViewController:vc2];
    [self.view addSubview:vc2.view];
    vc2.view.frame = CGRectMake(viewWidth, viewHeight, viewWidth, viewHeight);
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:NSLocalizedString(@"Change Status", nil) forState:UIControlStateNormal];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button addTarget:self action:@selector(changeStatusAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    NSArray * hLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)];
    NSArray * vLayout = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-450-[button]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)];
    [self.view addConstraints:hLayout];
    [self.view addConstraints:vLayout];
}

- (void)changeStatusAction:(id)sender
{
    srand((unsigned)time(0));
    int i = rand() % 4;
    self.demoModel.status = i;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
