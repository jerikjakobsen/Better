import {get_routine_info, get_training_sessions} from './queries/routines.js'

const home = async (req, res) => {
    const {
        routine_id,
        user_id
    } = req.body

    if (!routine_id || !user_id) {
        return res.status(400).json({message: "Please include routine_id and user_id"})
    }
    try {
        const dbRes = await get_routine_info(routine_id, user_id)
        let finalRes = {}
        if (dbRes.rows.length === 0) {
            return res.status(404).json({message: "Nothing found"})
        }
        finalRes.routine_name = dbRes.rows[0].routine_name
        finalRes.routine_number = dbRes.rows[0].current_routine_number 
        finalRes.routine_id = dbRes.rows[0].routine_id

        let days = {}
        for (let row of dbRes.rows) {
            if (days[row.day_id] == null) {
                let new_day = {}
                new_day.day_id = row.day_id
                new_day.day_name = row.day_name
                new_day.day_order = row.day_order
                new_day.time_start = row.training_session_time_start
                new_day.time_end = row.training_session_time_end
                new_day.is_completed = row.training_session_time_start != null
                new_day.exercises = []
                days[row.day_id] = new_day
            }
            let exercise = {}
            exercise.name = row.exercise_name
            exercise.id = row.exercise_id
            exercise.description = row.exercise_description
            exercise.link = row.link
            days[row.day_id].exercises.push(exercise)
        }
        finalRes.days = Object.values(days).sort((a, b) => a.day_order - b.day_order)
        return res.status(200).json(finalRes)
    } catch (err) {
        console.error(err)
        return res.status(500).json({message: "Something went wrong!"})
    }
}

const day_details = async (req, res) => {
    const {
       routine_id,
       day_id
    } = req.body

    if (!routine_id || !day_id) {
        return res.status(400).json({message: "Please include routine_id and day_id"})
    }

    try {
        const dbRes = await get_training_sessions(routine_id, day_id)
        let finalRes = {}
        let training_sessions = {}
        let day_muscle_groups = new Set()
        for (let session of dbRes.rows) {
            if (training_sessions[session.training_session_id] == null) {
                let newTrainingSession = {}
                newTrainingSession.id = session.training_session_id
                newTrainingSession.time_start = session.training_session_time_start
                newTrainingSession.time_end = session.training_session_time_end
                newTrainingSession.routine_id = routine_id
                newTrainingSession.day_id = day_id
                newTrainingSession.routine_number = session.routine_number
                newTrainingSession.exercise_sessions =  {}
                training_sessions[session.training_session_id] = newTrainingSession
            }
            day_muscle_groups.add(session.muscle_group_name)
            if (training_sessions[session.training_session_id].exercise_sessions[session.exercise_session_id] == null) {
                let newExerciseSession = {}
                newExerciseSession.exercise_id = session.exercise_id
                newExerciseSession.time_start = session.exercise_session_time_start
                newExerciseSession.time_end = session.exercise_session_time_end
                newExerciseSession.muscle_groups = new Set([session.muscle_group_name])
                training_sessions[session.training_session_id].exercise_sessions[session.exercise_session_id] = newExerciseSession
            } else {
                training_sessions[session.training_session_id].exercise_sessions[session.exercise_session_id].muscle_groups.add(session.muscle_group_name) 
            }
        }
        training_sessions = Object.values(training_sessions).sort((a,b) => b.routine_number - a.routine_number)
        for (let sess of training_sessions) {
          sess.exercise_sessions = Object.values(sess.exercise_sessions) 
          for (let ex_sess of sess.exercise_sessions) {
              ex_sess.muscle_groups = Array.from(ex_sess.muscle_groups)
          }
        }
        let total_training_time = 0
        let total_time_between_exercises = 0
        let total_exercises_done = 0 
        for (let session of training_sessions) {
            total_training_time += session.time_end - session.time_start
            total_exercises_done += session.exercise_sessions.length
            for (let i = 1; i < session.exercise_sessions.length; i ++) {
                total_time_between_exercises += session.exercise_sessions[i].time_start - session.exercise_sessions[i-1].time_end
            }
        }
        finalRes.day_muscle_groups = Array.from(day_muscle_groups)
        finalRes.average_training_time = total_training_time/training_sessions.length
        finalRes.average_exercise_session_break = total_exercises_done > 1 ? total_time_between_exercises/(total_exercises_done-1) : 0
        finalRes.training_sessions = training_sessions
        
        return res.status(200).json(finalRes)

    } catch (err) {
        console.error(err)
        return res.status(500).json({message: "Something went wrong!"})
    }

}






export {
    home,
    day_details
}
