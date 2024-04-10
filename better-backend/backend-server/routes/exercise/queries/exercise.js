import {createInsertQuery, createUpdateQuery} from "../../../database/utilities.js"
import format from "pg-format"
import * as db from "../../../database/index.js"
import {v4 as uuidv4} from 'uuid'

const createExerciseDB = async (name, creator_id = null, link = "", description = "", muscleGroups = [], default_break_time = 0, is_official = false) => {
    const exercise = {
        name,
        description, 
        link,
        id: uuidv4(),
        creator_user_id: creator_id,
        default_break_time,
        is_official
    }
     
    try {
        const insertExerciseQuery = createInsertQuery('exercise', exercise)
        console.log(insertExerciseQuery)
        await db.query(insertExerciseQuery)
        console.log(muscleGroups)
        for (const m_id of muscleGroups) {
            console.log(m_id) 
            const exercise_muscle = {
                exercise_id: exercise.id,
                muscle_group_id: m_id
            }
            const insertExerciseMuscleQuery = createInsertQuery('exercise_muscle_group', exercise_muscle)
            console.log(insertExerciseMuscleQuery)
            await db.query(insertExerciseMuscleQuery)
        }
        exercise.muscle_groups = muscleGroups
        return exercise
    } catch (err) {
        throw err
    }

}

const editExerciseDB = async (exercise_id, edit_exercise) => {
    if (edit_exercise.muscle_groups) {
        let deleteQuery = format(`
            DELETE FROM exercise_muscle_group
            WHERE exercise_id = %L;
        `, exercise_id)
        await db.query(deleteQuery)
        for (const m_id of edit_exercise.muscle_groups) {
            const exercise_muscle = {
                exercise_id,
                muscle_group_id: m_id
            }
            const insertExerciseMuscleQuery = createInsertQuery('exercise_muscle_group', exercise_muscle)
            await db.query(insertExerciseMuscleQuery)
        }
    }
    delete edit_exercise.muscle_groups
    console.log(edit_exercise) 
    if (Object.keys(edit_exercise).length > 0) {
        let updateQuery = createUpdateQuery("exercise", edit_exercise, exercise_id)
        console.log(updateQuery)
        await db.query(updateQuery)
    }  
}

const addExerciseToRoutineDB = async (exercise_id, routine_id, day_id, break_time = 0) => {
    let routine_exercise = {
        id: uuidv4(),
        exercise_id,
        routine_id,
        day_id,
        break_time
    }
    try { 
        const addExerciseToRoutineQuery = createInsertQuery('routine_exercise', routine_exercise)

        await db.query(addExerciseToRoutineQuery)

        return routine_exercise
    } catch (err) {
        throw err
    }
}

export {
    createExerciseDB,
    addExerciseToRoutineDB,
    editExerciseDB 
}

