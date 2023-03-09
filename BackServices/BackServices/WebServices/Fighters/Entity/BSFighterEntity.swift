//
//  BSFighterEntity.swift
//  BackServices
//
//  Created by jose perez on 08/03/23.
//

import Foundation
final public class BSFighterEntity: Codable {
    public let fighterID: Int
    public let firstName: String
    public let lastName : String?
    public let nickname : String?
    public let age : String?
    public let height : String?
    public let armReach : String?
    public let legReach : String?
    public let weight : String?
    public let weightClass : String?
    public let debut : String?
    public let bornTown : String?
    public let academy : String?
    public let fighterStyle : String?
    
    enum Codingkeys: String, CodingKey {
        case fighterID = "fighter_id"
        case firstName = "first_name"
        case lastName = "last_name"
        case nickname
        case age
        case height
        case armReach = "arm_reach"
        case legReach = "leg_reach"
        case weight
        case weightClass = "weight_class"
        case debut
        case bornTown = "born_town"
        case academy
        case fighterStyle = "fighter_style"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: Codingkeys.self)
            fighterID = try container.decode(Int.self, forKey: .fighterID)
            firstName = try container.decode(String.self, forKey: .firstName)
            lastName = try container.decode(String.self, forKey: .lastName)
            nickname = try container.decode(String.self, forKey: .nickname)
            age = try container.decode(String.self, forKey: .age)
            height = try container.decode(String.self, forKey: .height)
            armReach = try container.decode(String.self, forKey: .armReach)
            legReach = try container.decode(String.self, forKey: .legReach)
            weight = try container.decode(String.self, forKey: .weight)
            weightClass = try container.decode(String.self, forKey: .weightClass)
            debut = try container.decode(String.self, forKey: .debut)
            bornTown = try container.decode(String.self, forKey: .bornTown)
            academy = try container.decode(String.self, forKey: .academy)
            fighterStyle = try container.decode(String.self, forKey: .fighterStyle)
        } catch {
            fatalError("Error: \(error.localizedDescription)")
            
        }
    }
}
final public class BSFighterStatEntity: Codable {
    public let fighterStatsId: Int
    public let fighterId: Int
    public let record: String?
    public let winsByKo: Int
    public let winsByFirstRoundFinished: Int?
    public let sigStrikingLanded: Int?
    public let sigStrikingThrow: Int?
    public let takedownsAttempted : Int?
    public let takedownsLanded : Int?
    public let takedownsAvg: String?
    public let sigStrikingLandedMin: String?
    public let avgKnockdownFight: String?
    public let strikingDefence: String?
    public let knockdownAvg: String?
    public let sigStrikingRecievedMin: String?
    public let subAvgPerFight: String?
    public let takedownDefence: String?
    public let avgFightTime: String?
    public let sigStrikingLandedByPos: String?
    public let sigStrikingByTarget: String?
    
    enum Codingkeys: String, CodingKey {
        case fighterStatsId = "fighter_stats_id"
        case fighterId = "fighter_id"
        case record
        case winsByKo = "wins_by_ko"
        case winsByFirstRoundFinished = "wins_by_first_round_finished"
        case sigStrikingLanded = "sig_striking_landed"
        case sigStrikingThrow = "sig_striking_throw"
        case takedownsAttempted = "takedowns_attempted"
        case takedownsLanded = "takedowns_landed"
        case takedownsAvg = "takedowns_avg"
        case sigStrikingLandedMin = "sig_striking_landed_min"
        case avgKnockdownFight = "avg_knockdown_fight"
        case strikingDefence = "striking_defence"
        case knockdownAvg = "knockdown_avg"
        case sigStrikingRecievedMin = "sig_striking_recieved_min"
        case subAvgPerFight = "sub_avg_per_fight"
        case takedownDefence = "takedown_defence"
        case avgFightTime = "avg_fight_time"
        case sigStrikingLandedByPos = "sig_striking_landed_by_pos"
        case sigStrikingByTarget = "sig_striking_by_target"
    }
    
    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: Codingkeys.self)
            self.fighterStatsId = try container.decode(Int.self, forKey: .fighterStatsId)
            self.fighterId = try container.decode(Int.self, forKey: .fighterId)
            self.record = try container.decode(String.self, forKey: .record)
            self.winsByKo = try container.decode(Int.self, forKey: .winsByKo)
            self.winsByFirstRoundFinished = try container.decode(Int.self, forKey: .winsByFirstRoundFinished)
            self.sigStrikingLanded = try container.decode(Int.self, forKey: .sigStrikingLanded)
            self.sigStrikingThrow = try container.decode(Int.self, forKey: .sigStrikingThrow)
            self.takedownsAttempted = try container.decode(Int.self, forKey: .takedownsAttempted)
            self.takedownsLanded = try container.decode(Int.self, forKey: .takedownsLanded)
            self.takedownsAvg = try container.decode(String.self, forKey: .takedownsAvg)
            self.sigStrikingLandedMin = try container.decode(String.self, forKey: .sigStrikingLandedMin)
            self.avgKnockdownFight = try container.decode(String.self, forKey: .avgKnockdownFight)
            self.strikingDefence = try container.decode(String.self, forKey: .strikingDefence)
            self.knockdownAvg = try container.decode(String.self, forKey: .knockdownAvg)
            self.sigStrikingRecievedMin = try container.decode(String.self, forKey: .sigStrikingRecievedMin)
            self.subAvgPerFight = try container.decode(String.self, forKey: .subAvgPerFight)
            self.takedownDefence = try container.decode(String.self, forKey: .takedownDefence)
            self.avgFightTime = try container.decode(String.self, forKey: .avgFightTime)
            self.sigStrikingLandedByPos = try container.decode(String.self, forKey: .sigStrikingLandedByPos)
            self.sigStrikingByTarget = try container.decode(String.self, forKey: .sigStrikingByTarget)
        } catch {
            print(error.localizedDescription)
            fatalError()
        }
    }
}
