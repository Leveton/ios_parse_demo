#import "ParseStarterProjectViewController.h"
#import <Parse/Parse.h>

@implementation ParseStarterProjectViewController
{
    IBOutlet UILabel *fileLabel;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)importFromParse:(id)sender
{
    PFUser *user = [PFUser currentUser];
    NSString *userID = user.objectId;
    PFQuery *query = [PFQuery queryWithClassName:@"Terms"];
    [query whereKey:@"link"
     containsString: userID];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object)
        {
            fileLabel.text = @"Either your device is offline, or you have not uploaded any terms from the webservice.  Please refer to the first part of the tutorial at";
        }
        else
        {
            NSObject *link_address = [object valueForKey:@"link"];
            NSURL *url = [NSURL URLWithString: (NSString *)link_address];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            NSString *datastring = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
            fileLabel.text = datastring;
            
        }
    }];
}


@end
