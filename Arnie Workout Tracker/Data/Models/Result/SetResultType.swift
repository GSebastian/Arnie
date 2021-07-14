//
//  SetResultType.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 14/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation

enum SetResultType: Codable, Hashable {

    case reps(setResult: NewSetResult<Int>)
    case time(setResult: NewSetResult<Int>)

    init(from decoder: Decoder) throws {
        let enumContainer = try decoder.container(keyedBy: SetResultType.CodingKeys.self)
        let setPlan = try enumContainer.decode(SetPlan<Int>.self, forKey: .setPlan)
        let type = try enumContainer.decode(String.self, forKey: .type)
        switch type {
        case "time":
            let result = try enumContainer.decode(Int.self, forKey: .result)
            self = .time(setResult: NewSetResult(result: result, setPlan: setPlan))
        case "reps":
            let result = try enumContainer.decode(Int.self, forKey: .result)
            self = .reps(setResult: NewSetResult(result: result, setPlan: setPlan))
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: enumContainer, debugDescription: "Invalid value for type")
        }
    }

    func encode(to encoder: Encoder) throws {
        func encodeSetResult(_ setResult: Any, in: KeyedEncodingContainer<SetResultType.CodingKeys>) throws {
            // TODO: Make this generic
            if let setResult = setResult as? NewSetResult<Int> {
                try container.encode(setResult.result, forKey: .result)
                try container.encode(setResult.setPlan, forKey: .setPlan)
            }
        }

        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .reps(let setResult):
            try container.encode("reps", forKey: .type)
            try encodeSetResult(setResult, in: container)
        case .time(let setResult):
            try container.encode("time", forKey: .type)
            try encodeSetResult(setResult, in: container)
        }
    }

    enum CodingKeys: String, CodingKey {
        case result
        case setPlan
        case type
    }
}

extension SetResultType: Identifiable {

    var id: String {
        switch self {
        case .reps(let setResult):
            return setResult.setPlan.id
        case .time(let setResult):
            return setResult.setPlan.id
        }
    }
}

extension SetResultType: SetResultRespresentable {

    var title: String {
        switch self {
        case .reps(let result):
            return titleForReps(result: result)
        case .time(let result):
            return titleForTime(result: result)
        }
    }

    private func titleForReps(result: NewSetResult<Int>) -> String {
        let localizedWithPlaceholders =
            NSLocalizedString(
                "setResult.repSetResult.primaryLabel",
                comment: "")
        let localizedWithValue =
            String(
                format: localizedWithPlaceholders,
                result.result)
        return localizedWithValue
    }

    private func titleForTime(result: NewSetResult<Int>) -> String {
        let localizedWithPlaceholders =
            NSLocalizedString(
                "setResult.timeSetResult.primaryLabel",
                comment: "")
        let localizedWithValue =
            String(
                format: localizedWithPlaceholders,
                result.result)
        return localizedWithValue
    }

    var description: String? {
        nil
    }

    var exercise: Exercise {
        switch self {
        case .reps(let setResult):
            return setResult.setPlan.exercise
        case .time(let setResult):
            return setResult.setPlan.exercise
        }
    }
}

protocol SetResultRespresentable {
    var title: String { get }
    var description: String? { get }
    var exercise: Exercise { get }
}
