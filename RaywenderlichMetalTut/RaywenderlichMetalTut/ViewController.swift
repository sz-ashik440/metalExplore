//
//  ViewController.swift
//  RaywenderlichMetalTut
//
//  Created by sz ashik on 20/2/20.
//  Copyright © 2020 sz ashik. All rights reserved.
//

import UIKit
import MetalKit


enum Colors {
  static let wenderlichGreen = MTLClearColor(red: 0,
                                             green: 0.4,
                                             blue: 0.21,
                                             alpha: 1)
}


class ViewController: UIViewController {
  
  var metallView: MTKView {
    return view as! MTKView
  }
  
  var device: MTLDevice!
  var commandQueue: MTLCommandQueue!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    metallView.device = MTLCreateSystemDefaultDevice()
    
    device = metallView.device
    metallView.clearColor = Colors.wenderlichGreen
    
    metallView.delegate = self
    
    commandQueue = device.makeCommandQueue()
    
    
  }
}

extension ViewController: MTKViewDelegate {
  func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    
  }
  func draw(in view: MTKView) {
    guard let drawable = view.currentDrawable,
      let descriptor = view.currentRenderPassDescriptor else { return }
    
    if let commandBuffer = commandQueue.makeCommandBuffer(),
      let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: descriptor) {
      commandEncoder.endEncoding()
      commandBuffer.present(drawable)
      commandBuffer.commit()
    }
  }
}

