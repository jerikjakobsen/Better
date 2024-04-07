import express from 'express'
const router = express.Router()

import {home} from './home.js'

router.get('/details', home)

export default router
