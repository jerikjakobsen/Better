import express from 'express'
import AuthenticateRequest from '../../AuthenticationManagement/AuthenticateRequestMiddleware.js'

const router = express.Router()
router.use(AuthenticateRequest)

import {createExercise, editExercise} from './exerciseRoutes.js'

router.post('/create', createExercise)
router.post('/edit', editExercise)  

export default router
