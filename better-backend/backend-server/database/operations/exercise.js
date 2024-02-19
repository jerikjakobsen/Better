import {createInsertQuery} from "../utilities.js"
import * as db from "../index.js"

const addExercise = async (routine_id, name, link, description, muscleGroups) => {
    const exercise = {
        name,
        description, 
        link
    }

    const res = await db.query(createInsertQuery)

    
}

