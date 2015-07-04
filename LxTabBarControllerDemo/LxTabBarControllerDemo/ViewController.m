//
//  DeveloperLx
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:(UITabBarSystemItem)arc4random()%12 tag:0];
        self.title = self.tabBarItem.title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    UILabel * label = [[UILabel alloc]init];
    label.text = [@"LxTabBarController " stringByAppendingString:self.title];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:27];
    [self.view addSubview:label];
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray * pushLabelConstraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[label]-30-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(label)];
    NSArray * pushLabelConstraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-90-[label(==48)]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(label)];
    
    [self.view addConstraints:pushLabelConstraintsH];
    [self.view addConstraints:pushLabelConstraintsV];
}

@end
