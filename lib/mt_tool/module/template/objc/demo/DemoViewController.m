//
//  <%= @prefixed_module %>DemoViewController.m
//  <%= @project %>
//
//  Created by <%= @author %> on <%= @date %>.
//
//


#import "<%= @prefixed_module %>DemoViewController.h"

@interface <%= @prefixed_module %>DemoViewController ()

@end

@implementation <%= @prefixed_module %>DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"----- viewDidLoad -----");
    self.view.backgroundColor = [UIColor colorWithRed:0.3 green:0.4 blue:0.35 alpha:1.0];
    self.navigationItem.title = @"<%= @prefixed_module %>DemoViewController";
}

 

@end
