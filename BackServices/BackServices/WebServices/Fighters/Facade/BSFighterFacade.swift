//
//  BSFighterFacade.swift
//  BackServices
//
//  Created by jose perez on 08/03/23.
//
import Foundation

final public class BSFighterFacade: BSBaseFacade {
    /// Obtiene la información de las series de televisión
    public func getFighterProfile() {
        do {
            let request = try getRequest(uri: "fighter")
            connection.delegate = self
            connection.sendRequest(request: request, requestName: String(describing: BSFighterEntity.self))
        } catch let error {
            print(error)
        }
    }
    /// Obtiene la información de las series de televisión
    public func getFighterStatsBy(id: Int) {
        do {
            let request = try getRequest(uri: "fighter/stats/\(id)")
            connection.delegate = self
            connection.sendRequest(request: request, requestName: String(describing: BSFighterStatEntity.self))
        } catch let error {
            print(error)
        }
    }
    public func getFighterHistorysBy(id: Int) {
        do {
            let request = try getRequest(uri: "fighter/history/\(id)")
            connection.delegate = self
            connection.sendRequest(request: request, requestName: String(describing: BSFighterHistory.self))
        } catch let error {
            print(error)
        }
    }
}
extension BSFighterFacade: BSConnectionDelegate {
    public func recievedData(data: Data, requestName: String) {
        switch requestName {
        case  String(describing: BSFighterEntity.self):
            decodeEntity(responseType: [BSFighterEntity].self, data: data, requestName: requestName)
        case  String(describing: BSFighterStatEntity.self):
            decodeEntity(responseType: BSFighterStatEntity.self, data: data, requestName: requestName)
        case  String(describing: BSFighterHistory.self):
            decodeEntity(responseType: BSFighterHistory.self, data: data, requestName: requestName)
        default: break
        }
    }
}
