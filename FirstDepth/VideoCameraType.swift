//
//  VideoCameraType.swift
//  FirstDepth
//
//  Created by student2 on 10/7/19.
//  Copyright © 2019 student2. All rights reserved.
//

import AVFoundation

enum CameraType {
    case back(Bool)
    
    func captureDevice() -> AVCaptureDevice {
        let devices: [AVCaptureDevice]
        
        switch self{
        case .back( let requireDepth):
            var deviceTypes: [AVCaptureDevice.DeviceType] = [.builtInDualCamera]
            if !requireDepth {
                deviceTypes.append((.builtInWideAngleCamera))
                
            }
            devices = AVCaptureDevice.DiscoverySession(deviceTypes: deviceTypes, mediaType: .video, position: .back).devices
        }
        guard let device = devices.first else {
            return AVCaptureDevice.default( for: .video)!
        }
        return device
    }
}
                                                            
