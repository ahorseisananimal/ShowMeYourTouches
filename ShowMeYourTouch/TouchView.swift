
import UIKit

class TouchView: UIView {
    var savedTouches = [UITouch]()
    override init(frame: CGRect) {
        super .init(frame: frame)
        isMultipleTouchEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        isMultipleTouchEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches begun")
        for touch in touches {
            savedTouches.append(touch)
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches moved")
        setNeedsDisplay()

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches ended")
        removeTouches(touches)
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches cancelled")
        removeTouches(touches)
        setNeedsDisplay()
    }
    

    
    func removeTouches(_ touches: Set<UITouch>) {
        for touch in touches {
            for i in 0..<savedTouches.count {
                if savedTouches[i] == touch {
                    savedTouches.remove(at: i)
                    break
                }
            }
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        print("draw rect called")
        super.draw(rect)
        UIColor.systemPink.setFill()
        print(savedTouches.count)
        for touch in savedTouches {
            _ = getTouchPointer(in: touch.location(in: self))
        }
    }
    
    private func getTouchPointer(in point: CGPoint) -> UIBezierPath{
        let path = UIBezierPath()
        let radius: CGFloat = 40
        let xCenter: CGFloat = point.x
        let yCenter: CGFloat = point.y
        
      //  path.lineWidth = 1
        path.addArc(withCenter: CGPoint(x:xCenter , y: yCenter),
                    radius: radius,
                    startAngle: 0,
                    endAngle: CGFloat(Double.pi*2),
                    clockwise: true)
       // path.stroke()
        path.fill()
        return path
    }
}
