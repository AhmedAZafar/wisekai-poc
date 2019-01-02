//
//  TeacherViewController.m
//  wisekai-poc
//
//  Created by Ahmed on 24/12/2018.
//  Copyright © 2018 Ahmed Ali Zafar. All rights reserved.
//

#import "TeacherViewController.h"
#import "UIColor+Wisekai.h"
#import "UIView+Wisekai.h"
#import "UIImageView+WiseKai.h"
#import "Cells/TeacherLessonCell.h"

#import "APICalls.h"

@interface TeacherViewController ()

@end

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLayout];
    [self setNavBar];
    [self setToolbar];
    
    [self getLessonDataFromAPI];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.alpha = 1.0;
    
    self.activityIndicatorView.alpha = 0.0;
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.teacherTableView.delegate = self;
    self.teacherTableView.dataSource = self;
    
    self.view.alpha = 0.5;
    
    self.activityIndicatorView.alpha = 1.0;
    
    [self.activityIndicatorView startAnimating];
    
    [self getLessonDataFromAPI];
    
}

#pragma mark - Helpers

- (void)setLayout {
    
    self.view.backgroundColor = [UIColor wiseKaiCreamColor];
    
    //self.activityIndicatorView.alpha = 0.0;
}

- (void)setNavBar {
    
    self.navigationItem.title = @"Lessons";
    
    //Set Font
    NSDictionary *size = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial" size:17.0],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = size;
    
    //Set Color
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor wiseKaiRedColor],NSForegroundColorAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    
    //Set Add Button
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar-add"] style:UIBarButtonItemStylePlain target:self action:@selector(segueToAddLesson)];
    
    rightButton.tintColor = [UIColor wiseKaiDarkGrayColor];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    
}

- (void)setToolbar {
    
    /*
     //Set up Search Icon
     UITapGestureRecognizer * searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectSearchIcon)];
     
     UIView * searchView = [UIView getNavBarIconView];
     
     [searchView addGestureRecognizer:searchTap];
     
     [searchView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-search"]];
     
     UIBarButtonItem * searchBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchView];
     
     
     //Set up Like Icon
     UITapGestureRecognizer * likeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectLikeIcon)];
     
     UIView * likeView = [UIView getNavBarIconView];
     
     [likeView addGestureRecognizer:likeTap];
     
     [likeView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-like"]];
     
     UIBarButtonItem * likeBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:likeView];
     */
    //Set up Calendar Icon
    UITapGestureRecognizer * calendarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectCalendarIcon)];
    
    UIView * calendarView = [UIView getNavBarIconView];
    
    [calendarView addGestureRecognizer:calendarTap];
    
    UIImageView * currentTab = [UIImageView getTeacherToolbarImageViewForIcon:@"toolbar-calendar"];
    
    currentTab.tintColor = [UIColor wiseKaiRedColor];
    
    [calendarView addSubview:currentTab];
    
    UIBarButtonItem * calendarBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:calendarView];
    
    
    //Set up Notification Icon
    UITapGestureRecognizer * notificationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segueToNotifications)];
    
    UIView * notificationView = [UIView getNavBarIconView];
    
    [notificationView addGestureRecognizer:notificationTap];
    
    [notificationView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-alert"]];
    
    UIBarButtonItem * notificationBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:notificationView];
    
    
    
    //Set up User Icon
    UITapGestureRecognizer * userTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(segueToProfile)];
    
    UIView * userView = [UIView getNavBarIconView];
    
    [userView addGestureRecognizer:userTap];
    
    [userView addSubview:[UIImageView getNavBarImageViewForIcon:@"toolbar-user"]];
    
    UIBarButtonItem * userBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:userView];
    
    UIBarButtonItem * flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //self.bottomToolbar.items = @[searchBarButtonItem, flexibleSpace,likeBarButtonItem,flexibleSpace, calendarBarButtonItem,flexibleSpace, notificationBarButtonItem,flexibleSpace, userBarButtonItem];
    
    self.teacherToolbar.items = @[calendarBarButtonItem, flexibleSpace, notificationBarButtonItem, flexibleSpace, userBarButtonItem];
    
}

- (void)setupTable {
}

#pragma mark - API

- (void)getLessonDataFromAPI {
    [APICalls getLessons:^(NSData * _Nonnull responseData) {
        
        NSLog(@"Got something for lesson list of teachers");
        
        [self.activityIndicatorView stopAnimating];
        
        self.activityIndicatorView.alpha = 0.0;
        
        self.view.alpha = 1.0;
        
        NSError * responseReadError;
        NSArray * responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&responseReadError];
        
        NSLog(@"Response array for lessons for teacher %@", responseDict);
        
        
        
        self.lessonListArray = [NSArray arrayWithArray:responseDict];
        
        [self.teacherTableView reloadData];
        
    }];
}

#pragma mark - TableViewDelegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TeacherLessonCell * lessonTVC = [self.teacherTableView dequeueReusableCellWithIdentifier:@"lessoncell"];
    
    if (!lessonTVC) {
        [self.teacherTableView registerNib:[UINib nibWithNibName:@"TeacherLessonCell" bundle:nil] forCellReuseIdentifier:@"lessoncell"];
        lessonTVC = [self.teacherTableView dequeueReusableCellWithIdentifier:@"lessoncell"];
    }
    
    NSDictionary * currentLesson = [self.lessonListArray objectAtIndex:indexPath.row];
    
    lessonTVC.lessonName.text = currentLesson[@"title"];
    lessonTVC.lessonDescription.text = currentLesson[@"objective"];
    lessonTVC.lessonPrice.text = [NSString stringWithFormat:@"AED %@",currentLesson[@"price"]];
    
    lessonTVC.lessonImage.layer.cornerRadius = lessonTVC.lessonImage.frame.size.height / 2;
    lessonTVC.lessonImage.clipsToBounds = YES;
    
    if ((indexPath.row % 2) == 0) {
        lessonTVC.backgroundColor = [UIColor wiseKaiCreamColor];
    } else {
        lessonTVC.backgroundColor = [UIColor wiseKaiBlueColor];
    }
    
    lessonTVC.backgroundColor = [UIColor wiseKaiCreamColor];
    //lessonTVC.lessonImageView.image = [[UIImage imageNamed:[lessonImageArray objectAtIndex:indexPath.row]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //lessonTVC.lessonImageView.tintColor = [UIColor whiteColor];
    
    return lessonTVC;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lessonListArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

- (void)segueToAddLesson {
    [self performSegueWithIdentifier:@"addlesson" sender:nil];
}

- (void)segueToNotifications {
    [self performSegueWithIdentifier:@"showalerts" sender:nil];
}

- (void)segueToProfile {
    [self performSegueWithIdentifier:@"showteacherprofile" sender:nil];
}

@end
