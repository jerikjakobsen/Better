import express from 'express'
const router = express.Router()

import {createExercise} from './exerciseRoutes.js'

router.post('/create', createExercise)

export default router
