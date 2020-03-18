# XTRouter

## Example

To run the example project, clone the repo, and run directory.

## Requirements

`iOS 10.0` or later

## Installation

XTRouter is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "XTRouter"
```

## Useage
base on[ XTFMDB](https://github.com/Akateason/XTFMDB) . you should config a DB when App did Launched .



### Register router from Class/Xib/Storyboard
```
[XTRouter registVCFromClass:@"OneViewController"];
[XTRouter registVCFromXib:@"TwoViewController"];
[XTRouter registVCFromStoryboard:@"ThreeViewController" storyboardName:@"Main"];

```

### Jump to any VC
```
[XTRouter jumpVC:@"OneViewController"
           param:@"{'a':'something blablabla'}"
             way:(XTRouterSkipWayPush)
     viewDidLoad:^{
     // do sth...
}];
```


## Author

teason, akateason@qq.com

## License

XTRouter is available under the MIT license. See the LICENSE file for more info.
