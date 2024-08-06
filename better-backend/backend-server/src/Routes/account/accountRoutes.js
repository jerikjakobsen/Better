import { argonHash } from "../../AuthenticationManagement/hash.js"
import { checkEmail, checkPassword } from "./AccountRequirements.js"
import { createAccountDB, getUserWithEmailDB } from "./queries/accountDBQueries.js"
import {randomBytes} from 'crypto'
import {v4 as uuidv4} from 'uuid'

const login = async (req, res) => {
    const {email, password} = req.body

    if (!email || !password) {
        return res.status(400).json({"error": "Please include email and password"})
    }

    const lowerEmail = email.toLowerCase()
    if (!checkEmail(lowerEmail)) {
        return res.status(400).json({"error": "email Invalid credentials"})
    }
    
    if (checkPassword(password).length > 0) {
        return res.status(400).json({"error": "password Invalid credentials"})
    }
    
    try {
        let dbRes = await getUserWithEmailDB(lowerEmail)
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
    
    const {password, email, name} = req.body

    if (!password || !email || !name) {
        return res.status(400).json({"message": "Not all fields included in request"})
    }

    const lowerEmail = email.toLowerCase()
    let responseJSON = {issues: []}
    if (!checkEmail(lowerEmail)) {
        responseJSON["issues"].push("Email is invalid")
    }
    
    let passwordIssues = checkPassword(password)
    if (passwordIssues.length > 0) {
        responseJSON["issues"] = responseJSON["issues"].concat(passwordIssues)
    }

    if (Object.keys(responseJSON["issues"]).length > 0) {
        return res.status(400).json(responseJSON)
    }

    try {
        const salt = randomBytes(32).toString('base64')        
        const hashedPassword = await argonHash(password, salt)
        const id = uuidv4()

        let user = await createAccountDB(lowerEmail, hashedPassword, id, salt, name)
        
        if (user) {
            req.session.isAuthenticated = true
            req.session.userID = user.id
        }
        return res.status(201).json({"user_id": user.id})
    } catch (err) {
        console.error(err)
        return res.status(500).json({"Error": "Something went wrong on our end!"})
    }
}

export {
    login,
    createAccount
}