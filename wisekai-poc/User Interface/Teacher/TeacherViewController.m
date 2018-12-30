//
//  TeacherViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 24/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "TeacherViewController.h"
#import "UIColor+Wisekai.h"

#import "APICalls.h"

@interface TeacherViewController ()

{
    NSMutableArray * lessonsArray;
}

@end

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    [self setNavBar];
    
    [self getLessonDataFromAPI];
}

#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
}

- (void)setNavBar {
    
    self.navigationItem.title = @"Lessons";
    
    //Set Font
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:17.0],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    //Set Color
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor wiseKaiOrangeColor],NSForegroundColorAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    //Set Back Button
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar-add"] style:UIBarButtonItemStylePlain target:self action:@selector(segueToAddLesson)];
    
    rightButton.tintColor = [UIColor wiseKaiDarkGrayColor];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    
}

- (void)setupTable {
}

#pragma mark - API

- (void)getLessonDataFromAPI {
    [APICalls getLessons:^(NSData * _Nonnull responseData) {
        
        NSError * readError;
        
        NSDictionary * responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&readError];
        
        NSLog(@"Response Dictionary for Lessons : %@", responseDict);
        
    }];
}

#pragma mark - TableViewDelegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return lessonsArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


#pragma mark - Navigation

- (void)segueToAddLesson {
    [self performSegueWithIdentifier:@"addlesson" sender:nil];
}

@end
