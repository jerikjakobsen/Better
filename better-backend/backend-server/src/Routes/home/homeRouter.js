import express from 'express'
import AuthenticateRequest from '../../AuthenticationManagement/AuthenticateRequestMiddleware.js'

const router = express.Router()
router.use(AuthenticateRequest)

import {home} from './home.js'

router.get('/details', home)

export default router
