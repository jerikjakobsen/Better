CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    email VARCHAR(256) NOT NULL UNIQUE,
    hash_pass VARCHAR(256) NOT NULL,
    salt VARCHAR(256) NOT NULL,
    name VARCHAR(64) NOT NULL
    );

CREATE TABLE IF NOT EXISTS weight (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_UUID(),
    weight_number FLOAT NOT NULL,
    creator_user_id UUID NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (creator_user_id) REFERENCES users(id)
    );

CREATE TABLE IF NOT EXISTS routine (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    name VARCHAR(256) NOT NULL,
    current_routine_number INTEGER NOT NULL DEFAULT 1,
    break_days INTEGER NOT NULL DEFAULT 1, -- The number of days before you break a streak / number of rest days
    creator_user_id UUID NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (creator_user_id) REFERENCES users(id)
    );

CREATE TABLE IF NOT EXISTS exercise (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    name VARCHAR(256) NOT NULL, 
    link VARCHAR(512) DEFAULT '',
    default_break_time INTERVAL, -- The default time break between sets
    description VARCHAR(2560) DEFAULT '',
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    creator_user_id UUID DEFAULT NULL,
    is_official BOOLEAN DEFAULT false,
    FOREIGN KEY (creator_user_id) REFERENCES users(id)
    );

CREATE TABLE IF NOT EXISTS day (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    routine_id UUID NOT NULL,
    day_order INTEGER NOT NULL,
    name VARCHAR(256) NOT NULL,
    FOREIGN KEY (routine_id) REFERENCES routine(id)
    ); 

CREATE TABLE IF NOT EXISTS routine_exercise (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    exercise_id UUID NOT NULL,
    routine_id UUID NOT NULL,
    day_id UUID NOT NULL, 
    break_time INTEGER NOT NULL DEFAULT 0, -- The time break the user designates for this specific exercise in this specific routine/day
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (exercise_id) REFERENCES exercise(id),
    FOREIGN KEY (routine_id) REFERENCES routine(id),
    FOREIGN KEY (day_id) REFERENCES day(id)
    );

CREATE TABLE IF NOT EXISTS muscle_group (
    name VARCHAR(256) NOT NULL UNIQUE,
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp
    );

CREATE TABLE IF NOT EXISTS exercise_muscle_group (
    exercise_id UUID NOT NULL,
    muscle_group_id UUID NOT NULL,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (exercise_id) REFERENCES exercise(id),
    FOREIGN KEY (muscle_group_id) REFERENCES muscle_group(id),
    PRIMARY KEY (exercise_id, muscle_group_id)
    );
 
CREATE TABLE IF NOT EXISTS training_session (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    time_start TIMESTAMPTZ NOT NULL,
    time_end TIMESTAMPTZ,
    routine_id UUID NOT NULL,
    day_id UUID NOT NULL,
    routine_number INTEGER NOT NULL,
    current_streak INTEGER NOT NULL DEFAULT 1,
    is_end_of_streak BOOLEAN NOT NULL DEFAULT false,
    created TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    FOREIGN KEY (routine_id) REFERENCES routine(id),
    FOREIGN KEY (day_id) REFERENCES day(id)
    );

CREATE TABLE IF NOT EXISTS exercise_session (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    routine_exercise_id UUID NOT NULL,
    training_session_id UUID NOT NULL,
    time_start TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    time_end TIMESTAMPTZ,
    FOREIGN KEY (routine_exercise_id) REFERENCES routine_exercise(id),
    FOREIGN KEY (training_session_id) REFERENCES training_session(id)
    );

CREATE TABLE IF NOT EXISTS set_session (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    exercise_session_id UUID NOT NULL,
    time_start TIMESTAMPTZ NOT NULL DEFAULT current_timestamp,
    time_end TIMESTAMPTZ,
    number_of_reps INTEGER NOT NULL DEFAULT 0,
    weight INTEGER NOT NULL DEFAULT 0,
    FOREIGN KEY (exercise_session_id) REFERENCES exercise_session(id)
    );

CREATE TABLE IF NOT EXISTS note (
    id UUID PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    content VARCHAR(4096) NOT NULL,
    exercise_session_id UUID NOT NULL,
    FOREIGN KEY (exercise_session_id) REFERENCES exercise_session(id)
    );

GRANT INSERT, UPDATE, SELECT, DELETE 
ON ALL TABLES IN SCHEMA public
TO better;


GRANT INSERT, UPDATE, SELECT, DELETE 
ON ALL TABLES IN SCHEMA public
TO better;








