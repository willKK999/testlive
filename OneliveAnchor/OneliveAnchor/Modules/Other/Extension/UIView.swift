

import UIKit


extension UIView {
    
    /// x origin of view.
    public var x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// y origin of view.
    public var y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    /// Width of view.
    public var width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    /// Height of view.
    public var height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    /// Size of view.
    public var size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    
    /// Origin of view.
    public var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
            frame.origin = newValue
        }
    }
    
    /// CenterX of view.
    public var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    /// CenterY of view.
    public var centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
    
    /// Right of view.
    public var right: CGFloat {
        get {
            return frame.maxX
        }
        set {
            frame.origin.x = newValue - frame.size.width
        }
    }
    
    /// Bottom of view.
    public var bottom: CGFloat {
        get {
            return frame.maxY
        }
        set {
            frame.origin.y = newValue - frame.size.height
        }
    }
}


extension UIView {
    //设置圆角、边框
    public func setLayerCorner(radius: CGFloat,
                               corners: CACornerMask = .allCorners,
                               width borderWidth: CGFloat? = nil,
                               color: CGColor? = nil) {
        layer.maskedCorners = corners
        layer.cornerRadius = radius
        if let borderWidth = borderWidth {
            layer.borderWidth = borderWidth;
        }
        if let color = color {
            layer.borderColor = color
        }
        clipsToBounds = true
    }
    
    /// Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    
    
    
    //设置右边框
    public func rightBorder(width: CGFloat, borderColor: UIColor){
        let rect = CGRect(x: 0, y: self.frame.size.width - width, width: width, height: self.frame.size.height)
        drawBorder(rect: rect, color: borderColor)
    }
    //设置左边框
    public func leftBorder(width: CGFloat, borderColor: UIColor){
        let rect = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        drawBorder(rect: rect, color: borderColor)
    }
    
    //设置上边框
    public func topBorder(width: CGFloat, borderColor: UIColor){
        let rect = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
        drawBorder(rect: rect, color: borderColor)
    }
    
    //设置底边框
    public func bottomBorder(width: CGFloat, borderColor: UIColor){
        let rect = CGRect(x: 0, y: self.frame.size.height-width, width: self.frame.size.width, height: width)
        drawBorder(rect: rect, color: borderColor)
    }
    
    //画线
    private func drawBorder(rect:CGRect, color: UIColor){
        let line = UIBezierPath(rect: rect)
        let lineShape = CAShapeLayer()
        lineShape.path = line.cgPath
        lineShape.fillColor = color.cgColor
        self.layer.addSublayer(lineShape)
    }
    
    /// 设置阴影效果
    public func setLayerShadow(radius: CGFloat,
                               corners: CACornerMask = .allCorners,
                               color: UIColor = .black,
                               offset: CGSize = CGSize(width:0, height:1),
                               shadowRadius: CGFloat = 10,
                               shadowOpacity: Float = 0.1) {
        //定义view的角度
        layer.cornerRadius = radius
        layer.maskedCorners = corners
        //定义view的阴影颜色
        layer.shadowColor = color.cgColor
        //阴影偏移量
        layer.shadowOffset = offset
        //定义view的阴影宽度，模糊计算的半径
        layer.shadowRadius = shadowRadius
        //定义view的阴影透明度，注意:如果view没有设置背景色阴影也是不会显示的
        layer.shadowOpacity = shadowOpacity
        //针对圆角提升性能设置
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}




/// Gradient method extended of the `UIView` class.
///
extension UIView{
    
    ///添加渐变填充
    public func addGradient(_ colors: [CGColor],
                            locations: [NSNumber] = [0, 1],
                            startPoint: CGPoint? = nil,
                            endPoint: CGPoint? = nil) {
        //创建CAGradientLayer实例并设置参数
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.startPoint = (startPoint != nil) ? startPoint! : CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = (endPoint != nil) ? endPoint! : CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.bounds
        
        asGradient(gradientLayer: gradientLayer)
    }
    
    ///添加渐变填充
//    public func addGradient(_ colors: [CGColor],
//                            startPoint: CGPoint? = nil,
//                            endPoint: CGPoint? = nil) {
//        //创建CAGradientLayer实例并设置参数
//        let gradientLayer: CAGradientLayer = CAGradientLayer()
//        gradientLayer.colors = colors
//        gradientLayer.startPoint = (startPoint != nil) ? startPoint! : CGPoint(x: 0.0, y: 0.5)
//        gradientLayer.endPoint = (endPoint != nil) ? endPoint! : CGPoint(x: 1.0, y: 0.5)
//        gradientLayer.frame = self.bounds
//
//        asGradient(gradientLayer: gradientLayer)
//    }
    
    ///添加渐变边框
    public func addGradientBorder(_ colors: [CGColor],
                                  bgColor: CGColor,
                                  cornerRadius: CGFloat? = nil,
                                  borderWidth: CGFloat = 1){
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.bounds
        
        
        let coverLayer = CALayer()
        coverLayer.backgroundColor = bgColor
        
        if let cornerRadius = cornerRadius {
            coverLayer.cornerRadius = cornerRadius
        } else {
            coverLayer.cornerRadius = self.height / 2
        }
        
        coverLayer.frame = CGRect(x: borderWidth, y: borderWidth, width: width - borderWidth * 2, height: height - borderWidth * 2)
        gradientLayer.addSublayer(coverLayer)
        
        
        asGradient(gradientLayer: gradientLayer)
    }
    
    ///移除渐变边框
    public func removeGradientBorder() {
        if self is UIButton {
            let button  = self as! UIButton
            button.setBackgroundImage(nil, for: .normal)
        }else if self is UIImageView {
            let imageView = self as! UIImageView
            imageView.image = nil
        } else {
            self.backgroundColor = .clear
        }
    }
    
    ///当前视图添加渐变图片
    public func asGradient(gradientLayer: CAGradientLayer){
        let view = UIView()
        view.frame = self.bounds
        view.layer.addSublayer(gradientLayer)
        let image = view.asImage()
        
        if self is UIButton {
            let button  = self as! UIButton
            button.setBackgroundImage(image, for: .normal)
        }else if self is UIImageView {
            let imageView = self as! UIImageView
            imageView.image = image
        } else {
            self.backgroundColor = UIColor(patternImage: image)
        }
    }
    
    //将当前视图转为UIImage
    public func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
