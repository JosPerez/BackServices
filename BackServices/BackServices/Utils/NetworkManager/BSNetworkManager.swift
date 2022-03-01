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
final public class BSNetworkManager {
    /// Contiene el monitor de red.
    static public var shared: BSNetworkManager = BSNetworkManager()
    /// Fila despachadora en backfground
    private var queue: DispatchQueue
    /// Monitor de red.
    private var cellMonitor: NWPathMonitor
    /// Monitor de red.
    private var wifiMonitor: NWPathMonitor
    /// Contiene variable si es conectado a internet.
    private var isWiFiAvailible: Bool
    /// Contiene variable si es conectado a celular.
    private var isCellAvailible: Bool
    /// Delegado de cambio de red
    public var networkDelegate: BSNetworkManagerDelegate?
    /// Iniicalizador
    init() {
        self.cellMonitor = NWPathMonitor(requiredInterfaceType: .cellular)
        self.wifiMonitor = NWPathMonitor(requiredInterfaceType: .wifi)
        self.queue = DispatchQueue.global(qos: .background)
        self.isWiFiAvailible = false
        self.isCellAvailible = false
        self.wifiMonitor.start(queue: queue)
        self.cellMonitor.start(queue: queue)
    }
    /// Iniciar monitoreo de red
    public func start() {
        startWiFiMonitoring()
        startCellMonitoring()
    }
    /// Revisar red de WiFi.
    private func startWiFiMonitoring() {
        cellMonitor.pathUpdateHandler = { path in
            self.isCellAvailible = path.status == .satisfied
            self.networkDelegate?.didNetworkChange(status: self.networkStatus())
        }
    }
    /// Revisar red de Celuar.
    private func startCellMonitoring() {
        wifiMonitor.pathUpdateHandler = { path in
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
        cellMonitor.cancel()
        wifiMonitor.cancel()
        self.isWiFiAvailible = false
        self.isCellAvailible = false
    }
}
