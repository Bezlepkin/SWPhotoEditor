//
//  DrawingCanvasView.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 19.09.2024.
//

import Foundation

public final class DrawingCanvasView: UIView {
    var isDrawing: Bool = true
    var swiped: Bool = false
    var lastPoint: CGPoint
    var color: UIColor
    
    private var canvas: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    public override init(frame: CGRect) {
        lastPoint = CGPoint(x: 0, y: 0)
        color = .black
        
        super.init(frame: frame)
        
        layoutCanvas()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDrawing {
            swiped = false
            if let touch = touches.first {
                lastPoint = touch.location(in: self)
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDrawing {
            swiped = true
            if let touch = touches.first {
                let currentPoint = touch.location(in: self)
                drawLineFrom(lastPoint, toPoint: currentPoint)
                lastPoint = currentPoint
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isDrawing {
            if !swiped {
                drawLineFrom(lastPoint, toPoint: lastPoint)
            }
        }
    }
    
    func getProcessedImage() -> UIImage? {
        return canvas.image
    }
    
    func clearDrawingResult() {
        canvas.image = nil
    }
    
    private func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
        let canvasSize = frame.integral.size
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
        
        if let context = UIGraphicsGetCurrentContext() {
            canvas.image?.draw(in: CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height))

            context.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
            context.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
            context.setLineCap( CGLineCap.round)
            context.setLineWidth(5.0)
            context.setStrokeColor(color.cgColor)
            context.setBlendMode( CGBlendMode.normal)
            context.strokePath()

            canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        }
        // clear draw
        // canvas.removeFromSuperview()
        UIGraphicsEndImageContext()
    }
    
    private func layoutCanvas() {
        addSubview(canvas)
        
        NSLayoutConstraint.activate([
            canvas.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvas.centerYAnchor.constraint(equalTo: centerYAnchor),
            canvas.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            canvas.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ])
    }
}
