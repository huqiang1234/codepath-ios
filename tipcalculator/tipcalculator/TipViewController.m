//
//  TipViewController.m
//  tipcalculator
//
//  Created by Charlie Hu on 1/7/15.
//  Copyright (c) 2015 Charlie Hu. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;
- (void)initTipDefaults;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  if (self) {
    self.title = @"Charlie's Tip Calculator";
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
  [self initTipDefaults];
  [self updateValues];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
  NSLog(@"view did appear");
  [self updateValues];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTap:(id)sender {
  [self.view endEditing:YES];
  [self updateValues];
}

- (void)updateValues {
  float billAmount = [self.billTextField.text floatValue];

  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSArray *tipPercentageDefaults = [defaults objectForKey:@"defaultTipPercentage"];

  for (int indexSegments=0; indexSegments<=2; indexSegments++)
    [self.tipControl setTitle:[tipPercentageDefaults[indexSegments] stringValue] forSegmentAtIndex:indexSegments];

  float tipAmount = billAmount * [tipPercentageDefaults[self.tipControl.selectedSegmentIndex] floatValue] / 100;
  float totalAmount = billAmount + tipAmount;

  self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
  self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
  [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)initTipDefaults {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[NSArray arrayWithObjects:@(10), @(15), @(20), nil] forKey:@"defaultTipPercentage"];
  [defaults synchronize];
}

@end
