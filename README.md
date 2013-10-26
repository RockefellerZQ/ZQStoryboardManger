ZQStoryboardManger
==================

######This is the manager for storyboard, that can prevent the view controller do not call the methd viewDidLoad every time

The singleton method:
```
+ (ZQStoryboardManger *)sharedStoryboardManger;
```

Get the View Controller:
```
- (UIViewController *)viewControllerWithIndenifier:(NSString *)indentifier inStoryboardWithName:(NSString *)storyboardName;
```
This method can get a viewController form the StoryBoard, the 'indenifier' is the ViewContoller's indentifier in the story board,
the 'storyboardName' is the story board name.

You can do it like this:
```
ZQViewController *viewController = [[ZQStoryboardManger sharedStoryboardManger] viewControllerWithIndenifier:@"ZQViewController" inStoryboardWithName:@"Main"];
```
Then you can present the get view controller.
