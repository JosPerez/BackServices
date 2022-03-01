//
//  BSBaseFacade.swift
//  BackServices
//
//  Created by jose perez on 01/03/22.
//
import Foundation
import UIKit
/// Delegado de recibir la información.
public protocol BSResponseDelegate {
    /// Recibe información correcta
    ///  - Parameters:
    ///   - entity: Data de servicio.
    ///   - requestName: Nombre del servicio
    func recievedEntity<T>(entity: T, requestName: String)
}
open class BSBaseFacade {
    /// URL base de servicio
    public var url: String!
    /// Connection
    public var connection: BSURLSession
    /// Delegado de la respuesta.
    public var delegate: BSResponseDelegate?
    /// Inicializador
    public init(url: String) {
        self.url = url
        self.connection = BSURLSession()
    }
    /// Recibe el  error del servicio
    ///  - Parameters:
    ///    - error: Error del servicio.
    ///    - code: Código der error del servicio.
    ///    - requestName: Nombre de la petición.
    open func recievedError(error: Error ,code: Int?, requestName: String) {
        let baseError = BSErrorBase(message: "Se encontro este error", code: code)
        self.delegate?.recievedEntity(entity: baseError, requestName: requestName)
    }
    /// Decode de la entidad de forma segura.
    ///  - Parameters:
    ///    - responseType: Tipo Entidad.
    ///    - data: data  del servicio.
    ///    - requestName: Nombre de la petición.
    public func decodeEntity<T: Codable>(responseType: T.Type, data: Data, requestName: String) {
        do {
            let response = try JSONDecoder().decode(responseType, from: data)
            self.delegate?.recievedEntity(entity: response, requestName: requestName)
        } catch {
            let baseError = BSErrorBase(message: "Problema en el decodeo", code: 999)
            self.delegate?.recievedEntity(entity: baseError, requestName: requestName)
        }
    }
}
final public class BSErrorBase {
    /// Mensaje de error
    var message: String?
    /// Codigo de error
    var code: Int?
    /// Inicializador con parametros
    public init(message: String?,code: Int?) {
        self.message = message
        self.code = code
    }
}
