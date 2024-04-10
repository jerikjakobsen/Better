import {createInsertQuery} from "../utilities.js"
import format from "pg-format"
import * as db from "../index.js"
import {v4 as uuidv4} from 'uuid'

const addExercise = async (name, creator_id, link = "", description = "", muscleGroups = []) => {
    const e_id = uuidv4()
    const exercise = {
        name,
        description, 
        link,
        id: e_id ,
        creator_user_id: creator_id
    }
     
    try {
        const insertExerciseQuery = createInsertQuery('exercise', exercise)
        console.log(insertExerciseQuery)
        await db.query(insertExerciseQuery)
        
        for (const m_id in muscleGroups) {
            const exercise_muscle = {
                exercise_id: e_id,
                muscle_group_id: m_id
            }
            const insertExerciseMuscleQuery = createInsertQuery('exercise_muscle_group', exercise_muscle)
            await db.query(insertExerciseMuscleQuery)
        }
    } catch (err) {
        throw err
    }

}

const addExerciseToRoutine = async (exercise_id, routine_id, day_id, break_time = 0) => {
    const addExerciseToRoutineQuery = createInsertQuery('routine_exercise', {
        exercise_id,
        routine_id,
        day_id,
        break_time
    })
    
    return await db.query(addExerciseToRoutineQuery)
}

const getExercises = async (routine_id) => {
   if (!routine_id) {
       return await db.query('SELECT * FROM exercise;')
   }
   // # TODO
   return await db.query(format(`
        SELECT * FROM (SELECT * FROM routine_exercise
            WHERE routine_id = %L
            LEFT JOIN exercise
            ON routine_exercise.exercise_id = exercise.id) as exercise 
        LEFT JOIN day
        ON day.id = exercise.day_id;
`), routine_id)

}

export {
    addExercise,
    addExerciseToRoutine,
    getExercises
}
