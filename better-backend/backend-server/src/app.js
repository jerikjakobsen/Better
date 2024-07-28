import express from 'express'
import cors from 'cors'
import bodyParser from 'body-parser'
import {redisSession} from './Redis/RedisInit.js'
import cookieParser from 'cookie-parser'

import routineRouter from './Routes/routine/routineRouter.js'
import homeRouter from './Routes/home/homeRouter.js'
import exerciseRouter from './Routes/exercise/exerciseRouter.js'
import accountRouter from './Routes/account/accountRouter.js'

const app = express()

app.use(express.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(cookieParser())
app.use(redisSession)
app.use(cors())
app.options('*', cors())

app.use('/routine', routineRouter)
app.use('/home', homeRouter)
app.use('/exercise', exerciseRouter)
app.use('/account', accountRouter)

export default app
