//
//  CallObserver.swift
//  AzCommunicationService
//
//  Created by Mohsin Ali Ayub on 04.08.24.
//

import Foundation
import AzureCommunicationCalling

public class CallObserver: NSObject, CallDelegate, IncomingCallDelegate {
    private var owner: ContentView
    init(_ view:ContentView) {
            owner = view
    }
        
    public func call(_ call: Call, didChangeState args: PropertyChangedEventArgs) {
        if(call.state == CallState.connected) {
            initialCallParticipant()
        }
    }

    // render remote video streams when remote participant changes
    public func call(_ call: Call, didUpdateRemoteParticipant args: ParticipantsUpdatedEventArgs) {
        for participant in args.addedParticipants {
            participant.delegate = owner.remoteParticipantObserver
            for stream in participant.videoStreams {
                if !owner.remoteVideoStreamData.isEmpty {
                    return
                }
                let data:RemoteVideoStreamData = RemoteVideoStreamData(view: owner, stream: stream)
                let scalingMode = ScalingMode.fit
                data.renderer = try! VideoStreamRenderer(remoteVideoStream: stream)
                let view:RendererView = try! data.renderer!.createView(withOptions: CreateViewOptions(scalingMode:scalingMode))
                data.views.append(view)
                self.owner.remoteViews.append(view)
                owner.remoteVideoStreamData[stream.id] = data
            }
            owner.remoteParticipant = participant
        }
    }

    // Handle remote video streams when the call is connected
    public func initialCallParticipant() {
        for participant in owner.call!.remoteParticipants {
            participant.delegate = owner.remoteParticipantObserver
            for stream in participant.videoStreams {
                renderRemoteStream(stream)
            }
            owner.remoteParticipant = participant
        }
    }
    
    //create render for RemoteVideoStream and attach it to view
    public func renderRemoteStream(_ stream: RemoteVideoStream!) {
        if !owner.remoteVideoStreamData.isEmpty {
            return
        }
        let data:RemoteVideoStreamData = RemoteVideoStreamData(view: owner, stream: stream)
        let scalingMode = ScalingMode.fit
        data.renderer = try! VideoStreamRenderer(remoteVideoStream: stream)
        let view:RendererView = try! data.renderer!.createView(withOptions: CreateViewOptions(scalingMode:scalingMode))
        self.owner.remoteViews.append(view)
        owner.remoteVideoStreamData[stream.id] = data
    }
}
