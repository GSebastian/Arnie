//
//  SetPlanType.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 14/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation

enum SetPlanType: Codable, Identifiable, Hashable {
    case time(plan: SetPlan<Int>)
    case reps(plan: SetPlan<Int>)

    // MARK: - Title

    init(from decoder: Decoder) throws {
        let enumContainer = try decoder.container(keyedBy: SetPlanType.CodingKeys.self)
        let exercise = try enumContainer.decode(Exercise.self, forKey: .exercise)
        let id = try enumContainer.decode(String.self, forKey: .id)
        let type = try enumContainer.decode(String.self, forKey: .type)
        switch type {
        case "time":
            let plannedResult = try enumContainer.decode(Int.self, forKey: .plannedResult)
            self = .time(plan: SetPlan(exercise: exercise, id: id, plannedResult: plannedResult))
        case "reps":
            let plannedResult = try enumContainer.decode(Int.self, forKey: .plannedResult)
            self = .reps(plan: SetPlan(exercise: exercise, id: id, plannedResult: plannedResult))
        default:
            throw DecodingError.dataCorruptedError(forKey: .type, in: enumContainer, debugDescription: "Invalid value for type")
        }
    }

    func encode(to encoder: Encoder) throws {
        func encodePlan(_ plan: Any, in: KeyedEncodingContainer<SetPlanType.CodingKeys>) throws {
            if let plan = plan as? SetPlan<Int> {
                try container.encode(plan.exercise, forKey: .exercise)
                try container.encode(plan.id, forKey: .id)
                try container.encode(plan.plannedResult, forKey: .plannedResult)
            }
        }

        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .reps(let plan):
            try container.encode("reps", forKey: .type)
            try encodePlan(plan, in: container)
        case .time(let plan):
            try container.encode("time", forKey: .type)
            try encodePlan(plan, in: container)
        }
    }

    enum CodingKeys: String, CodingKey {
        case type
        case title
        case description
        case exercise
        case id
        case plannedResult
    }
}

extension SetPlanType: SetPlanRepresentable {

    var plannedResultString: String {
        switch self {
        case .reps(let plan):
            return titleForReps(plan: plan)
        case .time(let plan):
            return titleForTime(plan: plan)
        }
    }

    private func titleForReps(plan: SetPlan<Int>) -> String {
        if let plannedReps = plan.plannedResult {
            let localizedWithPlaceholders =
                NSLocalizedString(
                    "setPlan.repSetPlan.primaryLabel",
                    comment: "")
            let localizedWithValue =
                String(
                    format: localizedWithPlaceholders,
                    plannedReps)
            return localizedWithValue
        } else {
            return NSLocalizedString(
                "setPlan.repSetPlan.flexibleRepsLabel",
                comment: "")

        }
    }

    private func titleForTime(plan: SetPlan<Int>) -> String {
        if let plannedSeconds = plan.plannedResult {
            let localizedWithPlaceholders =
                NSLocalizedString(
                    "setPlan.timeSetPlan.primaryLabel",
                    comment: "")
            let localizedWithValue =
                String(
                    format: localizedWithPlaceholders,
                    plannedSeconds)
            return localizedWithValue
        } else {
            return NSLocalizedString(
                "setPlan.timeSetPlan.flexibleDurationLabel",
                comment: "")
        }
    }

    var description: String? {
        return nil
    }

    var exercise: Exercise {
        switch self {
        case .reps(let plan):
            return plan.exercise
        case .time(let plan):
            return plan.exercise
        }
    }

    var id: String {
        switch self {
        case .reps(let plan):
            return plan.id
        case .time(let plan):
            return plan.id
        }
    }
}

extension SetPlanType: PrimarySecondaryTertiaryTextCellDisplayable {
    var primaryText: String? { plannedResultString }
    var secondaryText: String? { nil }
    var tertiaryText: String? { nil }
}

struct NewSetResult<ResultType: Codable & Hashable>: Codable, Hashable {
    var result: ResultType
    var setPlan: SetPlan<ResultType>
}

protocol SetPlanRepresentable: Codable {
    var plannedResultString: String { get }
    var description: String? { get }
    var exercise: Exercise { get }
    var id: String { get }
}
