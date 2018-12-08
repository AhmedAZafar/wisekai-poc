//
//  ViewController.m
//  wisekai-poc
//
//  Created by Ahmed Ali Zafar on 21/11/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *instructorButton;
@property (weak, nonatomic) IBOutlet UIButton *learnerButton;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [self setLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}


#pragma mark Helpers
- (void)setLayout {
    self.view.backgroundColor = [UIColor colorWithRed:44.0/255.0 green:23.0/255.0 blue:84.0/255.0 alpha:1.0];
    
    self.instructorButton.layer.cornerRadius = 0.5 * self.instructorButton.bounds.size.width;
    self.instructorButton.clipsToBounds = YES;
    self.instructorButton.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:17.0/255.0 blue:111.0/255.0 alpha:1.0];
    
    self.learnerButton.layer.cornerRadius = 0.5 * self.learnerButton.bounds.size.width;
    self.learnerButton.clipsToBounds = YES;
    self.learnerButton.backgroundColor = [UIColor colorWithRed:44.0/255.0 green:197.0/255.0 blue:207.0/255.0 alpha:1.0];
    
    self.instructorButton.layer.zPosition = 1;
    self.learnerButton.layer.zPosition = 0;
}


@end
