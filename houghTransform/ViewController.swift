//
//  ViewController.swift
//  houghTransform
//
//  Created by Robin Malhotra on 17/02/16.
//  Copyright © 2016 Robin Malhotra. All rights reserved.
//

import UIKit
import GPUImage
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let inputImage = UIImage(named: "screen")
        let stillImageSource = GPUImagePicture(image: inputImage!)
        
        let f1 = GPUImageHoughTransformLineDetector()
        let f2 = GPUImageLineGenerator()
        f2.forceProcessingAtSize(self.view.frame.size)
        f2.setLineColorRed(1, green: 0, blue: 0)
        f1.edgeThreshold = 0.3
        f1.lineDetectionThreshold = 0.3
        f1.linesDetectedBlock = {(lineArray, linesDetected, frameTime) -> Void in
            f2.renderLinesFromArray(lineArray, count: linesDetected, frameTime: frameTime)
            
        }
        stillImageSource.addTarget(f1)
        f1.addTarget(f2)

        stillImageSource.processImage()
        
        let currentFilteredVideoFrame = f2.imageFromCurrentFramebuffer()
        
        let imgView = UIImageView(image: currentFilteredVideoFrame)
        imgView.frame = self.view.frame
        self.view.addSubview(imgView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

