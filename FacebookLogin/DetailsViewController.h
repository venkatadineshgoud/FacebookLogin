//
//  DetailsViewController.h
//  FacebookLogin
//
//  Created by harinath on 31/08/16.
//  Copyright © 2016 Madu Venkata Dinesh Goud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (void)updateViewWithData:(NSDictionary *)userData;
@property(nonatomic,strong)NSArray *friendsarr;

@end
