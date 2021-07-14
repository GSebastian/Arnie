//
//  Data.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 13/04/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Foundation

protocol NewDataProvider {
    var workouts: [WorkoutPlan] { get }
}

class NewDataService: NewDataProvider, ObservableObject {

    @Published var workouts: [WorkoutPlan] = [
        WorkoutPlan(name: "Pull day",
                       description: "Day 1 of my pull and push routine with elastic bands",
                       plannedSetGroups: [
                        SetPlanGrouping(
                            name: nil,
                            sets: [
                                .reps(plan: SetPlan(exercise: .pullUp, plannedResult: 8)),
                                .reps(plan: SetPlan(exercise: .seatedRowBlackBand, plannedResult: 20)),
                                .reps(plan: SetPlan(exercise: .frontBackStraightArmRowRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .frontSideStraightArmRowRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .backExtension, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .hammerCurlBlackBand, plannedResult: 15)),
                            ]
                        ),
                        SetPlanGrouping(
                            name: nil,
                            sets: [
                                .reps(plan: SetPlan(exercise: .pullUp, plannedResult: 8)),
                                .reps(plan: SetPlan(exercise: .seatedRowBlackBand, plannedResult: 20)),
                                .reps(plan: SetPlan(exercise: .frontBackStraightArmRowRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .frontSideStraightArmRowRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .backExtension, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .hammerCurlBlackBand, plannedResult: 15)),
                            ]
                        ),
                        SetPlanGrouping(
                            name: nil,
                            sets: [
                                .reps(plan: SetPlan(exercise: .pullUp, plannedResult: 8)),
                                .reps(plan: SetPlan(exercise: .seatedRowBlackBand, plannedResult: 20)),
                                .reps(plan: SetPlan(exercise: .frontBackStraightArmRowRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .frontSideStraightArmRowRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .backExtension, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .hammerCurlBlackBand, plannedResult: 15)),
                            ]
                        )
            ]
        ),
        WorkoutPlan(name: "Push day",
                       description: "Day 2 of my pull and push routine with elastic bands",
                       plannedSetGroups: [
                        SetPlanGrouping(
                            name: nil,
                            sets: [
                                .reps(plan: SetPlan(exercise: .pushUp, plannedResult: 12)),
                                .reps(plan: SetPlan(exercise: .squatBlackBand, plannedResult: 20)),
                                .reps(plan: SetPlan(exercise: .tipToesBlackBand, plannedResult: 50)),
                                .reps(plan: SetPlan(exercise: .shoulderPressVerticalRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .tricepsExtensionBlackBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .highLowChestCrossoversRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .abTwistRedBand, plannedResult: 15)),
                            ]
                        ),
                        SetPlanGrouping(
                            name: nil,
                            sets: [
                                .reps(plan: SetPlan(exercise: .pushUp, plannedResult: 12)),
                                .reps(plan: SetPlan(exercise: .squatBlackBand, plannedResult: 20)),
                                .reps(plan: SetPlan(exercise: .tipToesBlackBand, plannedResult: 50)),
                                .reps(plan: SetPlan(exercise: .shoulderPressVerticalRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .tricepsExtensionBlackBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .highLowChestCrossoversRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .abTwistRedBand, plannedResult: 15)),
                            ]
                        ),
                        SetPlanGrouping(
                            name: nil,
                            sets: [
                                .reps(plan: SetPlan(exercise: .pushUp, plannedResult: 12)),
                                .reps(plan: SetPlan(exercise: .squatBlackBand, plannedResult: 20)),
                                .reps(plan: SetPlan(exercise: .tipToesBlackBand, plannedResult: 50)),
                                .reps(plan: SetPlan(exercise: .shoulderPressVerticalRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .tricepsExtensionBlackBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .highLowChestCrossoversRedBand, plannedResult: 15)),
                                .reps(plan: SetPlan(exercise: .abTwistRedBand, plannedResult: 15)),
                            ]
                        ),
            ]
        ),
        WorkoutPlan(name: "Short day",
                       description: "For quick testing",
                       plannedSetGroups: [
                        SetPlanGrouping(
                            name: nil,
                            sets: [
                                .reps(plan: SetPlan(exercise: .pullUp, plannedResult: 8)),
                                .time(plan: SetPlan(exercise: .plank, plannedResult: 20)),
                            ]
                        ),
                        SetPlanGrouping(
                            name: nil,
                            sets: [
                                .reps(plan: SetPlan(exercise: .pullUp, plannedResult: 8)),
                                .time(plan: SetPlan(exercise: .plank, plannedResult: 20)),
                            ]
                        )
            ]
        )
    ]

    @Published var pastWorkouts: [WorkoutResult] = [
        WorkoutResult(
            name: "Pull day",
            description: nil,
            setGroupResults: [
                SetPlanGroupingResult(
                    breakLength: 24,
                    setResults: [
                        SetResultType.reps(
                            setResult: NewSetResult(
                                result: 33,
                                setPlan: SetPlan(exercise: .chinUp, plannedResult: nil)))
                    ])
        ])
    ]

    @Published var samplePastWorkout: WorkoutResult = WorkoutResult(
        name: "Pull day",
        description: nil,
        setGroupResults: [
            SetPlanGroupingResult(
                breakLength: 24,
                setResults: [
                    SetResultType.reps(
                        setResult: NewSetResult(
                            result: 33,
                            setPlan: SetPlan(exercise: .chinUp, plannedResult: nil))),
                    SetResultType.time(
                        setResult: NewSetResult(
                            result: 50,
                            setPlan: SetPlan(exercise: .plank, plannedResult: nil))),
                    SetResultType.reps(
                        setResult: NewSetResult(
                            result: 20,
                            setPlan: SetPlan(exercise: .seatedRowBlackBand, plannedResult: nil)))
            ])
    ])
}

extension Exercise {

    static var pushUp = Exercise(name: "Pushup", description: nil)
    static var highLowChestCrossoversRedBand = Exercise(name: "High to Low Chest Crossovers - Red Band", description: nil)

    static var plank = Exercise(name: "Plank", description: nil)
    static var plankSide = Exercise(name: "Side Plank", description: nil)

    static var squatBlackBand = Exercise(name: "Squat - Black Band", description: nil)
    static var tipToesBlackBand =
        Exercise(name: "Tip Toes - Black Band",
                 description: "Standing on tip toes with a black rubber band")

    static var seatedRowBlackBand = Exercise(name: "Seated Row - Black Band", description: nil)
    static var backExtension = Exercise(name: "Back Extension", description: nil)
    static var frontBackStraightArmRowRedBand =
        Exercise(name: "Front to Back Straight Arm Row - Red Band",
                 description: nil)
    static var frontSideStraightArmRowRedBand =
        Exercise(name: "Front to Side Straight Arm Row - Red Band",
                 description: nil)
    static var pullUp = Exercise(name: "Wide Grip Pullup", description: nil)
    static var chinUp = Exercise(name: "Chinup", description: nil)

    static var shoulderPressVerticalRedBand =
        Exercise(name: "Vertical Shoulder Press - Red Band",
                 description: nil)

    static var tricepsExtensionBlackBand =
        Exercise(name: "Triceps Extension - Black Band",
                 description: nil)

    static var hammerCurlBlackBand =
        Exercise(name: "Hammer Curl - Black Band",
                 description: nil)

    static var abCrunch = Exercise(name: "Ab Crunch", description: nil)
    static var abTwistRedBand = Exercise(name: "Ab Twist - Red Band", description: nil)
}
