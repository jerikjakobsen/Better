import {createExerciseDB, addExerciseToRoutineDB, editExerciseDB} from './queries/exercise.js'

const createExercise = async (req, res) => {
    const {
        name,
        description,
        link,
        muscle_groups,
        creator_user_id,
        default_break_time,
        is_official
    } = req.body

    if (!name) {
        return res.status(400).json({"message": "Please include name in the body"})
    }

    try {
        let exercise = await createExerciseDB(name, creator_user_id, link, description, muscle_groups, default_break_time, is_official)
        return res.status(201).json({exercise})
    } catch (err) {
        console.error(err)
        return res.status(500).json({message: "Error"})
    }
}

const editExercise = async (req, res) => {
    const {
        id, 
        name,
        description,
        link,
        muscle_groups,
        creator_user_id,
        default_break_time,
        is_official
    } = req.body

    if (!id) {
        return res.status(400).json({"message": "Please include the exercise id in the body"})
    }

    let edit_exercise = {}

    if (name) edit_exercise.name = name
    if (description) edit_exercise.description = description
    if (link) edit_exercise.link = link
    if (muscle_groups) edit_exercise.muscle_groups = muscle_groups
    if (creator_user_id) edit_exercise.creator_user_id = creator_user_id
    if (default_break_time) edit_exercise.default_break_time = default_break_time  
    if (is_official) edit_exercise.is_official = is_official
    
    try {
       await editExerciseDB(id, edit_exercise) 
       return res.status(201).json({"message": "Success!"})
    } catch (err) {
        console.error(err)
        return res.status(500).json({"message": "Error"})
    }

}

const addExerciseToRoutine = async (req, res) => {
    const {
        exercise_id,
        routine_id,
        day_id,
        break_time
    } = req.body
    
    if (!exercise_id || !routine_id || !day_id) {
        return res.status(400).json({"message": "Please include exercise_id, routine_id and day_id in the body"})
    } 
    
    try {
        let routine_exercise = await addExerciseToRoutineDB(exercise_id, routine_id, day_id, break_time)
        return res.status(201).json({routine_exercise})
       } catch (err) {
           console.error(err)
           return res.status(500).json({message: "Error"}) 
       }
}

export {
    createExercise,
    addExerciseToRoutine,
    editExercise 
}
