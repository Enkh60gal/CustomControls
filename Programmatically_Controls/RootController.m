//
//  RootController.m
//  Programmatically_Controls
//
//  Created by sld on 9/28/12.
//  Copyright (c) 2012 sld. All rights reserved.
//

#import "RootController.h"
#import <QuartzCore/QuartzCore.h>

#import "TPKeyboardAvoidingScrollView.h"
#import "MyLocation.h"

#define METERS_PER_MILE 1609.344

@interface RootController () {
    MKMapView *mapView;
}

@end

@implementation RootController

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
    
    [self initializeViews];
}


- (void) initializeViews {
    
    TPKeyboardAvoidingScrollView *scrollView = [[TPKeyboardAvoidingScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, 320, 460);
    scrollView.contentSize = CGSizeMake(320, 2000);
    [self.view addSubview:scrollView];
    
    int margin = 10;
    int xx = margin;
    int yy = margin;
    
    {
        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        playButton.frame = CGRectMake(xx, yy, 100.0, 100.0);
        yy += (100 + margin);
        [playButton setTitle:@"Button" forState:UIControlStateNormal];
        playButton.backgroundColor = [UIColor clearColor];
        
        [playButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal ];
        [playButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted ];
        
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"btn1.png"];
        UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [playButton setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];
        
        UIImage *buttonImagePressed = [UIImage imageNamed:@"btn2.png"];
        UIImage *strechableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
        [playButton setBackgroundImage:strechableButtonImagePressed forState:UIControlStateHighlighted];
        
        
        UIColor *color = playButton.currentTitleColor;
        playButton.titleLabel.layer.shadowColor = [color CGColor];
        playButton.titleLabel.layer.shadowRadius = 4.0f;
        playButton.titleLabel.layer.shadowOpacity = .9;
        playButton.titleLabel.layer.shadowOffset = CGSizeZero;
        playButton.titleLabel.layer.masksToBounds = NO;
        
        [playButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView addSubview:playButton];
    }
    {
        UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(xx, yy, 200, 100)];
        yy += (100 + margin);
        
        myLabel.backgroundColor = [UIColor clearColor];
        
        myLabel.font = [UIFont fontWithName:@"Zapfino" size: 14.0];
        
        myLabel.shadowColor = [UIColor grayColor];
        myLabel.shadowOffset = CGSizeMake(1,1);
        
        myLabel.textColor = [UIColor blueColor];
        myLabel.textAlignment = UITextAlignmentRight; 
        myLabel.lineBreakMode = UILineBreakModeWordWrap;
        myLabel.numberOfLines = 2; 
        myLabel.text = @"Lorem ipsum dolor sit\namet...";
        
        [scrollView addSubview:myLabel];
    }
    {
        UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(xx,yy,100,100)];
        yy += (100 + margin);
        scroll.showsVerticalScrollIndicator=YES;
        scroll.scrollEnabled=YES;
        scroll.userInteractionEnabled=YES;
        scroll.backgroundColor = [UIColor blackColor];
        scroll.contentSize = scroll.frame.size;
        
        [scrollView addSubview:scroll];
    }
    {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(xx, yy, 200, 40)];//standart height 31
        yy += (40 + margin);
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.font = [UIFont systemFontOfSize:15];
        textField.placeholder = @"enter text";
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.returnKeyType = UIReturnKeyDone;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        textField.delegate = self;
        
        [scrollView addSubview:textField];
    }
    {
        UITextView *textView =[[UITextView alloc]init];
        textView.frame=CGRectMake(xx,yy,282,100);
        yy += (100 + margin);
        textView.backgroundColor = [UIColor blueColor];
        [textView setReturnKeyType:UIReturnKeyDone];
        [scrollView addSubview:textView];
    }
    {
        CGRect webFrame = CGRectMake(xx, yy, 320.0, 200.0);
        yy += (200 + margin);
        UIWebView *webView = [[UIWebView alloc] initWithFrame:webFrame];
        [webView setBackgroundColor:[UIColor greenColor]];
        NSString *urlAddress = @"http://www.roseindia.net";
        NSURL *url = [NSURL URLWithString:urlAddress];
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        [webView loadRequest:requestObj];
        [scrollView addSubview:webView];
    }
    {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(xx, yy, 320, 200) style:UITableViewStylePlain];
        yy += (200 + margin);
        tableView.dataSource = self;
        tableView.delegate = self;
        [scrollView addSubview:tableView];
    }
    {
        mapView = [[MKMapView alloc] initWithFrame:CGRectMake(xx, yy, 320, 200)];
        yy += (200 + margin);
        mapView.delegate = self;
        [scrollView addSubview:mapView];
    }
    {
        CGRect frame = CGRectMake(xx, yy, 0, 0);
        UISwitch *switchControl = [[UISwitch alloc] initWithFrame:frame];
        [switchControl addTarget:self action:@selector(actionSwitch:) forControlEvents:UIControlEventTouchUpInside];
        
        [switchControl setBackgroundColor:[UIColor clearColor]];
        [scrollView addSubview:switchControl];
    }
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



















#pragma Action functions
- (void) buttonClicked: (id)sender {
    
}
- (void) actionSwitch: (id)sender {
    
}


- (void) setReg: (double)lat Lon: (double)lon {
    NSNumber * latitude = [NSNumber numberWithDouble:lat];
    NSNumber * longitude = [NSNumber numberWithDouble:lon];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude.doubleValue;
    coordinate.longitude = longitude.doubleValue;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
    
    [mapView setRegion:adjustedRegion animated:YES];
}
- (void) addAnnotationWithLat: (double)lat Lon: (double)lon Desc: (NSString*)crimeDescription Address: (NSString *)address: (int)tag {
    
    NSNumber * latitude = [NSNumber numberWithDouble:lat];
    NSNumber * longitude = [NSNumber numberWithDouble:lon];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude.doubleValue;
    coordinate.longitude = longitude.doubleValue;
    
    MyLocation *annotation = [[MyLocation alloc] initWithName:crimeDescription address:address coordinate:coordinate];
    annotation.tag = tag;
    [mapView addAnnotation:annotation];
}
- (void) clearMapView {
    for (id<MKAnnotation> annotation in mapView.annotations) {
        [mapView removeAnnotation:annotation];
    }
}





















#pragma Delegate functions
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    cell.textLabel.text = @"CELL";
    
    return cell;
    
}






#pragma mark -
#pragma mark Mapview delegate
- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [map dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.canShowCallout = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.image = [UIImage imageNamed:@"atm_map.png"];//here we use a nice image instead of the default pins
        
        return annotationView;
    }
    
    return nil;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}
- (void)mapView: (MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    
}






@end
