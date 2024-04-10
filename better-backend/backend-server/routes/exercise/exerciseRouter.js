import express from 'express'
const router = express.Router()

import {createExercise, editExercise} from './exerciseRoutes.js'

router.post('/create', createExercise)
router.post('/edit', editExercise)  

export default router
