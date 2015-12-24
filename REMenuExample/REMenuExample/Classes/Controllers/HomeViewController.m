//
//  HomeViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "HomeViewController.h"
#import "ExploreViewController.h"
#import "ActivityViewController.h"
#import "ProfileViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    self.title = @"Home";
    [super viewDidLoad];
    
    
    // Here self.navigationController is an instance of NavigationViewController (which is a root controller for the main window)
    //
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleMenu)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"Balloon"];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    // Demo label to show current controller class
    //
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    label.text = NSStringFromClass(self.class);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:21];
    label.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:label];
    
    
///////////////////////////////////////////////////////
////////////Old way of initializing the menu///////////
///////////////////////////////////////////////////////
///
//    __typeof (self) __weak weakSelf = self;
//    
//    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"Home"
//                                                    subtitle:@"Return to Home Screen"
//                                                       image:[UIImage imageNamed:@"Icon_Home"]
//                                            highlightedImage:nil
//                                                      action:^(REMenuItem *item) {
//                                                          NSLog(@"Item: %@", item);
//                                                          HomeViewController *controller = [[HomeViewController alloc] init];
//                                                          [weakSelf.navigationController setViewControllers:@[controller] animated:NO];
//                                                      }];
//    
//    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"Explore"
//                                                       subtitle:@"Explore 47 additional options"
//                                                          image:[UIImage imageNamed:@"Icon_Explore"]
//                                               highlightedImage:nil
//                                                         action:^(REMenuItem *item) {
//                                                             NSLog(@"Item: %@", item);
//                                                             ExploreViewController *controller = [[ExploreViewController alloc] init];
//                                                             [weakSelf.navigationController setViewControllers:@[controller] animated:NO];
//                                                         }];
//    
//    REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:@"Activity"
//                                                        subtitle:@"Perform 3 additional activities"
//                                                           image:[UIImage imageNamed:@"Icon_Activity"]
//                                                highlightedImage:nil
//                                                          action:^(REMenuItem *item) {
//                                                              NSLog(@"Item: %@", item);
//                                                              ActivityViewController *controller = [[ActivityViewController alloc] init];
//                                                              [weakSelf.navigationController setViewControllers:@[controller] animated:NO];
//                                                          }];
//    
//    activityItem.badge = @"12";
//    
//    REMenuItem *profileItem = [[REMenuItem alloc] initWithTitle:@"Profile"
//                                                          image:[UIImage imageNamed:@"Icon_Profile"]
//                                               highlightedImage:nil
//                                                         action:^(REMenuItem *item) {
//                                                             NSLog(@"Item: %@", item);
//                                                             ProfileViewController *controller = [[ProfileViewController alloc] init];
//                                                             [weakSelf.navigationController setViewControllers:@[controller] animated:NO];
//                                                         }];
//    
//    // You can also assign a custom view for any particular item
//    // Uncomment the code below and add `customViewItem` to `initWithItems` array, for example:
//    // self.menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem, customViewItem]]
//    //
//    /*
//     UIView *customView = [[UIView alloc] init];
//     customView.backgroundColor = [UIColor blueColor];
//     customView.alpha = 0.4;
//     REMenuItem *customViewItem = [[REMenuItem alloc] initWithCustomView:customView action:^(REMenuItem *item) {
//     NSLog(@"Tap on customView");
//     }];
//     */
//    
//    homeItem.tag = 0;
//    exploreItem.tag = 1;
//    activityItem.tag = 2;
//    profileItem.tag = 3;
//
//    self.menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem]];
//
////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////
///////////////End of old initialization method/////////////
////////////////////////////////////////////////////////////
    
    
    self.menu = [[REMenu alloc] init];
    
    // Background view
    //
    //self.menu.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    //self.menu.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //self.menu.backgroundView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.600];
    
    //self.menu.imageAlignment = REMenuImageAlignmentRight;
    //self.menu.closeOnSelection = NO;
    //self.menu.appearsBehindNavigationBar = NO; // Affects only iOS 7
    if (!REUIKitIsFlatMode()) {
        self.menu.cornerRadius = 4;
        self.menu.shadowRadius = 4;
        self.menu.shadowColor = [UIColor blackColor];
        self.menu.shadowOffset = CGSizeMake(0, 1);
        self.menu.shadowOpacity = 1;
    }
    
    // Blurred background in iOS 7
    //
    //self.menu.liveBlur = YES;
    //self.menu.liveBlurBackgroundStyle = REMenuLiveBackgroundStyleDark;
    
    self.menu.separatorOffset = CGSizeMake(15.0, 0.0);
    self.menu.imageOffset = CGSizeMake(5, -1);
    self.menu.waitUntilAnimationIsComplete = NO;
    self.menu.badgeLabelConfigurationBlock = ^(UILabel *badgeLabel, REMenuItem *item) {
        badgeLabel.backgroundColor = [UIColor colorWithRed:0 green:179/255.0 blue:134/255.0 alpha:1];
        badgeLabel.layer.borderColor = [UIColor colorWithRed:0.000 green:0.648 blue:0.507 alpha:1.000].CGColor;
    };
    
    self.menu.delegate = self;
    self.menu.dataSource = self;
    
    
    [self.menu setClosePreparationBlock:^{
        NSLog(@"Menu will close");
    }];
    
    [self.menu setCloseCompletionHandler:^{
        NSLog(@"Menu did close");
    }];
}

- (void)toggleMenu
{
    if (self.menu.isOpen)
        return [self.menu close];
    
    [self.menu showFromNavigationController:self.navigationController];
}

#pragma mark - REMenu DataSource Methods

-(NSUInteger)numberOfItemsInREMenu:(REMenu *)menu
{
    return 3;
}

-(REMenuItem *)reMenu:(REMenu *)menu itemAtIndex:(NSUInteger)index
{
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"Home"
                                                    subtitle:@"Return to Home Screen"
                                                       image:[UIImage imageNamed:@"Icon_Home"]
                                            highlightedImage:nil
                                                      action:nil];
    
    return homeItem;
}

-(void)reMenu:(REMenu *)menu didSelectItemAtIndex:(NSUInteger)index
{
     NSLog(@"Item Selected: %lu", (long)index);
}

#pragma mark - REMenu Delegate Methods


-(void)willOpenMenu:(REMenu *)menu
{
    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)didOpenMenu:(REMenu *)menu
{
    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)willCloseMenu:(REMenu *)menu
{
    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

-(void)didCloseMenu:(REMenu *)menu
{
    NSLog(@"Delegate method: %@", NSStringFromSelector(_cmd));
}

@end
