//
//  ViewController.h
//  Asaan
//
//  Created by MC MINI on 9/9/14.
//  Copyright (c) 2014 Tech Fiesta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GooglePlus/GooglePlus.h>
@class GPPSignInButton;

@interface ViewController : UIViewController<GPPSignInDelegate>



@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@end
