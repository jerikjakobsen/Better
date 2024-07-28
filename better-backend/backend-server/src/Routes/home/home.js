import {get_home_info, update_training_session_streak} from './queries/home.js'

const home = async (req, res) => {
    const {
        user_id
    } = req.body

    if (!user_id) {
        return res.status(400).json({message: "Please include user_id"})
    }

    try {
        const dbRes = await get_home_info(user_id);
        let responseJson = {}
        if (dbRes.rows.length == 0) return res.status(404).json(responseJson)
        let earliest_uncompleted_day = -1
        let last_completed_day = -1
        for (let i = 0; i < dbRes.rows.length; i++) {
            let day = dbRes.rows[i]
            if (earliest_uncompleted_day == -1 && day.training_session_time_start === null) {
               earliest_uncompleted_day = i
            }
            if (day.is_last_session) {
                last_completed_day = i
            }
        }

        let nextDayIdx = (last_completed_day + 1) % dbRes.rows.length
        if (last_completed_day == -1) nextDayIdx = 0
        if (last_completed_day + 1 == dbRes.rows.length && earliest_uncompleted_day != -1) nextDayIdx = earliest_uncompleted_day
        responseJson.next_day = dbRes.rows[nextDayIdx] 
        responseJson.last_session = dbRes.rows[0].last_session_created 
        if (dbRes.rows[0].streak_broken) update_training_session_streak(dbRes.rows[0].last_session_id)
        responseJson.streak_number = dbRes.rows[0].streak_broken ? 0 : dbRes.rows[0].last_session_streak
        return res.status(200).json(responseJson)
    } catch (err) {
        console.error(err)
        return res.status(500).json({message: "Something went wrong!"})
    }
}

export {
    home
}
/*
[
  {
    "is_last_session": true,
    "last_session_created": "2024-04-02T20:57:23.002Z",
    "last_session_streak": 1,
    "last_session_is_end_of_streak": false,
    "days_since_last_session": "0.91685448303240740741",
    "streak_broken": false,
    "training_session_time_start": "2024-04-04T20:57:23.002Z",
    "training_session_time_end": "2024-04-02T21:42:59.002Z",
    "routine_id": "c2e8dbbf-72c8-4464-bf7e-5259d2efc77e",
    "day_id": "4052d78b-d34f-499c-8311-feb1b0e0a416",
    "training_session_routine_number": 2,
    "training_session_current_streak": 1,
    "training_session_is_end_of_streak": false,
    "training_session_created": "2024-04-02T20:57:23.002Z",
    "routine_name": "Routine 1",
    "current_routine_number": 2,
    "break_days": 1,
    "day_name": "Day 1: Arms",
    "day_order": 1
  },
  {
    "is_last_session": false,
    "last_session_created": "2024-04-02T20:57:23.002Z",
    "last_session_streak": 1,
    "last_session_is_end_of_streak": false,
    "days_since_last_session": "0.91685448303240740741",
    "streak_broken": false,
    "training_session_time_start": null,
    "training_session_time_end": null,
    "routine_id": "c2e8dbbf-72c8-4464-bf7e-5259d2efc77e",
    "day_id": "f7873c68-bc26-4010-bd85-9b28a3aeaddc",
    "training_session_routine_number": 2,
    "training_session_current_streak": null,
    "training_session_is_end_of_streak": null,
    "training_session_created": null,
    "routine_name": "Routine 1",
    "current_routine_number": 2,
    "break_days": 1,
    "day_name": "Day 2: Chest",
    "day_order": 2
  },
  {
    "is_last_session": false,
    "last_session_created": "2024-04-02T20:57:23.002Z",
    "last_session_streak": 1,
    "last_session_is_end_of_streak": false,
    "days_since_last_session": "0.91685448303240740741",
    "streak_broken": false,
    "training_session_time_start": null,
    "training_session_time_end": null,
    "routine_id": "c2e8dbbf-72c8-4464-bf7e-5259d2efc77e",
    "day_id": "ad01cd5e-910f-4c76-ab5b-92bc227bae53",
    "training_session_routine_number": 2,
    "training_session_current_streak": null,
    "training_session_is_end_of_streak": null,
    "training_session_created": null,
    "routine_name": "Routine 1",
    "current_routine_number": 2,
    "break_days": 1,
    "day_name": "Day 3: Legs",
    "day_order": 3
  }
]
*/
