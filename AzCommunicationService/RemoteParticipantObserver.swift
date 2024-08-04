//
//  RemoteParticipantObserver.swift
//  AzCommunicationService
//
//  Created by Mohsin Ali Ayub on 04.08.24.
//

import Foundation
import AzureCommunicationCalling

public class RemoteParticipantObserver : NSObject, RemoteParticipantDelegate {
    private var owner:ContentView
    init(_ view: ContentView) {
        owner = view
    }

    public func renderRemoteStream(_ stream: RemoteVideoStream!) {
        let data: RemoteVideoStreamData = RemoteVideoStreamData(view: owner, stream: stream)
        let scalingMode = ScalingMode.fit
        data.renderer = try! VideoStreamRenderer(remoteVideoStream: stream)
        let view:RendererView = try! data.renderer!.createView(withOptions: CreateViewOptions(scalingMode:scalingMode))
        self.owner.remoteViews.append(view)
        owner.remoteVideoStreamData[stream.id] = data
    }
    
    // render RemoteVideoStream when remote participant turns on the video, dispose the renderer when remote video is off
    public func remoteParticipant(_ remoteParticipant: RemoteParticipant, didUpdateVideoStreams args: RemoteVideoStreamsEventArgs) {
        for stream in args.addedRemoteVideoStreams {
            renderRemoteStream(stream)
        }
        for stream in args.removedRemoteVideoStreams {
            for data in owner.remoteVideoStreamData.values {
                data.renderer?.dispose()
            }
            owner.remoteViews.removeAll()
        }
    }
}
