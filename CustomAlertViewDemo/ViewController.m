

#import "ViewController.h"
#import "CustomAlertViewDemo-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction) doButton: (id) sender {
    UIViewController* vc = [CustomAlertViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}


@end
