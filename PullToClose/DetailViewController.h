//
//  DetailViewController.h
//  PullToClose
//
//  Created by Jorge Bernal on 8/16/13.
//  Copyright (c) 2013 Jorge Bernal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
