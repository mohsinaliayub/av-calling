//
//  RemoteVideoStreamData.swift
//  AzCommunicationService
//
//  Created by Mohsin Ali Ayub on 04.08.24.
//

import Foundation
import AzureCommunicationCalling

public class RemoteVideoStreamData : NSObject, RendererDelegate {
    public func videoStreamRenderer(didFailToStart renderer: VideoStreamRenderer) {
        owner.errorMessage = "Renderer failed to start"
    }
    
    private var owner:ContentView
    let stream:RemoteVideoStream
    var renderer:VideoStreamRenderer? {
        didSet {
            if renderer != nil {
                renderer!.delegate = self
            }
        }
    }
    
    var views:[RendererView] = []
    init(view:ContentView, stream:RemoteVideoStream) {
        owner = view
        self.stream = stream
    }
    
    public func videoStreamRenderer(didRenderFirstFrame renderer: VideoStreamRenderer) {
        let size:StreamSize = renderer.size
        owner.remoteVideoSize = String(size.width) + " X " + String(size.height)
    }
}
