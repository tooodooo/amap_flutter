import Foundation
import MAMapKit

class ClusterAnnotationView: MAAnnotationView {
    static let ScaleFactorAlpha: CGFloat = 0.3
    static let ScaleFactorBeta: CGFloat = 0.4

    var count: UInt = 0 {
        didSet {
            // 按count数目设置view的大小
            let newBounds = CGRect(x: 0, y: 0, width: round(44 * ScaledValueForValue(value: CGFloat(count))), height: round(44 * ScaledValueForValue(value: CGFloat(count))))
            self.frame = CenterRect(rect: newBounds, center: self.center)

            let newLabelBounds = CGRect(x: 0, y: 0, width: newBounds.size.width / 1.3, height: newBounds.size.height / 1.3)
            self.countLabel.frame = CenterRect(rect: newLabelBounds, center: RectCenter(rect: newBounds))
            self.countLabel.text = String(count)

            self.setNeedsDisplay()
        }
    }

    private var countLabel: UILabel = UILabel()

    override init(annotation: MAAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        setupLabel()
        self.count = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel() {
        countLabel.frame = self.frame
        countLabel.backgroundColor = .clear
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        countLabel.shadowColor = UIColor(white: 0.0, alpha: 0.75)
        countLabel.shadowOffset = CGSize(width: 0, height: -1)
        countLabel.adjustsFontSizeToFitWidth = true
        countLabel.numberOfLines = 1
        countLabel.font = UIFont.boldSystemFont(ofSize: 12)
        countLabel.baselineAdjustment = .alignCenters
        self.addSubview(countLabel)
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if subviews.count > 1 {
            for subView in subviews {
                if subView.point(inside: self.convert(point, to: subView), with: event) {
                    return true
                }
            }
        }
        if point.x > 0 && point.x < self.frame.size.width && point.y > 0 && point.y < self.frame.size.height {
            return true
        }
        return false
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        addBounceAnnimation()
    }

    private func addBounceAnnimation() {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [0.05, 1.1, 0.9, 1]
        bounceAnimation.duration = 0.6

        var timingFunctions = [CAMediaTimingFunction]()
        for _ in 0..<bounceAnimation.values!.count {
            timingFunctions.append(CAMediaTimingFunction(name: .easeInEaseOut))
        }
        bounceAnimation.timingFunctions = timingFunctions

        bounceAnimation.isRemovedOnCompletion = false

        self.layer.add(bounceAnimation, forKey: "bounce")
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setAllowsAntialiasing(true)

        let outerCircleStrokeColor = UIColor(white: 0, alpha: 0.25)
        let innerCircleStrokeColor = UIColor.white
        let innerCircleFillColor = UIColor(red: 255.0 / 255.0, green: 95 / 255.0, blue: 42 / 255.0, alpha: 1.0)

        let circleFrame = rect.insetBy(dx: 4, dy: 4)

        outerCircleStrokeColor.setStroke()
        context.setLineWidth(5.0)
        context.strokeEllipse(in: circleFrame)

        innerCircleStrokeColor.setStroke()
        context.setLineWidth(4)
        context.strokeEllipse(in: circleFrame)

        innerCircleFillColor.setFill()
        context.fillEllipse(in: circleFrame)
    }
}

// 返回rect的中心
func RectCenter(rect: CGRect) -> CGPoint {
    return CGPoint(x: rect.midX, y: rect.midY)
}

// 返回中心为center，尺寸为rect.size的rect
func CenterRect(rect: CGRect, center: CGPoint) -> CGRect {
    return CGRect(x: center.x - rect.size.width / 2.0, y: center.y - rect.size.height / 2.0, width: rect.size.width, height: rect.size.height)
}

// 根据count计算annotation的scale
func ScaledValueForValue(value: CGFloat) -> CGFloat {
    return 1.0 / (1.0 + exp(-1 * ClusterAnnotationView.ScaleFactorAlpha * pow(value, ClusterAnnotationView.ScaleFactorBeta)))
}    