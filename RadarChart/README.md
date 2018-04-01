近段一个新的需求是要做一个雷达图用来展示数据，下图为两种方式绘制的雷达图已经器内存使用情况：

drawRect方式绘制的雷达图
![drawRect方式绘制的雷达图.png](https://upload-images.jianshu.io/upload_images/1030171-41c12ff06345f757.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/500)


CAShapeLayer方式绘制的雷达图
![CAShapeLayer方式绘制的雷达图.png](https://upload-images.jianshu.io/upload_images/1030171-9af62bd48914c236.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/500)

在调研过后 发现现在市面上有两种做雷达图的方式一种是通过 `drawRect`进行绘制 另一种则是通过 `CAShapeLayer` 去绘制，那么既然有两种绘制方式的话, 那么就来对比一下这种两种绘制方式在内存方面的的优与劣,如上图，drawRect 方式绘制相同的雷达图占用的内存比CAShapeLayer 整整大了8M。那么drawRect方法为什么消耗的内存比CAShapeLayer 大呢？

#### drawRect
 如果想要了解`drawRect`，那我们就需要撸一撸在iOS程序上图形显示的原理了。在iOS系统中所有显示的视图都是从基类UIView继承而来的，同时UIView负责接收用户交互。但是实际上你所看到的视图内容，包括图形等，都是由`UIView`的一个实例图层属性来绘制和渲染的，那就是`CALayer`。
	
`CALayer`类的概念与`UIView`非常类似，它也具有树形的层级关系，并且可以包含图片文本、背景色等。它与`UIView`最大的不同在于它不能响应用户交互，可以说它根本就不知道响应链的存在，它的API虽然提供了“某点是否在图层范围内的方法”，但是它并不具有响应的能力。

在每一个`UIView`实例当中，都有一个默认的支持图层，`UIView`负责创建并且管理这个图层。实际上这个`CALayer`图层才是真正用来在屏幕上显示的，`UIView`仅仅是对它的一层封装，实现了`CALayer`的`delegate`，提供了处理事件交互的具体功能，还有动画底层方法的高级API。可以说`CALayer`是`UIView`的内部实现细节。

脑补了这么多，它与今天的主题`drawRect`有何关系呢？别着急，我们既然已经确定`CALayer`才是最终显示到屏幕上的，只要顺藤摸瓜，即可分析清楚。`CALayer`其实也只是iOS当中一个普通的类，它也并不能直接渲染到屏幕上，因为屏幕上你所看到的东西，其实都是一张张图片。而为什么我们能看到`CALayer`的内容呢，是因为`CALayer`内部有一个`contents`属性。`contents`默认可以传一个id类型的对象，但是只有你传`CGImage`的时候，它才能够正常显示在屏幕上。所以最终我们的图形渲染落点落在`contents`身上。如图：

![](http://7xkdhe.com1.z0.glb.clouddn.com/drawRect3.001.png)	

`contents`也被称为寄宿图，除了给它赋值`CGImage`之外，我们也可以直接对它进行绘制，绘制的方法正是这次问题的关键，通过继承`UIView`并实现 `-drawRect:`方法即可自定义绘制。但是呢`drawRect:`方法没有默认的实现，因为对`UIView`来说，寄宿图并不是必须的，UIView不关心绘制的内容。如果UIView检测到`-drawRect:`方法被调用了，它就会为视图分配一个寄宿图，这个寄宿图的像素尺寸等于视图大小乘以`contentsScale`(这个属性与屏幕分辨率有关，我们的雷达图在不同模拟器下呈现的内存用量不同也是因为它)的值。

那么回到我们的雷达图上，当雷达图从屏幕上出现的时候，因为重写了`-drawRect:`方法，`-drawRect :`就会自动调用。生成一张寄宿图后，方法里面的代码利用`Core Graphics`去绘制n条线条，然后内容就会缓存起来，等待下次你调用`-setNeedsDisplay`时就会在进行更新。
		
雷达视图的`-drawRect:`方法的背后实际上都是底层的`CALayer`进行了重绘和保存中间产生的图片，`CALayer`的`delegate`属性默认实现了`CALayerDelegate`协议，当它需要内容信息的时候会调用协议中的方法来拿。	
	
当雷达视图刷新数据重绘时，因为它的支持图层`CALayer`的代理就是雷达视图本身，所以支持图层会请求雷达视图给它一个寄宿图来显示，它此刻会调用：

```
- (void)displayLayer:(CALayer *)layer;	
```	
如果雷达视图实现了这个方法，就可以拿到`layer`来直接设置`contents`寄宿图，如果这个方法没有实现，支持图层`CALayer`会尝试调用：

```
- (void)displayLayer:(CALayer *)layer;	
```
这个方法调用之前，`CALayer`创建了一个合适尺寸的空寄宿图（尺寸由`bounds`和`contentsScale`决定）和一个`Core Graphics`的绘制上下文环境，为绘制寄宿图做准备，它作为`ctx`参数传入。在这一步生成的空寄宿图内存是相当巨大的，它就是本次内存问题的关键，一旦你实现了`CALayerDelegate`协议中的`-drawLayer:inContext:`方法或者`UIView`中的`-drawRect:`方法（其实就是前者的包装方法），图层就创建了一个绘制上下文，这个上下文需要的内存可从这个公式得出：图层宽* 图层高 * 4字节，宽高的单位均为像素。 而既然我们的雷达图是封装的库 就应该适应各个尺寸下内存的要求，比如我们当前的雷达图尺寸下需要开辟的内存空间大小为：

``` 
 radarV = [[JYRadarChart alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 400)];  
```

那么我们在8P机器 上下文的内存量则是： 1242 * 1200 * 4字节  其实算下来大概有5兆多。在其内部又有通过`drawRect`方法去实现绘制文字 `title` 则加起来有 8M多

#### CAShapeLayer

`CAShapeLayer`是一个通过矢量图形而不是`bitmap`来绘制的图层子类。用`CGPath`来定义想要绘制的图形，`CAShapeLayer`会自动渲染。它可以完美替代我们的直接使用`Core Graphics`绘制`layer`，对比之下使用`CAShapeLayer`有以下优点	
- 渲染快速。`CAShapeLayer`使用了硬件加速，绘制同一图形会比用`Core Graphics`快很多。
- 高效使用内存。一个`CAShapeLayer`不需要像普通`CALayer`一样创建一个寄宿图形，所以无论有多大，都不会占用太多的内存。
- 不会被图层边界剪裁掉。一个`CAShapeLayer`可以在边界之外绘制。你的图层路径不会像在使用`Core Graphics`的普通`CALayer`一样被剪裁掉
- 不会出现像素化。当你给`CAShapeLayer`做3D变换时，它不像一个有寄宿图的普通图层一样变得像素化

通过两个demo的对比下 在当前尺寸下确实内存上会相差8M左右 ，如果其他设计要求雷达图尺寸大一点的话 那么就会产生更大的内存消耗。

在此总结一下绘制性能优化原则：

- 1.绘制图形性能的优化最好的办法就是不去绘制。
- 2.利用专有图层代替绘图需求。
- 3.不得不用到绘图尽量缩小视图面积，并且尽量降低重绘频率。
- 4.异步绘制，推测内容，提前在其他线程绘制图片，在主线程中直接设置图片。

当然了，这两种雷达图的实现方式各有优缺点，也很感谢雷达图作者开源。


参考链接:
 
 [iOS RadarChart](https://www.jianshu.com/p/4df4d4c15012)

[JYRadarChart](https://github.com/johnnywjy/JYRadarChart)

[drawRect内存恶鬼](http://bihongbo.com/2016/01/03/memoryGhostdrawRect/)