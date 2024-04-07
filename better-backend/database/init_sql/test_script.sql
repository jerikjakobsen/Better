-- Get all exercises for a routine with the day it belongs to and the user it belongs to
-- We also need to mark the exercise as completed or not, which can be done by checking if it has a start and end time
/*
SELECT routine.name as routine_name,
        routine.current_routine_number as current_routine_number,
        routine.creator_user_id as creator_user_id,
        exercise.id as exercise_id,
        routine.id as routine_id,
        routine_exercise.day_id as day_id,
        break_time,
        exercise.name as exercise_name, 
        exercise.link as exercise_link,
        exercise.description as exercise_description,
        day.name as day_name,
        day.day_order as day_order,
        training_session.time_start as training_session_time_start,
        training_session.time_end as training_session_time_end
FROM routine
INNER JOIN routine_exercise
ON routine.id = routine_exercise.routine_id
INNER JOIN exercise
ON exercise.id = routine_exercise.exercise_id
INNER JOIN day
ON day.id = routine_exercise.day_id
LEFT JOIN training_session
ON routine.current_routine_number = training_session.routine_number AND training_session.routine_id = routine.id AND training_session.day_id = routine_exercise.day_id
WHERE routine.id = 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e' and routine.creator_user_id = 'a8ce98b8-c0a9-4b5a-a605-377e159c320a';
*/
-- Get the set_sessions for every exercise in the routine from the last two training_sessions
/*
SELECT routine.name as routine_name,
        routine.id as r_id,
        routine_exercise.day_id as d_id,
        routine_exercise.exercise_id as e_id,
        training_session.routine_number,
        training_session.id as training_sess_id,
        exercise_session.id as ex_sess_id,
        set_session.id as set_sess_id,
        set_session.time_start as set_start,
        set_session.weight as weight,
        set_session.number_of_reps as reps
FROM routine
INNER JOIN routine_exercise
ON routine.id = routine_exercise.routine_id
INNER JOIN training_session
ON routine.id = training_session.routine_id
INNER JOIN exercise_session
ON exercise_session.training_session_id = training_session.id AND exercise_session.routine_exercise_id = routine_exercise.id
INNER JOIN set_session
ON set_session.exercise_session_id = exercise_session.id
WHERE routine.id = 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e' AND routine_exercise.day_id = '4052d78b-d34f-499c-8311-feb1b0e0a416' AND routine.current_routine_number - 1 <= training_session.routine_number;
*/
-- get the top 10 most recent training sessions along with the exercise sessions for each training session
/*
SELECT training_session.id as training_session_id,
        training_session.time_start as training_session_time_start,
        training_session.time_end as training_session_time_end,
        training_session.routine_id as routine_id,
        training_session.routine_number as routine_number,
        exercise_session.id as exercise_session_id,
        exercise_session.time_start as exercise_session_time_start,
        exercise_session.time_end as exercise_session_time_end,
        set_session.id as set_session_id,
        set_session.time_start as set_session_time_start,
        set_session.time_end as set_session_time_end,
        set_session.number_of_reps as number_of_reps,
        set_session.weight as weight,
        array_agg(muscle_group.name) as muscle_groups
FROM training_session
INNER JOIN routine
ON training_session.routine_id = routine_id
INNER JOIN exercise_session
ON training_session.id = exercise_session.training_session_id
INNER JOIN set_session
ON set_session.exercise_session_id = exercise_session.id
INNER JOIN routine_exercise
ON routine_exercise.id = exercise_session.routine_exercise_id
INNER JOIN exercise_muscle_group
ON exercise_muscle_group.exercise_id = routine_exercise.exercise_id
INNER JOIN muscle_group
ON exercise_muscle_group.muscle_group_id = muscle_group.id
WHERE routine.current_routine_number - 10 <= training_session.routine_number AND routine.id = 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e' AND training_session.day_id = '4052d78b-d34f-499c-8311-feb1b0e0a416'
GROUP BY training_session.id, exercise_session.id, set_session_id;

SELECT training_session.id as training_session_id,
        training_session.time_start as training_session_time_start,
        training_session.time_end as training_session_time_end,
        training_session.routine_id as routine_id,
        training_session.routine_number as routine_number,
        exercise.id as exercise_id,
        exercise.name as exercise_name,
        exercise_session.id as exercise_session_id,
        exercise_session.time_start as exercise_session_time_start,
        exercise_session.time_end as exercise_session_time_end,
        set_session.id as set_session_id,
        set_session.time_start as set_session_time_start,
        set_session.time_end as set_session_time_end,
        set_session.number_of_reps as number_of_reps,
        set_session.weight as weight,
        array_agg(muscle_group.name) as muscle_groups
FROM routine_exercise
INNER JOIN routine
ON routine.id = routine_exercise.routine_id
INNER JOIN exercise
ON exercise.id = routine_exercise.exercise_id
LEFT JOIN exercise_muscle_group
ON exercise.id = exercise_muscle_group.exercise_id
LEFT JOIN muscle_group
ON exercise_muscle_group.muscle_group_id = muscle_group.id
LEFT JOIN exercise_session
ON routine_exercise.id = exercise_session.routine_exercise_id
LEFT JOIN training_session
ON training_session.id = exercise_session.training_session_id
LEFT JOIN set_session
ON exercise_session.id = set_session.exercise_session_id
WHERE routine_exercise.routine_id = 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e' AND routine_exercise.day_id = 'f7873c68-bc26-4010-bd85-9b28a3aeaddc' AND (training_session.routine_number is NULL OR routine.current_routine_number -10 <= training_session.routine_number)
GROUP BY exercise.id, set_session.id, training_session.id, routine_exercise.id, exercise_session.id, routine.id
ORDER BY exercise.id, training_session.routine_number ASC;

SELECT exercise.name
FROM routine_exercise
LEFT JOIN routine
ON routine.id = routine_exercise.routine_id
LEFT JOIN exercise
ON exercise.id = routine_exercise.exercise_id
LEFT JOIN exercise_muscle_group
ON exercise.id = exercise_muscle_group.exercise_id
LEFT JOIN muscle_group
ON exercise_muscle_group.muscle_group_id = muscle_group.id
WHERE routine_exercise.routine_id = 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e' AND routine_exercise.day_id = 'f7873c68-bc26-4010-bd85-9b28a3aeaddc';
*/
-- get all muscle groups for every exercise in the routine
/*
SELECT exercises_with_muscle_group_id.*,
        muscle_group.name as muscle_group_name
FROM (
    SELECT routine_exercise.exercise_id as exercise_id,
            exercise_muscle_group.muscle_group_id as muscle_group_id
    FROM routine_exercise
    INNER JOIN exercise_muscle_group
    ON routine_exercise.exercise_id = exercise_muscle_group.exercise_id
    WHERE routine_id = 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e'
) AS exercises_with_muscle_group_id
INNER JOIN muscle_group
ON exercises_with_muscle_group_id.muscle_group_id = muscle_group.id;
*/
/*
SELECT training_routine_exercise_session.*,
        set_session.id as set_session_id,
        set_session.time_start as set_session_time_start,
        set_session.time_end as set_session_time_end,
        set_session.number_of_reps as number_of_reps,
        set_session.weight as weight
FROM ( 
    SELECT training_routine.*,
            exercise_session.id as exercise_session_id,
            exercise_session.time_start as exercise_session_time_start,
            exercise_session.time_end as exercise_session_time_end,
            exercise_session.routine_exercise_id as exercise_session_routine_exercise_id
    FROM ( 
        SELECT training_session.id as training_session_id,
                training_session.time_start as training_session_time_start,
                training_session.time_end as training_session_time_end,
                training_session.routine_id as routine_id,
                training_session.routine_number as routine_number,
                training_session.day_id as day_id,
                routine.current_routine_number as current_routine_number
        FROM training_session
        INNER JOIN routine
        ON routine.id = training_session.routine_id
        WHERE routine.id = 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e' AND training_session.day_id = '4052d78b-d34f-499c-8311-feb1b0e0a416' AND training_session.routine_number >= routine.current_routine_number - 1
    ) AS training_routine
    INNER JOIN exercise_session
    ON exercise_session.training_session_id = training_routine.training_session_id
) as training_routine_exercise_session
INNER JOIN set_session
ON set_session.exercise_session_id = training_routine_exercise_session.exercise_session_id
*/
SELECT (training_session.id IS NOT NULL AND training_session.id = last_session.id) as is_last_session, 
        last_session.created as last_session_created,
        last_session.current_streak as last_session_streak,
        last_session.is_end_of_streak as last_session_is_end_of_streak,
        EXTRACT(EPOCH FROM (current_timestamp - last_session.created)) / (86400)  as days_since_last_session,
        EXTRACT(EPOCH FROM (current_timestamp - last_session.created)) / (86400) - .25 > routine.break_days as streak_broken, -- Gives a 6 hour leeway 
        training_session.time_start as training_session_time_start,
        training_session.time_end as training_session_time_end,
        training_session.routine_id as routine_id,
        training_session.day_id as day_id,
        last_session.routine_number as training_session_routine_number,
        training_session.current_streak as training_session_current_streak,
        training_session.is_end_of_streak as training_session_is_end_of_streak,
        training_session.created as training_session_created,
        routine.name as routine_name,
        routine.current_routine_number as current_routine_number,
        training_session.routine_number as training_session_routine_number,
        routine.break_days as break_days,
        day.name as day_name,
        day.day_order as day_order
FROM (SELECT *
    FROM training_session
    ORDER BY training_session.created DESC
    LIMIT 1) as last_session
INNER JOIN routine
ON routine.id = last_session.routine_id
FULL JOIN day
ON routine.id = day.routine_id
LEFT JOIN training_session
ON training_session.day_id = day.id AND training_session.routine_number = routine.current_routine_number
WHERE routine.creator_user_id = 'a8ce98b8-c0a9-4b5a-a605-377e159c320a' 
ORDER BY day.day_order ASC;

