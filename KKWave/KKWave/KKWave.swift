//
//  Wave.swift
//  FarmHouseKeeper
//
//  Created by 聂康  on 2017/5/26.
//  Copyright © 2017年 聂康. All rights reserved.
//

import UIKit

class KKWave: UIImageView {

    var timer:CADisplayLink?
    
    var maskLayer = CAShapeLayer()  //遮罩
    
    var waveLayer = CAShapeLayer() //波浪
    
    var waveColor = UIColor.white
    
    var maskColor = UIColor.white.withAlphaComponent(0.3)
    
    var waveHeight:CGFloat = 5 {
        didSet{
            layoutUI()
        }
    }
    
    var waveSpeed:CGFloat = 0.5 //波浪浪速
    
    var waveCurvature:CGFloat = 1.5 //波浪曲度
    
    var offset:CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        maskLayer.fillColor = maskColor.cgColor
        waveLayer.fillColor = waveColor.cgColor
        layer.addSublayer(waveLayer)
        layer.addSublayer(maskLayer)
        
        layoutUI()
    }
    
    func layoutUI(){
        var rect = bounds
        rect.origin.y = bounds.height - waveHeight
        rect.size.height = waveHeight
        waveLayer.frame  = rect
        maskLayer.frame  = rect
    }
    
    func wave() {
        
        offset += waveSpeed
        
        let w = bounds.size.width
        let h = waveHeight
        
        var y:CGFloat = 0
        var maskY:CGFloat = 0
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: h))
        
        let maskPath = CGMutablePath()
        maskPath.move(to: CGPoint(x: 0, y: h))
        
        for x in 0...Int(w) {
            y = h * CGFloat(sinf(Float(0.01 * waveCurvature * CGFloat(x)) + Float(offset * 0.04)))
            path.addLine(to: CGPoint(x: CGFloat(x), y: y))
            maskY = -y
            maskPath.addLine(to: CGPoint(x: CGFloat(x), y: maskY))
        }
        
        path.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: 0, y: h))
        path.closeSubpath()
        waveLayer.path = path

        maskPath.addLine(to: CGPoint(x: w, y: h))
        path.addLine(to: CGPoint(x: 0, y: h))
        maskPath.closeSubpath()
        maskLayer.path = maskPath

    }
    
    func startWave(){
        if timer == nil {
            timer = CADisplayLink(target: self, selector: #selector(wave))
            timer?.add(to: RunLoop.current, forMode: .commonModes)
        }
    }
    
    func stopWave(){
        timer?.invalidate()
        timer = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
