# Database Structure

THIS IS OUT OF DATE, PLEASE REFER TO THE INIT SQL FILE

## Routine

* id: String
* name: String
* created: Date

## Exercise

* name
* link
* description
* created

##  ExerciseRecord

* exercise_id: String
* routine_id: String
* created: Date
* reps: Int[] 
* weight: Float

## RoutineExercise

* day: String 
* exercise_id: String
* routine_id: String

**Maps exercises to the routines they belong to along with the day in the routine it is.**

## MuscleGroup

* name: String
* id: String

## ExerciseMuscleGroup

* exercise_id: String
* muscle_group_id: String

## Training

* time_start: Date
* time_end: Date
* routine_id: String
* day: Int
