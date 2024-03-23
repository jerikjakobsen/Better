import express from 'express'
import cors from 'cors'
import routineRouter from './routes/routine/routineRouter.js'

const app = express()

app.use(express.json())
app.use(cors())
app.options('*', cors())

app.use('/routine', routineRouter)

export default app
