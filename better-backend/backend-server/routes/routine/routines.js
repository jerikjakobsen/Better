import {get_routine_info, get_training_day_history} from './queries/routines.js'
import {inspect} from 'util'

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
        const dbRes = await get_training_day_history(routine_id, day_id)
        let finalRes = {}
        let exercises = {}
        let day_muscle_groups = new Set()
        let exercise_session_per_training_session = {}
        let day_is_completed = false
        // exercise_id -> { exercise_session -> [set_sessions]}
        for (let session of dbRes.rows) {
            session.muscle_groups.forEach(muscle_group => {
                if (muscle_group) day_muscle_groups.add(muscle_group)
                })
            if (session.current_routine_number = session.routine_number) {
                day_is_completed = true
            }
            if (session.training_session_id && exercise_session_per_training_session[session.training_session_id] == null) {
               let newTrainingSession = {}
               newTrainingSession.time_start = session.training_session_time_start
               newTrainingSession.time_end = session.training_session_time_end  
               newTrainingSession.exercise_sessions = {}
               exercise_session_per_training_session[session.training_session_id] = newTrainingSession
            }
            if (session.exercise_session_id && exercise_session_per_training_session[session.training_session_id].exercise_sessions[session.exercise_session_id] == null) {
                let newExerciseSession = {}
                newExerciseSession.time_start = session.exercise_session_time_start
                newExerciseSession.time_end = session.exercise_session_time_end 
                exercise_session_per_training_session[session.training_session_id].exercise_sessions[session.exercise_session_id] = newExerciseSession
            }
            if (exercises[session.exercise_id] == null) {
                let newExercise = {}
                newExercise.name = session.exercise_name
                newExercise.id = session.exercise_id
                newExercise.sessions = {}
                exercises[session.exercise_id] = newExercise
            }
            if (session.exercise_session_id == null) continue
            if (exercises[session.exercise_id].sessions[session.exercise_session_id] == null) {
                let newExerciseSession = {}
                newExerciseSession.id = session.exercise_session_id
                newExerciseSession.time_start = session.exercise_session_time_start
                newExerciseSession.time_end = session.exercise_session_time_end
                newExerciseSession.routine_number = session.routine_number
                newExerciseSession.sets = []
                exercises[session.exercise_id].sessions[session.exercise_session_id] = newExerciseSession
           } 
           if (session.set_session_id == null) continue
           let newSetSession = {}
           newSetSession.id = session.set_session_id
           newSetSession.time_start = session.set_session_time_start
           newSetSession.time_end = session.set_session_time_end
           newSetSession.weight = session.weight
           newSetSession.num_reps = session.number_of_reps
           exercises[session.exercise_id].sessions[session.exercise_session_id].sets.push(newSetSession)
        }
        exercises = Object.values(exercises)
        exercises.forEach(exercise => {
            exercise.sessions = Object.values(exercise.sessions).sort((a,b) => b.time_start - a.time_start)
        })
        let total_training_time = 0
        let total_break_time = 0
        let exercise_break_count = 0
        let training_sessions_list = Object.values(exercise_session_per_training_session)
        for (let training_sess of training_sessions_list) {
            total_training_time += training_sess.time_start - training_sess.time_end
            let sortedSessions = Object.values(training_sess.exercise_sessions).sort((a,b) => a.time_start - b.time_start)
            for (let i = 1; i < sortedSessions.length; i++) {
                total_break_time += sortedSessions[i].time_start - sortedSessions[i-1].time_end 
                exercise_break_count ++
            }
        }
        finalRes.average_time_to_complete = training_sessions_list.length == 0 ? 0 : total_training_time/training_sessions_list.length
        finalRes.average_break_time = exercise_break_count == 0 ? 0 : total_break_time/exercise_break_count
        finalRes.day_is_completed = day_is_completed
        finalRes.day_muscle_groups = Array.from(day_muscle_groups)
        finalRes.exercises = exercises
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
