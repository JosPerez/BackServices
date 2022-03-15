//
//  BSTVShowsEntity.swift
//  BackServices
//
//  Created by jose perez on 05/03/22.
//
import Foundation
/// Entidad que contiene información de programas de la televisión.
final public class BSTVShowsEntity: Codable, CustomStringConvertible {
    /// Identificador del programa.
    public var id: Int?
    /// Url del programa.
    public var url: String?
    /// Nombre del programa
    public var name: String?
    /// Tipo de progarma
    public var type: String?
    /// Lenguaje oficial.
    public var language: String?
    /// Genero del programa.
    public var genres: [BSGenreType]?
    /// Estatus del programa.
    public var status: String?
    /// Duración del programa.
    public var runtime: Int?
    /// Duración promedio del programa.
    public var averagaRuntime: Int?
    /// Fecha de inicio.
    public var premiered: String?
    /// Fecha del final
    public var ended: String?
    /// Sitio Web oficial
    public var officalWebsite: String?
    /// Horario del programa.
    public var schedule: BSScheduleEntity?
    /// Rating del programa.
    public var rating: BSRatingEntity?
    /// Peso pelicula
    public var weight: Int?
    /// Cadena del programa.
    public var network: BSNetworkEntity?
    /// Codigos externos para otros sitios de peliculas.
    public var externals: BSExternalEntity?
    /// Link a imagenes del programa
    public var image: BSTVImageEntity?
    /// Resumen del programa en formato HTML
    public var summary: String?
    /// Links a los detalles de la pelicula
    public var links: BSTVLinksEntity?
    /// LLaves para codificar
    enum Codingkeys: String, CodingKey {
        case id
        case url
        case name
        case type
        case language
        case genres
        case status
        case runtime
        case averagaRuntime
        case premiered
        case ended
        case officalWebsite
        case schedule
        case rating
        case weight
        case network
        case externals
        case image
        case summary
        case links = "_links"
    }
    ///
    public init() {}
    ///
    public func encode(to encoder: Encoder) throws {
        var encode = encoder.container(keyedBy: Codingkeys.self)
        try encode.encode(self.id, forKey: .id)
        try encode.encode(self.url, forKey: .url)
        try encode.encode(self.name, forKey: .name)
        try encode.encode(self.language, forKey: .language)
        try encode.encode(self.genres, forKey: .genres)
        try encode.encode(self.status, forKey: .status)
        try encode.encode(self.runtime, forKey: .runtime)
        try encode.encode(self.averagaRuntime, forKey: .averagaRuntime)
        try encode.encode(self.premiered, forKey: .premiered)
        try encode.encode(self.ended, forKey: .ended)
        try encode.encode(self.officalWebsite, forKey: .officalWebsite)
        try encode.encode(self.schedule, forKey: .schedule)
        try encode.encode(self.rating, forKey: .rating)
        try encode.encode(self.weight, forKey: .weight)
        try encode.encode(self.network, forKey: .network)
        try encode.encode(self.externals, forKey: .externals)
        try encode.encode(self.image, forKey: .image)
        try encode.encode(self.summary, forKey: .summary)
        try encode.encode(self.links, forKey: .links)
    }
    ///
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.language = try container.decodeIfPresent(String.self, forKey: .language)
        self.genres = try container.decodeIfPresent([BSGenreType].self, forKey: .genres)
        self.status = try container.decodeIfPresent(String.self, forKey: .status)
        self.runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        self.averagaRuntime = try container.decodeIfPresent(Int.self, forKey: .averagaRuntime)
        self.premiered = try container.decodeIfPresent(String.self, forKey: .premiered)
        self.ended = try container.decodeIfPresent(String.self, forKey: .ended)
        self.officalWebsite = try container.decodeIfPresent(String.self, forKey: .officalWebsite)
        self.schedule = try container.decodeIfPresent(BSScheduleEntity.self, forKey: .schedule)
        self.rating = try container.decodeIfPresent(BSRatingEntity.self, forKey: .rating)
        self.weight = try container.decodeIfPresent(Int.self, forKey: .weight)
        self.network = try container.decodeIfPresent(BSNetworkEntity.self, forKey: .network)
        self.externals = try container.decodeIfPresent(BSExternalEntity.self, forKey: .externals)
        self.image = try container.decodeIfPresent(BSTVImageEntity.self, forKey: .image)
        self.summary = try container.decodeIfPresent(String.self, forKey: .summary)
        self.links = try container.decodeIfPresent(BSTVLinksEntity.self, forKey: .links)
    }
    public var description: String {
        return "id: \(String(describing: self.id))\n url: \(String(describing: self.url))\n name: \(String(describing: self.name))\n language: \(String(describing: self.language))\n status: \(String(describing: self.status))\n "
    }
}
/// Entidad que contiene el tipo de Genero.
public enum BSGenreType: String, Codable {
    case Action
    case Adult
    case Adventure
    case Anime
    case Children
    case Comedy
    case Crime
    case DIY
    case Drama
    case Espionage
    case Family
    case Fantasy
    case Food
    case History
    case Horror
    case Legal
    case Medical
    case Music
    case Mystery
    case Nature
    case ScienceFiction = "Science-Fiction"
    case Sports
    case Supernatural
    case Thriller
    case Western
    case War
    case Other
    public init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = BSGenreType(rawValue: label) ?? .Other
    }
}
/// Entidad que contiene horarios de programas de la televisión
final public class BSScheduleEntity: Codable {
    /// Hora del progarma
    public var time: String?
    /// Días del programa
    public var days: [String]?
    /// LLaves para codificar
    enum Codingkeys: String, CodingKey {
        case time
        case days
    }
    /// Inicializador con decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        self.time = try container.decodeIfPresent(String.self, forKey: .time)
        self.days = try container.decodeIfPresent([String].self, forKey: .days)
    }
}
/// Entidad que contiene rating de programas de la televisión
final public class BSRatingEntity: Codable {
    /// Rating promedio.
    public var average: Double?
    /// LLaves para codificar
    enum Codingkeys: String, CodingKey {
        case average
    }
    /// Inicializador con decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        self.average = try container.decodeIfPresent(Double.self, forKey: .average)
    }
}
/// Entidad que contiene Cadena de programas de la televisión
final public class BSNetworkEntity: Codable {
    /// Identifdicador de la cadena.
    public var id: Int?
    /// Nombre de la cadena.
    public var name: String?
    /// Pais de la cadena
    public var country: BSCountryEntity?
    /// LLaves para codificar
    enum Codingkeys: String, CodingKey {
        case id
        case name
        case country
    }
    /// Inicializador con decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.country = try container.decodeIfPresent(BSCountryEntity.self, forKey: .country)
    }
}
/// Entidad que contiene pais de la caden de programas de la televisión
final public class BSCountryEntity: Codable {
    /// codigo identifdicador de la cadena.
    public var code: String?
    /// Nombre del pais.
    public var name: String?
    ///  Uso Horario.
    public var timezone: String?
    /// LLaves para codificar
    enum Codingkeys: String, CodingKey {
        case code
        case name
        case timezone
    }
    /// Inicializador con decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        self.code = try container.decodeIfPresent(String.self, forKey: .code)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.timezone = try container.decodeIfPresent(String.self, forKey: .timezone)
    }
}
/// Entidad que contiene codigo para paginas externas
final public class BSExternalEntity: Codable {
    /// codigo para tvrage.
    public var codeTVRange: Int?
    /// codigo para thetvdb
    public var codeTheTVDB: Int?
    /// codigo para imdb
    public var codeIMDB: String?
    /// LLaves para codificar
    enum Codingkeys: String, CodingKey {
        case codeTVRange = "tvrage"
        case codeTheTVDB = "thetvdb"
        case codeIMDB = "imdb"
    }
    /// Inicializador con decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        self.codeTVRange = try container.decodeIfPresent(Int.self, forKey: .codeTVRange)
        self.codeTheTVDB = try container.decodeIfPresent(Int.self, forKey: .codeTheTVDB)
        self.codeIMDB = try container.decodeIfPresent(String.self, forKey: .codeIMDB)
    }
}
/// Entidad que contiene links para las imagenes
final public class BSTVImageEntity: Codable {
    /// Imagen mediana.
    public var medium: String?
    /// Imagen original
    public var original: String?
    /// LLaves para codificar
    enum Codingkeys: String, CodingKey {
        case medium
        case original
    }
    /// Inicializador con decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        self.medium = try container.decodeIfPresent(String.self, forKey: .medium)
        self.original = try container.decodeIfPresent(String.self, forKey: .original)
    }
}
/// Entidad que contiene links para las imagenes
final public class BSTVLinksEntity: Codable {
    /// codigo
    public var tvshow: BSReferenceEntity?
    /// codigo
    public var lastEpisode: BSReferenceEntity?
    /// LLaves para codificar
    enum Codingkeys: String, CodingKey {
        case tvshow = "self"
        case lastEpisode = "previousepisode"
    }
    /// Inicializador con decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        self.tvshow = try container.decodeIfPresent(BSReferenceEntity.self, forKey: .tvshow)
        self.lastEpisode = try container.decodeIfPresent(BSReferenceEntity.self, forKey: .lastEpisode)
    }
}
/// Entidad que contiene rating de programas de la televisión
final public class BSReferenceEntity: Codable {
    /// Rating promedio.
    public var reference: String?
    /// LLaves para codificar
    enum Codingkeys: String, CodingKey {
        case reference = "href"
    }
    /// Inicializador con decoder
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        self.reference = try container.decodeIfPresent(String.self, forKey: .reference)
    }
}
