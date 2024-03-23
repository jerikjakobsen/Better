-- Get all exercises for a routine with the day it belongs to and the user it belongs to
-- We also need to mark the exercise as completed or not, which can be done by checking if it has a start and end time
/*
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
*/
-- Get all exercise sessions with all sets with exercise_id = e1, routine_id = r2, day = d3

/*
SELECT exercise_sessions.*,
       set_session.id as set_session_id,
       set_session.time_start as set_start_time,
       set_session.time_end as set_end_time,
       set_session.number_of_reps as set_number_of_reps,
       set_session.weight as set_weight 
FROM (
    SELECT routine_exercise.routine_id as routine_id,
            routine_exercise.exercise_id as exercise_id,
            routine_exercise.day_id as day_id,
            routine_exercise.break_time as break_time,
            exercise_session.training_session_id as training_session_id,
            exercise_session.time_start as start_time,
            exercise_session.time_end as end_time,
            exercise_session.id as exercise_session_id
    FROM routine_exercise
    INNER JOIN exercise_session
    ON exercise_session.routine_exercise_id = routine_exercise.id
    WHERE routine_id = 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e' AND exercise_id = '781ee5b9-84cb-4751-9b43-cc6258e1e967' AND day_id = '4052d78b-d34f-499c-8311-feb1b0e0a416'
    ) as exercise_sessions
INNER JOIN set_session
ON exercise_sessions.exercise_session_id = set_session.exercise_session_id;
*/

-- get the top 10 most recent training sessions along with the exercise sessions for each training session
SELECT with_muscle_group_connections.*,
        muscle_group.name as muscle_group_name
FROM (
    SELECT without_muscle_groups.*,
            exercise_muscle_group.muscle_group_id as muscle_group_id
    FROM (
        SELECT sessions.*,
                routine_exercise.exercise_id as exercise_id
        FROM (
            SELECT training_session_a.time_start as training_session_time_start,
                    training_session_a.time_end as training_session_time_end,
                    training_session_a.routine_id as routine_id,
                    training_session_a.day_id as day_id,
                    training_session_a.training_session_id as training_session_id,
                    training_session_a.routine_number as routine_number,
                    exercise_session.time_start as exercise_session_time_start,
                    exercise_session.time_end as exercise_session_time_end,
                    exercise_session.routine_exercise_id as routine_exercise_id,
                    exercise_session.id as exercise_session_id
            FROM (
                SELECT routine.current_routine_number as current_routine_number,
                        training_session.id as training_session_id,
                        training_session.time_start as time_start,
                        training_session.time_end as time_end,
                        training_session.routine_id as routine_id,
                        training_session.day_id as day_id,
                        training_session.routine_number as routine_number
                FROM training_session
                INNER JOIN routine
                ON training_session.routine_id = routine.id
                WHERE routine.current_routine_number - 10 <= training_session.routine_number AND routine_id = 'c2e8dbbf-72c8-4464-bf7e-5259d2efc77e' AND day_id = '4052d78b-d34f-499c-8311-feb1b0e0a416'
                ) AS training_session_a
            INNER JOIN exercise_session
            ON training_session_a.training_session_id = exercise_session.training_session_id
            ORDER BY training_session_time_start DESC, exercise_session_time_start ASC
            ) AS sessions
        INNER JOIN routine_exercise
        ON sessions.routine_exercise_id = routine_exercise.id
        ) AS without_muscle_groups
    INNER JOIN exercise_muscle_group
    ON without_muscle_groups.exercise_id = exercise_muscle_group.exercise_id
    ) AS with_muscle_group_connections
INNER JOIN muscle_group
ON muscle_group.id = with_muscle_group_connections.muscle_group_id;

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








