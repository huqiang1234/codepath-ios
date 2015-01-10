//
//  SettingsViewController.m
//  tipcalculator
//
//  Created by Charlie Hu on 1/10/15.
//  Copyright (c) 2015 Charlie Hu. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *defaultTipPercentageText1;
@property (weak, nonatomic) IBOutlet UITextField *defaultTipPercentageText2;
@property (weak, nonatomic) IBOutlet UITextField *defaultTipPercentageText3;

- (void)updateValues;
- (void)saveDefaults;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self updateValues];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
  [self saveDefaults];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)updateValues {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSArray *tipPercentageDefaults = [defaults objectForKey:@"defaultTipPercentage"];
  self.defaultTipPercentageText1.text = [NSString stringWithFormat:@"%d", [tipPercentageDefaults[0] intValue]];
  self.defaultTipPercentageText2.text = [NSString stringWithFormat:@"%d", [tipPercentageDefaults[1] intValue]];
  self.defaultTipPercentageText3.text = [NSString stringWithFormat:@"%d", [tipPercentageDefaults[2] intValue]];
}

- (void)saveDefaults {
  float defaultTipPercentage1 = [self.defaultTipPercentageText1.text floatValue];
  float defaultTipPercentage2 = [self.defaultTipPercentageText2.text floatValue];
  float defaultTipPercentage3 = [self.defaultTipPercentageText3.text floatValue];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[NSArray arrayWithObjects:@(defaultTipPercentage1), @(defaultTipPercentage2), @(defaultTipPercentage3), nil] forKey:@"defaultTipPercentage"];
  [defaults synchronize];
}

@end
