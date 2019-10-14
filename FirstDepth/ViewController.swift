//
//  ViewController.swift
//  FirstDepth
//
//  Created by student2 on 10/7/19.
//  Copyright © 2019 student2. All rights reserved.
//

import UIKit
import MetalKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: MTKView!
    
    private var videoCapture: VideoCapture!
    var curentCameraType: CameraType = .back(true)
    private let serialQueue = DispatchQueue(label: "com.shu223.iOS-Depth-Sampler.queue")
    
    private var renderer: MetalRenderer!
    private var depthImage: CIImage?
    private var currentDrawableSize: CGSize!
    
    private var videoImage: CIImage?
    
    override func viewDidLoad() {
           super.viewDidLoad()
            
        let device = MTLCreateSystemDefaultDevice()!
        sceneView.device = device
        sceneView.backgroundColor = UIColor.clear
        sceneView.delegate = self
        renderer = MetalRenderer(metalDevice: device, renderDestination: sceneView)
        
        videoCapture = VideoCapture(cameraType: curentCameraType, preferredSpec: nil, previewContainer: sceneView.layer )
        
        videoCapture.syncedDataBufferHandler = { [weak self] videoPixelBuffer, depthData, face in
        guard let self = self else { return }
            
            self.videoImage = CIImage(cvPixelBuffer: videoPixelBuffer)
            
            }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let  videoCapture = videoCapture else {return}
        videoCapture.startCapture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let videoCapture = videoCapture else {return}
        videoCapture.imageBufferHandler = nil
        videoCapture.stopCapture()
        sceneView.delegate = nil
        super.viewWillDisappear(animated)
    }
}
    extension ViewController: MTKViewDelegate {
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
            currentDrawableSize = size
        }
        
        func draw(in view: MTKView) {
            if let image = depthImage {
                renderer.update(with: image)
            }
        }
    }
    
   /* extension RealtimeDepthViewController: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        currentDrawableSize = size
    }
        
      xfunc draw (in view : MTKView) {
            if let image = depthImage {
                renderer.update(with: image)
            }
        }
    }*/
    
    
    
    //base
    /*@IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }*/

