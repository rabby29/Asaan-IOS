//
//  AccountViewController.h
//  Asaan
//
//  Created by MC MINI on 9/9/14.
//  Copyright (c) 2014 Tech Fiesta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTKView.h"


@interface AccountViewController : UIViewController<PTKViewDelegate,UIAlertViewDelegate>{
    UIAlertView *alert;
}
@property IBOutlet PTKView* paymentView;

@end
