import express from 'express'
const router = express.Router()

import {home, day_details } from './routines.js'

router.get('/home', home)

router.get('/day_details', day_details)

export default router
