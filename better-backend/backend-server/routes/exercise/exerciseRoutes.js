import {addExercise} from '../../database/operations/exercise.js'

const createExercise = async (req, res) => {
    const {
        name,
        description,
        link,
        muscle_groups
    } = req.body

    if (!name) {
        return res.status(400).json({"message": "Please include name in the body"})
    }

    try {
        await addExercise(name, link, description, muscle_groups)
        res.status(201).json({message: "Success"})
    } catch (err) {
        console.error(err)
        res.status(500).json({message: "Error"})
    }
}

export {
    createExercise
}
