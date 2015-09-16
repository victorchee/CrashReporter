//
//  ViewController.m
//  CrashReporter
//
//  Created by qihaijun on 9/16/15.
//  Copyright (c) 2015 VictorChee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)crash:(UIButton *)sender {
    NSArray *array = @[@1];
    NSLog(@"%@", array[1]);
}

@end
