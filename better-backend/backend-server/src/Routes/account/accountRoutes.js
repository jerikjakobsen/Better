import { argonHash } from "../../AuthenticationManagement/hash.js"
import { createAccountDB, getUserWithEmailDB } from "./queries/accountDBQueries.js"
import {randomBytes} from 'crypto'
import {v4 as uuidv4} from 'uuid'

const login = async (req, res) => {
    const {email, password} = req.body

    if (!email || !password) {
        return res.status(400).json({"message": "Not all fields included in request"})
    }
    
    try {
        let dbRes = await getUserWithEmailDB(email)
        let user = null
        
        if (dbRes.rows.length === 0) {
            req.session.isAuthenticated = false
            return res.status(404).json({"error": "User not found"})
        } else {
            user = dbRes.rows[0]
        }

        if (user) {
            let hashedPassword = await argonHash(password, user.salt)
            if (user.hash_pass == hashedPassword) {
                req.session.isAuthenticated = true
                req.session.userID = user.id
                return res.status(200).json({"user_id": user.id})
            } else {
                return res.status(404).json({"error": "User not found"})
            }
        } else {
            req.session.isAuthenticated = false
            return res.status(404).json({"error": "User not found"})
        }
    } catch (err) {
        console.error(err)
        return res.status(500).json({"Error": "Something went wrong on our end!"})
    }
}

const createAccount = async (req, res) => {
    
    const {password, email} = req.body

    if (!password || !email) {
        return res.status(400).json({"message": "Not all fields included in request"})
    }

    try {
        const salt = randomBytes(32).toString('base64')        
        const hashedPassword = await argonHash(password, salt)
        const id = uuidv4()

        let user = await createAccountDB(email, hashedPassword, id, salt)
        
        if (user) {
            req.session.isAuthenticated = true
            req.session.userID = user.id
        }
        return res.status(201).json({"user_id": user.id})
    } catch (err) {
        console.log(err)
        return res.status(500).json({"Error": "Something went wrong on our end!"})
    }
}

export {
    login,
    createAccount
}