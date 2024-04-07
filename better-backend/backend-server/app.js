import express from 'express'
import cors from 'cors'
import routineRouter from './routes/routine/routineRouter.js'
import homeRouter from './routes/home/homeRouter.js'

const app = express()

app.use(express.json())
app.use(cors())
app.options('*', cors())

app.use('/routine', routineRouter)
app.use('/home', homeRouter)

export default app
