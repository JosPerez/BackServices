//
//  BSTVShowsFacade.swift
//  BackServices
//
//  Created by jose perez on 14/03/22.
//
import Foundation

final public class BSTVShowsFacade: BSBaseFacade {
    public func getTVShows() {
        do {
            let request = try getRequest(uri: "shows")
            connection.delegate = self
            connection.sendRequest(request: request, requestName: String(describing: BSTVShowsEntity.self))
        } catch let error {
            print(error)
        }
    }
    
}
extension BSTVShowsFacade: BSConnectionDelegate {
    public func recievedData(data: Data, requestName: String) {
        switch requestName {
        case  String(describing: BSTVShowsEntity.self):
            decodeEntity(responseType: [BSTVShowsEntity].self, data: data, requestName: requestName)
        default: break
        }
    
        
    }
}
