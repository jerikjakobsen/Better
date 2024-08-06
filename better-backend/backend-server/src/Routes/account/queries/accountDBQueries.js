import format from "pg-format"
import * as db from "../../../Database/index.js"
import {createInsertQuery} from "../../../Database/utilities.js"
import {v4 as uuidv4} from 'uuid'
import {randomBytes} from 'crypto'

const createAccountDB = async (email, hash_pass, id, salt, name) => {

    try {

        const user = {
            id,
            email,
            hash_pass,
            salt,
            name
        }

        const insertUserQuery = createInsertQuery('users', user)
        await db.query(insertUserQuery)

        return {
            email,
            id: user.id
        }
    } catch (err) {
        throw err
    }
}

const getUserWithEmailDB = async (email) => {
    const sqlQuery = format(`
        SELECT * FROM users
        WHERE email = %L;
        `, email)
    try {
        return db.query(sqlQuery)
    } catch (err) {
        throw err
    }
}

export {
    createAccountDB,
    getUserWithEmailDB
}