import format from "pg-format"
import * as db from "../../../Database/index.js"

const get_home_info = (user_id) => {
    const sqlQuery = format(`
        SELECT (training_session.id IS NOT NULL AND training_session.id = last_session.id) as is_last_session, 
                last_session.id as last_session_id,
                last_session.created as last_session_created,
                last_session.current_streak as last_session_streak,
                last_session.is_end_of_streak as last_session_is_end_of_streak,
                EXTRACT(EPOCH FROM (current_timestamp - last_session.created)) / (86400)  as days_since_last_session,
                EXTRACT(EPOCH FROM (current_timestamp - last_session.created)) / (86400) - .25 > routine.break_days as streak_broken, -- Gives a 6 hour leeway 
                training_session.time_start as training_session_time_start,
                training_session.time_end as training_session_time_end,
                routine.id as routine_id,
                day.id as day_id,
                last_session.routine_number as training_session_routine_number,
                training_session.current_streak as training_session_current_streak,
                training_session.is_end_of_streak as training_session_is_end_of_streak,
                training_session.created as training_session_created,
                routine.name as routine_name,
                routine.current_routine_number as current_routine_number,
                training_session.routine_number as training_session_routine_number,
                routine.break_days as break_days,
                day.name as day_name,
                day.day_order as day_order
        FROM (SELECT *
            FROM training_session
            ORDER BY training_session.created DESC
            LIMIT 1) as last_session
        INNER JOIN routine
        ON routine.id = last_session.routine_id
        FULL JOIN day
        ON routine.id = day.routine_id
        LEFT JOIN training_session
        ON training_session.day_id = day.id AND training_session.routine_number = routine.current_routine_number
        WHERE routine.creator_user_id = %L 
        ORDER BY day.day_order ASC;
        `, user_id);

    try {
        return db.query(sqlQuery)
    } catch (err) {
        throw err
    }
}

const update_training_session_streak = (training_session_id) => {
    const sqlQuery = format(`
        UPDATE training_session
        SET is_end_of_streak = true 
        WHERE id = %L
        `, training_session_id)
    try {
        return db.query(sqlQuery)
    } catch (err) {
        throw err
    }
}


export {
    get_home_info,
    update_training_session_streak 
} 
