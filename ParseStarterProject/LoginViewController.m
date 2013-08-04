//
//  LoginViewController.m
//  ParseStarterProject
//
//  Created by Mike Leveton on 8/3/13.
//
//
#import <Parse/Parse.h>
#import "LoginViewController.h"
#import "ParseStarterProjectViewController.h"

@interface LoginViewController ()
{
    IBOutlet UITextField *userNameField;
    IBOutlet UITextField *passwordField;
}

@end

@implementation LoginViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)processFieldEntries:(id)sender{
	NSString *username = [userNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *password = [passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
	[PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
        
		if (user) {
			ParseStarterProjectViewController *viewController = [[ParseStarterProjectViewController alloc] initWithNibName:@"ParseStarterProjectViewController" bundle:nil];
            [self presentViewController:viewController animated:YES completion:nil];
        } else {
			NSLog(@"%@", error);
			// Bring the keyboard back up, because they'll probably need to change something.
			[userNameField becomeFirstResponder];
		}
	}];
}

@end
