import format from "pg-format"
import * as db from "../../../Database/index.js"
import {createInsertQuery, createUpdateQuery} from "../../../Database/utilities.js"
import {v4 as uuidv4} from 'uuid'

const get_routine_info = (routine_id, user_id) => {
    const sqlQuery = format(`
    SELECT routine.name as routine_name,
            routine.current_routine_number as current_routine_number,
            routine.creator_user_id as creator_user_id,
            exercise.id as exercise_id,
            routine.id as routine_id,
            routine_exercise.day_id as day_id,
            break_time,
            exercise.name as exercise_name, 
            exercise.link as exercise_link,
            exercise.description as exercise_description,
            day.name as day_name,
            day.day_order as day_order,
            training_session.time_start as training_session_time_start,
            training_session.time_end as training_session_time_end
    FROM routine
    INNER JOIN routine_exercise
    ON routine.id = routine_exercise.routine_id
    INNER JOIN exercise
    ON exercise.id = routine_exercise.exercise_id
    INNER JOIN day
    ON day.id = routine_exercise.day_id
    LEFT JOIN training_session
    ON routine.current_routine_number = training_session.routine_number AND training_session.routine_id = routine.id AND training_session.day_id = routine_exercise.day_id
    WHERE routine.id = %L and routine.creator_user_id = %L;
    `,
    routine_id, user_id)

    try {
        return db.query(sqlQuery)
    } catch (err) {
        throw err
    }
     
}

const get_training_day_history = (routine_id, day_id) => {
    const sqlQuery = format(`
    SELECT training_session.id as training_session_id,
            training_session.time_start as training_session_time_start,
            training_session.time_end as training_session_time_end,
            training_session.routine_id as routine_id,
            training_session.routine_number as routine_number,
            routine.current_routine_number as current_routine_number,
            exercise.id as exercise_id,
            exercise.name as exercise_name,
            exercise_session.id as exercise_session_id,
            exercise_session.time_start as exercise_session_time_start,
            exercise_session.time_end as exercise_session_time_end,
            set_session.id as set_session_id,
            set_session.time_start as set_session_time_start,
            set_session.time_end as set_session_time_end,
            set_session.number_of_reps as number_of_reps,
            set_session.weight as weight,
            array_agg(muscle_group.name) as muscle_groups
    FROM routine_exercise
    INNER JOIN routine
    ON routine.id = routine_exercise.routine_id
    LEFT JOIN exercise
    ON exercise.id = routine_exercise.exercise_id
    LEFT JOIN exercise_muscle_group
    ON exercise.id = exercise_muscle_group.exercise_id
    LEFT JOIN muscle_group
    ON exercise_muscle_group.muscle_group_id = muscle_group.id
    LEFT JOIN exercise_session
    ON routine_exercise.id = exercise_session.routine_exercise_id
    LEFT JOIN training_session
    ON training_session.id = exercise_session.training_session_id
    LEFT JOIN set_session
    ON exercise_session.id = set_session.exercise_session_id
    WHERE routine_exercise.routine_id = %L AND routine_exercise.day_id = %L AND (training_session.routine_number is NULL OR routine.current_routine_number -10 <= training_session.routine_number)
    GROUP BY exercise.id, set_session.id, training_session.id, routine_exercise.id, exercise_session.id, routine.id
    ORDER BY exercise.id, training_session.routine_number ASC;
  `, routine_id, day_id)
    
    try {
        return db.query(sqlQuery)
    } catch (err) {
        throw err
    }
}

const create_routineDB = async (name, creator_user_id, break_days = 1) => {

   let routine = {
       name,
       creator_user_id,
       break_days,
       id: uuidv4()
   } 
  
   const sqlQuery = createInsertQuery("routine", routine)

   try {
       await db.query(sqlQuery)
       return routine
   } catch (err) {
       throw err
   }
}

const edit_routineDB = async (routine_id, edit_routine) => {
    const sqlQuery = createUpdateQuery("routine", edit_routine, routine_id)

    try {
        await db.query(sqlQuery)
    } catch (err) {
        throw err
    }
}


export {
    get_routine_info,
    get_training_day_history,
    create_routineDB,
    edit_routineDB
}









