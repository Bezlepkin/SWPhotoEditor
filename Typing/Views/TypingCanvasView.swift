//
//  TypingView.swift
//  PhotoEditor
//
//  Created by Igor Bezlepkin on 20.09.2024.
//

import Foundation

public final class TypingCanvasView: UIView {
    
    var textColor: UIColor?
    var textView: TextView?
    
    private var canvas: UIView = {
        let canvasView = UIView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.contentMode = .scaleAspectFit
        return canvasView
    }()
    
    public override init(frame: CGRect) {
        textColor = .black
        super.init(frame: frame)
        backgroundColor = .blue
        let textView: TextView = TextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        layoutCanvas()
        setTextView(textView: textView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTextView(textView: TextView) {
        self.textView = textView;
        layoutTextView()
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
    
    private func layoutTextView() {
        guard let textView = textView else { return }
        canvas.addSubview(textView)
        canvas.backgroundColor = .purple
        textView.backgroundColor = .green
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: canvas.topAnchor),
            textView.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: canvas.bottomAnchor),
            textView.heightAnchor.constraint(equalToConstant: 30),
            textView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}
