import express from 'express'
import AuthenticateRequest from '../../AuthenticationManagement/AuthenticateRequestMiddleware.js'

const router = express.Router()

router.use(AuthenticateRequest)

import {home, day_details, createRoutine, editRoutine} from './routines.js'

router.get('/home', home)
router.get('/day_details', day_details)
router.post('/create', createRoutine)
router.post('/edit', editRoutine)

export default router