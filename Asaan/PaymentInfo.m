//
//  PaymentInfo.m
//  Asaan
//
//  Created by MC MINI on 9/21/14.
//  Copyright (c) 2014 Tech Fiesta. All rights reserved.
//

#import "PaymentInfo.h"
#include "InviteFriendsViewController.h"

@interface PaymentInfo ()

@end

@implementation PaymentInfo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.payment.delegate=self;
    
    //PTKView *paymentView = [[PTKView alloc] initWithFrame:CGRectMake(15, 100, 290, 55)];
    //paymentView.delegate = self;
    //self.payment = paymentView;
    //[self.view addSubview:paymentView];
    
    [self actionBarInit];
}


-(void)actionBarInit{
    UIPageControl *pagecontrol=[[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 50, 37)];
    pagecontrol.numberOfPages=3;
    pagecontrol.currentPageIndicatorTintColor=[UIColor colorWithRed:(187.0/255.0) green:(137.0/255.0) blue:(33.0/255.0) alpha:1.0f];
    pagecontrol.pageIndicatorTintColor=[UIColor whiteColor];
    pagecontrol.userInteractionEnabled=NO;
    pagecontrol.currentPage=1;
    NSLog(@"log");
    self.navigationItem.titleView =pagecontrol;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [button setTitle:@">" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=btn;
}

-(void)nextPressed:(id)sender{
    InviteFriendsViewController *paytmentInfo=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Signup3"];
    [self.navigationController pushViewController:paytmentInfo animated:YES];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    return [textField resignFirstResponder];
}


- (void)paymentView:(PTKView *)paymentView withCard:(PTKCard *)card isValid:(BOOL)valid{
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
