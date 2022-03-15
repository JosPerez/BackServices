//
//  BSTVShowsFacade.swift
//  BackServices
//
//  Created by jose perez on 14/03/22.
//
import Foundation

final public class BSTVShowsFacade: BSBaseFacade {
    /// Obtiene la información de las series de televisión
    public func getTVShows() {
        do {
            let request = try getRequest(uri: "shows")
            connection.delegate = self
            connection.sendRequest(request: request, requestName: String(describing: BSTVShowsEntity.self))
        } catch let error {
            print(error)
        }
    }
    ///Obtiene los show favoritos guardados por el usuario.
    public func getFavoriteShow() {
        do {
            var allTVShows: [BSTVShowsEntity] = []
            let manager = BSUserDefaultManager()
            if let data = manager.getData(key: .favorite) {
                let entity = try JSONDecoder().decode([BSTVShowsEntity].self, from: data)
                allTVShows = entity
            }
            self.delegate?.recievedEntity(entity: allTVShows, requestName: String(describing: [BSTVShowsEntity].self))
        } catch let error {
            print(error)
            self.delegate?.recievedEntity(entity: BSSaveFavoriteResponse(message: "No se pudo guardar la información", isError: true), requestName: String(describing: BSSaveFavoriteResponse.self))
        }
    }
    /// Guarda la serie favorita en user default
    ///  - Parameter tvshow: Información a guardar.
    public func saveFavorite(tvshow: BSTVShowsEntity) {
        do {
            var allTVShows: [BSTVShowsEntity] = []
            let manager = BSUserDefaultManager()
            if let data = manager.getData(key: .favorite) {
                let entity = try JSONDecoder().decode([BSTVShowsEntity].self, from: data)
                allTVShows = entity
            }
            allTVShows.append(tvshow)
            let newData = try JSONEncoder().encode(allTVShows)
            manager.storeData(key: .favorite, data: newData)
            self.delegate?.recievedEntity(entity: BSSaveFavoriteResponse(message: "Se guardo exitosamente la información", isError: false), requestName: String(describing: BSSaveFavoriteResponse.self))
        } catch let error {
            print(error)
            self.delegate?.recievedEntity(entity: BSSaveFavoriteResponse(message: "No se pudo guardar la información", isError: true), requestName: String(describing: BSSaveFavoriteResponse.self))
        }
    }
    /// Elimina  la serie favorita en user default
    ///  - Parameter tvshow: Información a guardar.
    public func deleteFavorite(tvshow: BSTVShowsEntity) {
        do {
            var allTVShows: [BSTVShowsEntity] = []
            let manager = BSUserDefaultManager()
            if let data = manager.getData(key: .favorite) {
                let entity = try JSONDecoder().decode([BSTVShowsEntity].self, from: data)
                allTVShows = entity
            }
            if !allTVShows.isEmpty {
                allTVShows.removeAll(where: { $0.id == tvshow.id })
                let newData = try JSONEncoder().encode(allTVShows)
                manager.storeData(key: .favorite, data: newData)
                self.delegate?.recievedEntity(entity: BSSaveFavoriteResponse(message: "Se elimino exitosamente la información", isError: false), requestName: String(describing: BSSaveFavoriteResponse.self))
            }
        } catch let error {
            print(error)
            self.delegate?.recievedEntity(entity: BSSaveFavoriteResponse(message: "No se pudo eliminar la información", isError: true), requestName: String(describing: BSSaveFavoriteResponse.self))
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
