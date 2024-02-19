# Database Structure

## Routine

* id: String
* name: String
* created: Date

## Exercise

* name
* link

##  ExerciseRecord

* exercise_id: String
* routine_id: String
* date: Date
* reps: String
* weight: Float

## RoutineExercise

* day: Int
* exercise_id: String
* routine_id: String

**Maps exercises to the routines they belong to alonf with the day in the routine it is.**

## MuscleGroup

* name: String
* id: String

## ExerciseMuscleGroup

* exercise_id: String
* muscle_group_id: String
