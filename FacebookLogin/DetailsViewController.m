//
//  DetailsViewController.m
//  FacebookLogin
//
//  Created by harinath on 31/08/16.
//  Copyright © 2016 Madu Venkata Dinesh Goud. All rights reserved.
//

#import "DetailsViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self getUserData];
    
       // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getUserData {
   
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id,name,link,first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error)
         {
               // NSLog(@"friends : %@",result);
             
             [self updateViewWithData:result];
             
         }
     }];
    
    
}

- (void)updateViewWithData:(NSDictionary *)userData {
    NSLog(@"user data %@",userData);
    
    
    
    self.friendsarr=[NSArray arrayWithArray:[[userData valueForKey:@"friends"]valueForKey:@"data"]];
    NSLog(@"friends arr %@",self.friendsarr);

    [self.tableview reloadData];
    
    self.label1.text=[userData valueForKey:@"name"];
    
    
    
    NSURL *url=[NSURL URLWithString:[[[userData valueForKey:@"picture"] valueForKey:@"data"]valueForKey:@"url"]];
    NSData *data=[NSData dataWithContentsOfURL:url];
    self.imageview.image=[UIImage imageWithData:data];
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:[NSString stringWithFormat:@"/%@",self.friendsarr[0][@"id"]]
                                  parameters:@{@"fields": @"id,about,age_range,bio, birthday, cover, email, first_name, hometown"}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        // Handle the result
        
        NSLog(@"Friend detail %@", result);
        NSLog(@"Error %@", error);

        
    }];
    
    
}


- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return (@"friends");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friendsarr.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myid=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:myid];
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myid];
    
}
    cell.textLabel.text=[[self.friendsarr objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}

//- (void)getFriendsListByUserId:(NSString *)userId {
//    [[[FBSDKGraphRequest alloc] initWithGraphPath:[NSString stringWithFormat:@"/%@/friends", userId] parameters:nil]
//     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//         if (!error)
//         {
//             NSLog(@"friends id : %@",result);
//         }
//     }];
//
//}
@end
