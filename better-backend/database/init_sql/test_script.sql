-- Get all exercises for a routine with the day it belongs to and the user it belongs to
-- We also need to mark the exercise as completed or not
SELECT full_routine.*,
        training_session.time_start as training_session_time_start,
        training_session.time_end as training_session_time_end
FROM (
    SELECT exercise.*, 
            day.name as day_name,
            day.day_order as day_order
    FROM (
        SELECT routine_exercise_filtered.*, 
                 exercise.name as exercise_name, 
                 exercise.link as exercise_link,
                 exercise.description as exercise_description
        FROM (
            SELECT routine.name as routine_name,
                    routine.current_routine_number as current_routine_number,
                    routine.creator_user_id as creator_user_id,
                    exercise_id,
                    routine_id,
                    day_id,
                    break_time
            FROM routine
            INNER JOIN routine_exercise
            ON routine.id = routine_exercise.routine_id
            WHERE routine.id = 'c2e8dbbf-72d8-4464-bf9e-5259d2bfc77e' and routine.creator_user_id = 'f2ac4d6c-dc6b-42a2-a373-dc566ec2b44a'
            ) AS routine_exercise_filtered
        INNER JOIN exercise
        ON routine_exercise_filtered.exercise_id = exercise.id
        ) as exercise 
    INNER JOIN day
    ON day.id = exercise.day_id
    ) as full_routine
LEFT JOIN training_session
ON full_routine.current_routine_number = training_session.routine_number AND full_routine.routine_id = training_session.routine_id AND full_routine.routine_id = training_session.routine_id AND full_routine.day_id = training_session.day_id;

-- Get all exercise sessions with all sets with exercise_id = e1, routine_id = r2, day = d3

/*
SELECT exercise_sessions.*,
       set_session.id as set_session_id,
       set_session.start_time as set_start_time,
       set_session.end_time as set_end_time,
       set_session.number_of_reps as set_number_of_reps,
       set_session.weight as set_weight 
FROM (
    SELECT routine_exercise.routine_id as routine_id,
            routine_exercise.exercise_id as exercise_id,
            routine_exercise.day_id as day_id,
            routine_exercise.break_time as break_time,
            exercise_session.training_session_id as training_session_id,
            exercise_session.start_time as start_time,
            exercise_session.end_time as end_time,
            exercise_session.id as exercise_session_id
    FROM routine_exercise
    INNER JOIN exercise_session
    ON exercise_session.routine_exercise_id = routine_exercise.id
    WHERE routine_id = 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e' AND exercise_id = '781ee5b9-84cb-4751-9b43-cc6258e1e967' AND day_id = '4052d78b-d34f-499c-8311-feb1b0e0a416'
    ) as exercise_sessions
INNER JOIN set_session
ON exercise_sessions.exercise_session_id = set_session.exercise_session_id;
*/
