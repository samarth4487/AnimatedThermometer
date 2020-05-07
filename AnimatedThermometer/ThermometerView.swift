//
//  ThermometerView.swift
//  AnimatedThermometer
//
//  Created by Samarth Paboowal on 06/05/20.
//  Copyright © 2020 Samarth. All rights reserved.
//

import UIKit

class ThermometerView: UIView {
    
    let bodyLayer = CAShapeLayer()
    let levelLayer = CAShapeLayer()
    let maskLayer = CAShapeLayer()
    
    var level: CGFloat = 0.3 {
        didSet {
            levelLayer.strokeEnd = level
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupBodyLayer()
        setupLevelLayer()
        setupMaskLayer()
    }
    
    private func setupBodyLayer() {
        
        let lineWidth = bounds.width/3
        let width = bounds.width - lineWidth
        let height = bounds.height - lineWidth/2
        
        layer.addSublayer(bodyLayer)
        
        let bodyPath = UIBezierPath(ovalIn: CGRect(x: lineWidth/2, y: height - width, width: width, height: width))
        bodyPath.move(to: CGPoint(x: width/2 + lineWidth/2, y: height - width))
        bodyPath.addLine(to: CGPoint(x: width/2 + lineWidth/2, y: 20))
        bodyLayer.path = bodyPath.cgPath
        bodyLayer.strokeColor = UIColor.white.cgColor
        bodyLayer.lineWidth = width/3
        bodyLayer.lineCap = .round
    }
    
    private func setupLevelLayer() {
        
        layer.addSublayer(levelLayer)
        
        let levelPath = UIBezierPath()
        levelPath.move(to: CGPoint(x: bounds.midX, y: bounds.height))
        levelPath.addLine(to: CGPoint(x: bounds.midX, y: 0))
        levelLayer.path = levelPath.cgPath
        levelLayer.strokeColor = UIColor.red.cgColor
        levelLayer.lineWidth = bounds.width
        levelLayer.strokeEnd = level
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan))
        addGestureRecognizer(pan)
    }
    
    private func setupMaskLayer() {
        
        maskLayer.path = bodyLayer.path
        maskLayer.strokeColor = bodyLayer.strokeColor
        maskLayer.lineWidth = bodyLayer.lineWidth
        maskLayer.lineCap = bodyLayer.lineCap
        maskLayer.fillColor = nil
        
        levelLayer.mask = maskLayer
    }
    
    @objc private func didPan(recognizer: UIPanGestureRecognizer) {
    
        let translation = recognizer.translation(in: self)
        let percent = translation.y/bounds.height
        level = max(0, min(1, levelLayer.strokeEnd - percent))
        levelLayer.strokeEnd = level
        recognizer.setTranslation(.zero, in: self)
    }
}
