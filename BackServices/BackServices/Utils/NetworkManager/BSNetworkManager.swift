//
//  BSNetworkManager.swift
//  BackServices
//
//  Created by jose perez on 01/03/22.
//
import Foundation
import Network
public protocol BSNetworkManagerDelegate {
    /// Función con el cambio de status en la red
    func didNetworkChange(status: Bool)
}
final public class BSNetworkManager: NSObject {
    /// Contiene el monitor de red.
    static public var shared: BSNetworkManager = BSNetworkManager()
    /// Fila despachadora en backfground
    private var queue: DispatchQueue
    /// Monitor de red.
    private var mainMonitor: NWPathMonitor
    private var isWiFiAvailible: Bool
    /// Contiene variable si es conectado a celular.
    private var isCellAvailible: Bool
    /// Delegado de cambio de red
    public var networkDelegate: BSNetworkManagerDelegate?
    /// Iniicalizador
    override init() {
        self.mainMonitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.isWiFiAvailible = false
        self.isCellAvailible = false
        super.init()
    }
    /// Iniciar monitoreo de red
    public func start() {
        self.mainMonitor = NWPathMonitor()
        startMainMonitoring()
    }
    /// Revisar red.
    private func startMainMonitoring() {
        mainMonitor.start(queue: queue)
        mainMonitor.pathUpdateHandler = { path in
            self.isCellAvailible = path.status == .satisfied
            self.isWiFiAvailible = path.status == .satisfied
            self.networkDelegate?.didNetworkChange(status: self.networkStatus())
        }
    }
    /// Estatus de red.
    /// - Returns: Valor si esta encendida.
    public func networkStatus() -> Bool {
        return isCellAvailible || isWiFiAvailible
    }
    /// Termina monitoreo de red
    public func cancel() {
        mainMonitor.cancel()
        self.isWiFiAvailible = false
        self.isCellAvailible = false
    }
}
