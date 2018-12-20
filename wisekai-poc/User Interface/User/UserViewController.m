//
//  UserViewController.m
//  wisekai-poc
//
//  Created by Ahmed Ali Zafar on 19/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "UserViewController.h"
#import "UIColor+Wisekai.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
}

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    NSData * userImageData = [userDefaults objectForKey:@"user-image-data"];
    self.userImageView.image = [UIImage imageWithData:userImageData];
    
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2;
    self.userImageView.clipsToBounds = YES;
    
    self.userName.text = [NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"user-name"]];
    
    self.userDescription.userInteractionEnabled = NO;
    [self.userDescription setEditable:NO];
    self.userDescription.backgroundColor = [UIColor clearColor];
    
    self.userName.textColor = [UIColor wiseKaiDarkGrayColor];
    self.userEmail.textColor = [UIColor wiseKaiDarkGrayColor];
    self.userRegion.textColor = [UIColor wiseKaiDarkGrayColor];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
