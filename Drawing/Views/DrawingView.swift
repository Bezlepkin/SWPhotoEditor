//
//  DrawingView.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 19.09.2024.
//

import Foundation

public final class DrawingView: UIView {
    var isDrawing: Bool = true
    var swiped: Bool = false
    var lastPoint: CGPoint
    var color: UIColor
    
    private var canvasImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public override init(frame: CGRect) {
        lastPoint = CGPoint(x: 0, y: 0)
        color = .black
        
        super.init(frame: frame)
        
        layoutCanvasImageView()
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
        return canvasImageView.image
    }
    
    func clearDrawingResult() {
        canvasImageView.image = nil
    }
    
    private func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
        let canvasSize = frame.integral.size
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
        
        if let context = UIGraphicsGetCurrentContext() {
            canvasImageView.image?.draw(in: CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height))

            context.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
            context.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
            context.setLineCap( CGLineCap.round)
            context.setLineWidth(5.0)
            context.setStrokeColor(color.cgColor)
            context.setBlendMode( CGBlendMode.normal)
            context.strokePath()

            canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        }
        // clear draw
        // canvasImageView.removeFromSuperview()
        UIGraphicsEndImageContext()
    }
    
    private func layoutCanvasImageView() {
        addSubview(canvasImageView)
        
        NSLayoutConstraint.activate([
            canvasImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            canvasImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            canvasImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            canvasImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ])
    }
}
