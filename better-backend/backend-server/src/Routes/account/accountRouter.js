import express from 'express'

const router = express.Router()

import {login, createAccount} from './accountRoutes.js'

router.post('/login', login)
router.post('/createAccount', createAccount)  

export default router
