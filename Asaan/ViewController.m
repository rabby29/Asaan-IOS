//
//  ViewController.m
//  Asaan
//
//  Created by MC MINI on 9/9/14.
//  Copyright (c) 2014 Tech Fiesta. All rights reserved.
//

#import "ViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "AccountViewController.h"
#import "SignupViewController.h"
#import <AddressBook/AddressBook.h>
#import "MBProgressHUD.h"
#import "ResturantListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self GplusInit];
    [self askContactsPermission];
}



#pragma mark -FBLogin

-(IBAction)fbLogin:(id)sender{
    NSArray *permissions=@[@"public_profile", @"user_friends",@"email",@"user_birthday"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Please Wait";
    
    [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
        if (!user) {
              hud.hidden=YES;
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
            
            NSLog(@"%@",[user description]);
            hud.hidden=YES;
            [self _loadData];
            
        } else {
            NSLog(@"User logged in through Facebook!");
            hud.hidden=YES;
           // [self _loadData];

            AccountViewController *acv=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"profile"];
            [self presentViewController:acv animated:YES completion:nil];

        }
    }];

}
- (void)_loadData {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Please Wait";
    
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        
        if (!error) {

            NSDictionary *userData = (NSDictionary *)result;
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init] ;
            
            [dateFormatter setDateFormat:@"dd/MM/YYYY"];
            PFUser *user=[PFUser currentUser];
            NSLog(@"%@",userData);

            user[@"firstName"]=userData[@"first_name"];

            user[@"lastName"]=userData[@"last_name"];
          
            NSLog(@" birthday %@",userData[@"birthday"]);
            
           // user[@"birthDate"]=[dateFormatter dateFromString:userData[@"birthday"]];
           
            NSLog(@"log");
            user.email=userData[@"email"];
            NSLog(@"%@",user);

            [user saveInBackgroundWithBlock:^(BOOL complete,NSError *error){
                
                AccountViewController *acv=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"profile"];
                [self.navigationController pushViewController:acv animated:YES];
                
                hud.hidden=YES;
            }];
            
        }else{
            
            hud.hidden=YES;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        }
    }];
}


#pragma mark -gPlus login

-(void)GplusInit{
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.clientID = @"1041863510961-fmarksr003s0fvdisitq7lff8jlub2pa.apps.googleusercontent.com";
    
    
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];
    signIn.delegate = self;
}

-(IBAction)gPlusLogin:(id)sender{
    NSLog(@"log");
    [[GPPSignIn sharedInstance] authenticate];
}



- (void)finishedWithAuth: (GTMOAuth2Authentication *)auth
                   error: (NSError *) error {
    NSLog(@"Received error %@ and auth object %@",error, auth);
}

- (void)presentSignInViewController:(UIViewController *)viewController {
    // This is an example of how you can implement it if your app is navigation-based.
    NSLog(@"log");
    [[self navigationController] pushViewController:viewController animated:YES];
}







-(IBAction)Signup:(id)sender{
    SignupViewController *svc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Signup1"];
    [self.navigationController pushViewController:svc animated:YES];
}



-(IBAction)skipe:(id)sender{
 
   // ResturantListViewController *rvc=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"rabbi101"];
    
    //[self presentViewController:rvc animated:YES completion:nil];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





-(void)askContactsPermission{
    ABAddressBookRef  addressBook_ = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook_, ^(bool granted, CFErrorRef error)
                                                 {
                                                     if (granted == NO)
                                                     {
                                                         // Show an alert for no contact Access
                                                     }
                                                 });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
    {
        // The user has previously given access, good to go
    }
    else
    {
        // The user has previously denied access
        // Send an alert telling user to change privacy setting in settings app
    }
}



@end
